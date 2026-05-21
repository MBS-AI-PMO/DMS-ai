import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { TranslateModule } from '@ngx-translate/core';
import { ToastrService } from 'ngx-toastr';
import { BaseComponent } from '../base.component';
import { TranslationService } from '@core/services/translation.service';
import { FeatherModule } from 'angular-feather';

// Angular Material Imports
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatListModule } from '@angular/material/list';
import { MatMenuModule } from '@angular/material/menu';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatCardModule } from '@angular/material/card';
import { MatTabsModule } from '@angular/material/tabs';
import { MatSelectModule } from '@angular/material/select';
import { MatOptionModule } from '@angular/material/core';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { forkJoin } from 'rxjs';
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

interface ProposalFileViewModel extends ProposalFile {
  displayLabel: string;
}

type CandidateStage = 'cv_received' | 'shortlisted' | 'interview_scheduled' | 'approved' | 'rejected' | 'selected';
type InterviewLevel = 'basic' | 'intermediate' | 'advanced';

interface ProposalCandidate {
  id: string;
  postId: string;
  candidateName: string;
  candidateCode?: string;
  phone?: string;
  email?: string;
  cvOriginalName?: string;
  hasCv: boolean;
  stage: CandidateStage;
  interviewLevel?: InterviewLevel;
  interviewDate?: string;
  analysisNotes?: string;
  createdDate: string;
}

interface ProposalPost {
  id: string;
  title: string;
  department?: string;
  description?: string;
  createdDate: string;
  candidates: ProposalCandidate[];
}

interface ProposalDashboardData {
  rootFolderId: string;
  folders: ProposalFolder[];
  files: ProposalFile[];
  fileRequests: ProposalFileRequest[];
  posts: ProposalPost[];
}

