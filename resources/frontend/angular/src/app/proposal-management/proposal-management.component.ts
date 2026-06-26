import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { ChangeDetectorRef, Component, OnInit, ViewEncapsulation, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { TranslateModule } from '@ngx-translate/core';
import { ToastrService } from 'ngx-toastr';
import { BaseComponent } from '../base.component';
import { TranslationService } from '@core/services/translation.service';
import { forkJoin, timeout, throwError } from 'rxjs';
import { catchError, finalize } from 'rxjs/operators';
import { FileType } from '@core/domain-classes/file-type.enum';
import { FileSizes } from '@core/domain-classes/file-sizes.enum';

interface ProposalFolder {
  id: string;
  name: string;
  parentFolderId: string | null;
}

interface ProposalFile {
  id: string;
  folderId: string;
  title: string;
  displayTitle: string;
  originalName?: string;
  url?: string;
  createdDate: string;
}

interface ProposalFileRequest {
  id: string;
  folderId: string;
  fileRequestId?: string;
  title: string;
  email?: string;
  description: string;
  maxDocument?: number;
  sizeInMb?: number;
  allowExtension?: string;
  hasPassword?: boolean;
  password?: string;
  linkExpiryTime?: string;
  status: string;
  createdDate: string;
}

interface ProposalDashboardData {
  rootFolderId: string;
  folders: ProposalFolder[];
  files: ProposalFile[];
  fileRequests?: ProposalFileRequest[];
  filerequests?: ProposalFileRequest[];
}

type ProposalAction = 'proposal' | 'subfolder' | null;
type UploadPanel = 'upload' | 'request';

@Component({
  selector: 'app-proposal-management',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    TranslateModule,
  ],
  templateUrl: './proposal-management.component.html',
  styleUrl: './proposal-management.component.scss',
  encapsulation: ViewEncapsulation.Emulated,
})
export class ProposalManagementComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly toastrService = inject(ToastrService);
  private readonly translationService = inject(TranslationService);
  private readonly changeDetectorRef = inject(ChangeDetectorRef);
  private readonly fileRequestBaseUrl = `${window.location.protocol}//${window.location.host}/file-requests/preview/`;

  rootFolderId = '';
  folders: ProposalFolder[] = [];
  files: ProposalFile[] = [];
  fileRequests: ProposalFileRequest[] = [];
  currentFolderId = '';
  loading = false;
  savingSubfolder = false;
  savingProposal = false;
  uploading = false;
  savingFileRequest = false;

  newProposalName = '';
  newSubfolderName = '';
  newRequestTitle = '';
  newRequestDescription = '';
  newRequestEmail = '';
  newRequestMaxDocument = 1;
  newRequestSizeInMb = FileSizes.LessThan5MB;
  newRequestFileTypes: number[] = [];
  newRequestHasPassword = false;
  newRequestPassword = '';
  newRequestIsLinkExpiryTime = false;
  newRequestLinkExpiryTime = '';
  uploadRows: Array<File | null> = [null];
  activeAction: ProposalAction = null;
  uploadPanel: UploadPanel = 'upload';
  fileTypes: { key: string; value: number }[] = [];
  fileSizeOptions = Object.keys(FileSizes)
    .filter((key) => isNaN(Number(key)))
    .map((key) => FileSizes[key as keyof typeof FileSizes]);

  ngOnInit(): void {
    this.fileTypes = this.getEnumValues(FileType);
    this.loadData(true);
  }

  loadData(showFullPageLoader = false): void {
    if (showFullPageLoader) {
      this.loading = true;
    }

    this.sub$.add(
      this.httpClient
        .get<ProposalDashboardData>('proposal-management/dashboard')
        .pipe(
          timeout(30000),
          catchError((err) => {
            if (err?.name === 'TimeoutError') {
              return throwError(() => ({
                error: { message: 'Request timed out. Please check MySQL is running and try again.' },
              }));
            }

            return throwError(() => err);
          }),
          finalize(() => {
            this.loading = false;
            this.changeDetectorRef.detectChanges();
          })
        )
        .subscribe({
          next: (response) => {
            this.rootFolderId = response.rootFolderId;
            this.folders = response.folders || [];
            this.files = response.files || [];
            this.fileRequests = response.fileRequests || response.filerequests || [];
            this.currentFolderId = this.currentFolderId || response.rootFolderId;

            if (!this.folders.find((folder) => folder.id === this.currentFolderId)) {
              this.currentFolderId = response.rootFolderId;
            }

            this.changeDetectorRef.detectChanges();
          },
          error: (err) => {
            this.handleApiError(err, 'Failed to load proposal data');
          },
        })
    );
  }

  createSubfolder(): void {
    const folderName = this.newSubfolderName.trim();
    if (!folderName) {
      this.toastrService.error('Please enter folder name');
      return;
    }

    const parentFolderId = this.getActiveFolderId();
    if (!parentFolderId) {
      this.toastrService.error('Folder context is missing. Please refresh the page.');
      return;
    }

    if (this.savingSubfolder) {
      return;
    }

    this.savingSubfolder = true;
    this.sub$.add(
      this.httpClient
        .post('proposal-management/folders', {
          name: folderName,
          parentFolderId,
        })
        .subscribe({
          next: () => {
            this.savingSubfolder = false;
            this.toastrService.success(this.translationService.getValue('FOLDER_CREATED_SUCCESSFULLY') || 'Folder created successfully');
            this.newSubfolderName = '';
            this.activeAction = null;
            this.loadData();
          },
          error: (err) => {
            this.savingSubfolder = false;
            this.handleApiError(err, 'Failed to create folder');
          },
        })
    );
  }

  createProposal(): void {
    const proposalName = this.newProposalName.trim();
    if (!proposalName) {
      this.toastrService.error('Please enter proposal name');
      return;
    }

    if (!this.rootFolderId) {
      this.toastrService.error('Proposal root folder is missing. Please refresh the page.');
      return;
    }

    if (this.savingProposal) {
      return;
    }

    this.savingProposal = true;
    this.sub$.add(
      this.httpClient
        .post('proposal-management/folders', {
          name: proposalName,
          parentFolderId: this.rootFolderId,
        })
        .subscribe({
          next: () => {
            this.savingProposal = false;
            this.toastrService.success(this.translationService.getValue('FOLDER_CREATED_SUCCESSFULLY') || 'Folder created successfully');
            this.newProposalName = '';
            this.activeAction = null;
            this.loadData();
          },
          error: (err) => {
            this.savingProposal = false;
            this.handleApiError(err, 'Failed to create proposal');
          },
        })
    );
  }

  onFileSelectedForRow(file: File | null, rowIndex: number): void {
    const rows = [...this.uploadRows];
    rows[rowIndex] = file;
    this.uploadRows = rows;
    this.changeDetectorRef.markForCheck();
  }

  addUploadRow(): void {
    this.uploadRows = [...this.uploadRows, null];
    this.changeDetectorRef.markForCheck();
  }

  trackUploadRow(index: number): number {
    return index;
  }

  removeUploadRow(rowIndex: number): void {
    if (this.uploadRows.length === 1) {
      this.uploadRows[0] = null;
      return;
    }

    this.uploadRows.splice(rowIndex, 1);
  }

  uploadFile(): void {
    const filesToUpload = this.uploadRows.filter((file): file is File => !!file);
    if (!filesToUpload.length) {
      this.toastrService.error('Please select a file to upload');
      return;
    }

    const folderId = this.getActiveFolderId();
    if (!folderId) {
      this.toastrService.error('Folder context is missing. Please refresh the page.');
      return;
    }

    if (this.uploading) {
      return;
    }

    this.uploading = true;
    const uploadRequests = filesToUpload.map((selectedFile) => {
      const formData = new FormData();
      formData.append('file', selectedFile);
      formData.append('folderId', folderId);
      return this.httpClient.post('proposal-management/files', formData);
    });

    this.sub$.add(
      forkJoin(uploadRequests).subscribe({
        next: () => {
          this.uploading = false;
          this.toastrService.success(this.translationService.getValue('FILE_UPLOADED_SUCCESSFULLY') || 'File uploaded successfully');
          this.uploadRows = [null];
          this.loadData();
        },
        error: (err) => {
          this.uploading = false;
          this.handleApiError(err, 'Failed to upload file');
        },
      })
    );
  }

  openFile(file: ProposalFile): void {
    this.sub$.sink = this.httpClient
      .get(`proposal-management/files/${file.id}/open`, { responseType: 'blob' })
      .subscribe((blob) => {
        const fileUrl = window.URL.createObjectURL(blob);
        window.open(fileUrl, '_blank');
        setTimeout(() => window.URL.revokeObjectURL(fileUrl), 60_000);
      });
  }

  openFileRequest(request: ProposalFileRequest): void {
    if (!request.fileRequestId) {
      return;
    }

    window.open(`${this.fileRequestBaseUrl}${request.fileRequestId}`, '_blank');
  }

  createFileRequest(): void {
    if (!this.newRequestTitle.trim()) {
      this.toastrService.error('Please enter subject for file request');
      return;
    }

    const folderId = this.getActiveFolderId();
    if (!folderId) {
      this.toastrService.error('Folder context is missing. Please refresh the page.');
      return;
    }

    if (this.savingFileRequest) {
      return;
    }

    this.savingFileRequest = true;
    this.sub$.add(
      this.httpClient
        .post('proposal-management/file-requests', {
          title: this.newRequestTitle.trim(),
          description: this.newRequestDescription.trim(),
          email: this.newRequestEmail?.trim() || null,
          maxDocument: this.newRequestMaxDocument,
          sizeInMb: this.newRequestSizeInMb,
          fileExtension: this.newRequestFileTypes,
          hasPassword: this.newRequestHasPassword,
          password: this.newRequestHasPassword ? this.newRequestPassword : null,
          linkExpiryTime: this.newRequestIsLinkExpiryTime ? this.newRequestLinkExpiryTime : null,
          baseUrl: this.fileRequestBaseUrl,
          folderId,
        })
        .subscribe({
          next: () => {
            this.savingFileRequest = false;
            this.toastrService.success(this.translationService.getValue('FILE_REQUEST_CREATED_SUCCESSFULLY') || 'File request created successfully');
            this.resetFileRequestForm();
            this.loadData();
          },
          error: (err) => {
            this.savingFileRequest = false;
            this.handleApiError(err, 'Failed to create file request');
          },
        })
    );
  }

  resetFileRequestForm(): void {
    this.newRequestTitle = '';
    this.newRequestDescription = '';
    this.newRequestEmail = '';
    this.newRequestMaxDocument = 1;
    this.newRequestSizeInMb = FileSizes.LessThan5MB;
    this.newRequestFileTypes = [];
    this.newRequestHasPassword = false;
    this.newRequestPassword = '';
    this.newRequestIsLinkExpiryTime = false;
    this.newRequestLinkExpiryTime = '';
  }

  get isRootView(): boolean {
    return this.currentFolderId === this.rootFolderId;
  }

  get currentFolder(): ProposalFolder | null {
    return this.folders.find((folder) => folder.id === this.currentFolderId) || null;
  }

  get proposalFolders(): ProposalFolder[] {
    return this.folders
      .filter((folder) => folder.parentFolderId === this.rootFolderId)
      .sort((a, b) => a.name.localeCompare(b.name));
  }

  get childFolders(): ProposalFolder[] {
    return this.folders
      .filter((folder) => folder.parentFolderId === this.currentFolderId)
      .sort((a, b) => a.name.localeCompare(b.name));
  }

  get currentFolderDirectFiles(): ProposalFile[] {
    return this.getFilesForFolder(this.currentFolderId);
  }

  get currentFolderFileRequests(): ProposalFileRequest[] {
    return this.fileRequests
      .filter((fileRequest) => fileRequest.folderId === this.currentFolderId)
      .sort((a, b) => b.createdDate.localeCompare(a.createdDate));
  }

  get breadcrumbFolders(): ProposalFolder[] {
    const breadcrumb: ProposalFolder[] = [];
    let folder = this.currentFolder;

    while (folder && folder.id !== this.rootFolderId) {
      breadcrumb.unshift(folder);
      if (!folder.parentFolderId || folder.parentFolderId === this.rootFolderId) {
        break;
      }
      folder = this.folders.find((item) => item.id === folder?.parentFolderId) || null;
    }

    return breadcrumb;
  }

  getFilesForFolder(folderId: string): ProposalFile[] {
    return this.files
      .filter((file) => file.folderId === folderId)
      .sort((a, b) => b.createdDate.localeCompare(a.createdDate));
  }

  getFileDisplayLabel(file: ProposalFile, folder?: ProposalFolder | null): string {
    if (folder) {
      return `${folder.name} / ${file.title}`;
    }

    return file.displayTitle || file.title;
  }

  openFolder(folderId: string): void {
    this.currentFolderId = folderId;
    this.activeAction = null;
    this.uploadPanel = 'upload';
    this.uploadRows = [null];
  }

  openParentFolder(): void {
    if (!this.currentFolder?.parentFolderId) {
      return;
    }

    this.currentFolderId = this.currentFolder.parentFolderId;
    this.activeAction = null;
    this.uploadPanel = 'upload';
    this.uploadRows = [null];
  }

  setUploadPanel(panel: UploadPanel): void {
    this.uploadPanel = panel;
  }

  onDragOver(event: DragEvent): void {
    event.preventDefault();
    event.stopPropagation();
  }

  onFileDrop(event: DragEvent, rowIndex: number): void {
    event.preventDefault();
    event.stopPropagation();

    const file = event.dataTransfer?.files?.[0] || null;
    this.onFileSelectedForRow(file, rowIndex);
  }

  showAction(action: Exclude<ProposalAction, null>): void {
    this.activeAction = action;
  }

  cancelAction(): void {
    this.activeAction = null;
    this.newProposalName = '';
    this.newSubfolderName = '';
  }

  getEnumValues(enumObj: Record<string, number | string>): { key: string; value: number }[] {
    return Object.keys(enumObj)
      .filter((key) => isNaN(Number(key)))
      .map((key) => ({
        key,
        value: enumObj[key] as number,
      }));
  }

  getFileSizeLabel(sizeInMb: number): string {
    if (sizeInMb === FileSizes.GreaterThan100MB) {
      return '> 100 MB';
    }

    return `< ${sizeInMb} MB`;
  }

  private getActiveFolderId(): string {
    return this.currentFolderId || this.rootFolderId;
  }

  private handleApiError(
    error: {
      error?: {
        message?: string;
        Message?: string;
        errors?: Record<string, string[]>;
      };
      message?: string;
      status?: number;
    },
    fallback: string
  ): void {
    const validationErrors = error?.error?.errors;
    if (validationErrors) {
      const messages = Object.values(validationErrors)
        .flat()
        .filter((message): message is string => !!message);
      if (messages.length) {
        this.toastrService.error(messages.join('\n'));
        return;
      }
    }

    const message =
      error?.error?.message ||
      error?.error?.Message ||
      (Array.isArray(error?.error) ? error.error[0] : undefined) ||
      error?.message ||
      fallback;

    this.toastrService.error(message);
  }
}