@Component({
  selector: 'app-proposal-management',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    TranslateModule,
    FeatherModule,
    MatButtonModule,
    MatIconModule,
    MatListModule,
    MatMenuModule,
    MatInputModule,
    MatFormFieldModule,
    MatCardModule,
    MatTabsModule,
    MatSelectModule,
    MatOptionModule,
    MatCheckboxModule
  ],
  templateUrl: './proposal-management.component.html',
  styleUrl: './proposal-management.component.scss',
})
export class ProposalManagementComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly toastrService = inject(ToastrService);
  private readonly translationService = inject(TranslationService);
  private readonly fileRequestBaseUrl = `${window.location.protocol}//${window.location.host}/file-requests/preview/`;

  rootFolderId = '';
  folders: ProposalFolder[] = [];
  files: ProposalFile[] = [];
  fileRequests: ProposalFileRequest[] = [];
  posts: ProposalPost[] = [];
  currentFolderId = '';
  loading = false;

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
  activeAction: 'subfolder' | null = null;
  selectedManagementTabIndex = 0;
  selectedTabIndex = 0;
  fileTypes: { key: string; value: number }[] = [];
  fileSizeOptions = Object.keys(FileSizes)
    .filter((key) => isNaN(Number(key)))
    .map((key) => FileSizes[key as keyof typeof FileSizes]);

  selectedPostId = '';
  newPostTitle = '';
  newPostDepartment = '';
  newPostDescription = '';
  newCandidateName = '';
  newCandidateCode = '';
  newCandidatePhone = '';
  newCandidateEmail = '';
  newCandidateCv: File | null = null;
  readonly candidateStages: CandidateStage[] = [
    'cv_received',
    'shortlisted',
    'interview_scheduled',
    'approved',
    'rejected',
    'selected',
  ];
  readonly interviewLevels: InterviewLevel[] = ['basic', 'intermediate', 'advanced'];

  ngOnInit(): void {
    this.selectedManagementTabIndex = window.location.pathname.includes('post-management') ? 1 : 0;
    this.fileTypes = this.getEnumValues(FileType);
    this.loadData();
  }

  loadData(): void {
    this.loading = true;
    this.sub$.sink = this.httpClient
      .get<ProposalDashboardData>('proposal-management')
      .subscribe({
        next: (response) => {
          this.rootFolderId = response.rootFolderId;
          this.folders = response.folders;
          this.files = response.files;
          this.fileRequests = response.fileRequests;
          this.posts = response.posts || [];
          this.currentFolderId = this.currentFolderId || response.rootFolderId;
          if (!this.folders.find((folder) => folder.id === this.currentFolderId)) {
            this.currentFolderId = response.rootFolderId;
          }
          if (!this.selectedPostId && this.posts.length) {
            this.selectedPostId = this.posts[0].id;
          }
          if (this.selectedPostId && !this.posts.find((post) => post.id === this.selectedPostId)) {
            this.selectedPostId = this.posts[0]?.id || '';
          }
          this.loading = false;
        },
        error: () => {
          this.loading = false;
        },
      });
  }

  createPost(): void {
    if (!this.newPostTitle.trim()) {
      return;
    }

    this.sub$.sink = this.httpClient
      .post<ProposalPost>('proposal-management/posts', {
        title: this.newPostTitle.trim(),
        department: this.newPostDepartment.trim(),
        description: this.newPostDescription.trim(),
      })
      .subscribe((post) => {
        this.toastrService.success('Post created successfully');
        this.newPostTitle = '';
        this.newPostDepartment = '';
        this.newPostDescription = '';
        this.selectedPostId = post.id;
        this.loadData();
      });
  }

  selectPost(postId: string): void {
    this.selectedPostId = postId;
  }

  onCandidateCvSelected(file: File | null): void {
    this.newCandidateCv = file;
  }

  createCandidate(): void {
    if (!this.selectedPostId || !this.newCandidateName.trim()) {
      return;
    }

    const formData = new FormData();
    formData.append('candidateName', this.newCandidateName.trim());
    formData.append('candidateCode', this.newCandidateCode.trim());
    formData.append('phone', this.newCandidatePhone.trim());
    formData.append('email', this.newCandidateEmail.trim());
    if (this.newCandidateCv) {
      formData.append('cv', this.newCandidateCv);
    }

    this.sub$.sink = this.httpClient
      .post(`proposal-management/posts/${this.selectedPostId}/candidates`, formData)
      .subscribe(() => {
        this.toastrService.success('Candidate added successfully');
        this.resetCandidateForm();
        this.loadData();
      });
  }

  updateCandidate(candidate: ProposalCandidate, changes: Partial<ProposalCandidate>): void {
    this.sub$.sink = this.httpClient
      .put(`proposal-management/candidates/${candidate.id}`, {
        stage: changes.stage || candidate.stage,
        interviewLevel: changes.interviewLevel || candidate.interviewLevel,
        interviewDate: changes.interviewDate || candidate.interviewDate,
        analysisNotes: changes.analysisNotes ?? candidate.analysisNotes,
      })
      .subscribe(() => {
        this.toastrService.success('Candidate updated successfully');
        this.loadData();
      });
  }

  openCandidateCv(candidate: ProposalCandidate): void {
    if (!candidate.hasCv) {
      return;
    }

    this.sub$.sink = this.httpClient
      .get(`proposal-management/candidates/${candidate.id}/cv`, { responseType: 'blob' })
      .subscribe((blob) => {
        const fileUrl = window.URL.createObjectURL(blob);
        window.open(fileUrl, '_blank');
        setTimeout(() => window.URL.revokeObjectURL(fileUrl), 60_000);
      });
  }

  createSubfolder(): void {
    if (!this.newSubfolderName.trim()) {
      return;
    }

    this.sub$.sink = this.httpClient
      .post('proposal-management/folders', {
        name: this.newSubfolderName.trim(),
        parentFolderId: this.currentFolderId || this.rootFolderId,
      })
      .subscribe(() => {
        this.toastrService.success(this.translationService.getValue('FOLDER_CREATED_SUCCESSFULLY'));
        this.newSubfolderName = '';
        this.activeAction = null;
        this.loadData();
      });
  }

  createProposal(): void {
    if (!this.newProposalName.trim()) {
      return;
    }

    this.sub$.sink = this.httpClient
      .post('proposal-management/folders', {
        name: this.newProposalName.trim(),
        parentFolderId: this.rootFolderId,
      })
      .subscribe(() => {
        this.toastrService.success(this.translationService.getValue('FOLDER_CREATED_SUCCESSFULLY'));
        this.newProposalName = '';
        this.loadData();
      });
  }

  onFileSelectedForRow(file: File | null, rowIndex: number): void {
    this.uploadRows[rowIndex] = file;
  }

  addUploadRow(): void {
    this.uploadRows.push(null);
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
      return;
    }

    const uploadRequests = filesToUpload.map((selectedFile) => {
      const formData = new FormData();
      formData.append('file', selectedFile);
      formData.append('folderId', this.currentFolderId || this.rootFolderId);
      return this.httpClient.post('proposal-management/files', formData);
    });

    this.sub$.sink = forkJoin(uploadRequests).subscribe(() => {
      this.toastrService.success(this.translationService.getValue('FILE_UPLOADED_SUCCESSFULLY'));
      this.uploadRows = [null];
      this.loadData();
    });
  }

  openFile(file: ProposalFileViewModel): void {
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
      return;
    }

    this.sub$.sink = this.httpClient
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
        folderId: this.currentFolderId || this.rootFolderId,
      })
      .subscribe(() => {
        this.toastrService.success(this.translationService.getValue('FILE_REQUEST_CREATED_SUCCESSFULLY'));
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
        this.loadData();
      });
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

  get currentFolderFiles(): ProposalFile[] {
    return this.files.filter((file) => file.folderId === this.currentFolderId);
  }

  get visibleFiles(): ProposalFileViewModel[] {
    if (!this.currentFolderId || this.isRootView) {
      return [];
    }

    const folderTrail = this.getFolderTrailIds(this.currentFolderId);
    return this.files
      .filter((file) => folderTrail.includes(file.folderId))
      .map((file) => ({
        ...file,
        displayLabel: this.buildFileLabel(file),
      }));
  }

  get currentFolderFileRequests(): ProposalFileRequest[] {
    return this.fileRequests.filter((fileRequest) => fileRequest.folderId === this.currentFolderId);
  }

  get selectedPost(): ProposalPost | null {
    return this.posts.find((post) => post.id === this.selectedPostId) || null;
  }

  get selectedPostCandidates(): ProposalCandidate[] {
    return this.selectedPost?.candidates || [];
  }

  get breadcrumbFolders(): ProposalFolder[] {
    const breadcrumb: ProposalFolder[] = [];
    let folder = this.currentFolder;

    while (folder) {
      breadcrumb.unshift(folder);
      if (!folder.parentFolderId) {
        break;
      }
      folder = this.folders.find((item) => item.id === folder?.parentFolderId) || null;
    }

    return breadcrumb;
  }

  openFolder(folderId: string): void {
    this.currentFolderId = folderId;
    this.activeAction = null;
  }

  openParentFolder(): void {
    if (!this.currentFolder?.parentFolderId) {
      return;
    }
    this.currentFolderId = this.currentFolder.parentFolderId;
    this.activeAction = null;
  }

  showAction(action: 'subfolder'): void {
    this.activeAction = action;
  }

  getEnumValues(enumObj: any): { key: string; value: number }[] {
    return Object.keys(enumObj)
      .filter((key) => isNaN(Number(key)))
      .map((key) => ({
        key,
        value: enumObj[key],
      }));
  }

  getFileSizeLabel(sizeInMb: number): string {
    if (sizeInMb === FileSizes.GreaterThan100MB) {
      return '> 100 MB';
    }
    return `< ${sizeInMb} MB`;
  }

  getStageLabel(stage: CandidateStage): string {
    const stageLabels: Record<CandidateStage, string> = {
      cv_received: 'CV Received',
      shortlisted: 'Shortlisted',
      interview_scheduled: 'Interview Scheduled',
      approved: 'Approved',
      rejected: 'Rejected',
      selected: 'Selected',
    };
    return stageLabels[stage];
  }

  getStageBadgeClass(stage: CandidateStage): string {
    const badgeClasses: Record<CandidateStage, string> = {
      cv_received: 'bg-secondary',
      shortlisted: 'bg-info',
      interview_scheduled: 'bg-primary',
      approved: 'bg-warning text-dark',
      rejected: 'bg-danger',
      selected: 'bg-success',
    };
    return badgeClasses[stage];
  }

  getInterviewLevelLabel(level?: InterviewLevel): string {
    if (!level) {
      return 'Not selected';
    }
    return level.charAt(0).toUpperCase() + level.slice(1);
  }

  resetCandidateForm(): void {
    this.newCandidateName = '';
    this.newCandidateCode = '';
    this.newCandidatePhone = '';
    this.newCandidateEmail = '';
    this.newCandidateCv = null;
  }

  private getFolderTrailIds(folderId: string): string[] {
    const result = [folderId];
    const queue = [folderId];

    while (queue.length) {
      const currentId = queue.shift() as string;
      const children = this.folders.filter((folder) => folder.parentFolderId === currentId);
      children.forEach((child) => {
        result.push(child.id);
        queue.push(child.id);
      });
    }

    return result;
  }

  private buildFileLabel(file: ProposalFile): string {
    if (file.folderId === this.currentFolderId) {
      return file.displayTitle || file.title;
    }

    const parentFolder = this.folders.find((folder) => folder.id === file.folderId);
    if (!parentFolder) {
      return file.displayTitle || file.title;
    }

    return `${parentFolder.name}/${file.displayTitle || file.title}`;
  }
}
