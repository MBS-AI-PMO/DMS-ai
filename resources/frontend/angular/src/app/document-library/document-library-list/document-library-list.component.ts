import { HttpResponse } from '@angular/common/http';
import { AfterViewInit, Component, ElementRef, inject, OnInit, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { MatSort } from '@angular/material/sort';
import { ResponseHeader } from '@core/domain-classes/document-header';
import { DocumentInfo } from '@core/domain-classes/document-info';
import { DocumentResource } from '@core/domain-classes/document-resource';
import { OverlayPanel } from '@shared/overlay-panel/overlay-panel.service';
import { fromEvent, merge } from 'rxjs';
import { debounceTime, distinctUntilChanged, tap } from 'rxjs/operators';
import { BaseComponent } from 'src/app/base.component';
import { DocumentLibraryService } from '../document-library.service';
import { DocumentLibraryDataSource } from './document-library-datasource';
import { SelectionModel } from '@angular/cdk/collections';
import { BasePreviewComponent } from '@shared/base-preview/base-preview.component';
import { DocumentView } from '@core/domain-classes/document-view';
import { DocumentReminderComponent } from '../document-reminder/document-reminder.component';
import { AddDocumentComponent } from '../add-document/add-document.component';
import { ReminderListComponent } from '../reminder-list/reminder-list.component';
import { DocumentCommentComponent } from 'src/app/document/document-comment/document-comment.component';
import { ClonerService } from '@core/services/clone.service';
import { DocumentVersion } from '@core/domain-classes/documentVersion';
import { DocumentVersionHistoryComponent } from 'src/app/document/document-version-history/document-version-history.component';
import { DocumentService } from 'src/app/document/document.service';
import { DocumentAuditTrail } from '@core/domain-classes/document-audit-trail';
import { DocumentOperation } from '@core/domain-classes/document-operation';
import { TranslationService } from '@core/services/translation.service';
import { CommonService } from '@core/services/common.service';
import { ToastrService } from 'ngx-toastr';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { DocumentEditComponent } from 'src/app/document/document-edit/document-edit.component';
import { DocumentCategory } from '@core/domain-classes/document-category';
import { DocumentPermissionListComponent } from 'src/app/document/document-permission/document-permission-list/document-permission-list.component';
import { DocumentUploadNewVersionComponent } from 'src/app/document/document-upload-new-version/document-upload-new-version.component';
import { SendEmailComponent } from 'src/app/document/send-email/send-email.component';
import { CommonDialogService } from '@core/common-dialog/common-dialog.service';
import { Direction } from '@angular/cdk/bidi';
import { DocumentDeleteDialogComponent } from 'src/app/document-delete-dialog/document-delete-dialog.component';
import { DMS_CONFIRM_DIALOG_CONFIG } from '@core/common-dialog/confirm-dialog.config';
import {
  DMS_DOCUMENT_COMMENT_DIALOG_CONFIG,
  DMS_DOCUMENT_EDIT_DIALOG_CONFIG,
} from '@core/common-dialog/form-dialog.config';
import { DocumentShareableLink } from '@core/domain-classes/document-shareable-link';
import { SharableLinkComponent } from 'src/app/document/sharable-link/sharable-link.component';
import { ClientStore } from 'src/app/client/client-store';
import { DocumentStatusStore } from 'src/app/document-status/store/document-status.store';
import { CategoryStore } from 'src/app/category/store/category-store';
import { DocumentWorkflow } from '@core/domain-classes/document-workflow';
import { DocumentWorkflowDialogComponent } from 'src/app/document/document-workflow-dialog/document-workflow-dialog.component';
import { VisualWorkflowInstance } from '@core/domain-classes/visual-workflow-instance';
import { VisualWorkflowGraphComponent } from 'src/app/workflows/visual-workflow-graph/visual-workflow-graph.component';
import { DMS_WORKFLOW_VIEW_DIALOG_CONFIG } from 'src/app/workflows/workflow-view-dialog.config';
import { DocumentWorkflowService } from 'src/app/workflows/manage-workflow/document-workflow.service';
import { DocumentSignatureComponent } from '@shared/document-signature/document-signature.component';
import { AiDocumentSummaryComponent } from 'src/app/open-ai/ai-document-summary/ai-document-summary.component';
import { DocumentWatermarkComponent } from 'src/app/document/document-watermark/document-watermark.component';

@Component({
  selector: 'app-document-library-list',
  templateUrl: './document-library-list.component.html',
  styleUrls: ['./document-library-list.component.scss'],
})
export class DocumentLibraryListComponent extends BaseComponent implements OnInit, AfterViewInit {
  dataSource: DocumentLibraryDataSource;
  documents: DocumentInfo[] = [];
  displayedColumns: string[] = [
    'action',
    'name',
    'categoryName',
    'createdDate',
    'workflowName',
    'location',
    'companyName',
    'statusName',
    'expiredDate',
    'createdBy',
    'signDate',
    'signByUserName'
  ];
  footerToDisplayed = ['footer'];
  documentResource: DocumentResource;
  @ViewChild(MatPaginator) paginator: MatPaginator;
  @ViewChild(MatSort) sort: MatSort;
  @ViewChild('input') input: ElementRef;
  @ViewChild('metatag') metatag: ElementRef;
  selection = new SelectionModel<DocumentInfo>(true, []);
  direction: Direction;
  actionDocument: DocumentInfo | null = null;
  documentStatusStore = inject(DocumentStatusStore);
  categoryStore = inject(CategoryStore);
  public clientStore = inject(ClientStore);

  constructor(
    private documentLibraryService: DocumentLibraryService,
    public overlay: OverlayPanel,
    public clonerService: ClonerService,
    private documentService: DocumentService,
    private translationService: TranslationService,
    private commonService: CommonService,
    private toastrService: ToastrService,
    private dialog: MatDialog,
    private commonDialogService: CommonDialogService,
    private documentWorkflowService: DocumentWorkflowService,
    private router: Router
  ) {
    super();
    this.documentResource = new DocumentResource();
    this.documentResource.pageSize = 10;
    this.documentResource.orderBy = 'createdDate desc';
  }

  ngOnInit(): void {
    this.dataSource = new DocumentLibraryDataSource(
      this.documentLibraryService
    );
    this.dataSource.loadDocuments(this.documentResource);
    this.getResourceParameter();
    this.getLangDir();
  }

  getLangDir() {
    this.sub$.sink = this.translationService.lanDir$.subscribe(
      (c: Direction) => (this.direction = c)
    );
  }

  ngAfterViewInit() {
    this.sub$.sink = this.sort.sortChange.subscribe(
      () => (this.paginator.pageIndex = 0)
    );

    this.sub$.sink = merge(this.sort.sortChange, this.paginator.page)
      .pipe(
        tap(() => {
          this.documentResource.skip =
            this.paginator.pageIndex * this.paginator.pageSize;
          this.documentResource.pageSize = this.paginator.pageSize;
          this.documentResource.orderBy =
            this.sort.active + ' ' + this.sort.direction;
          this.dataSource.loadDocuments(this.documentResource);
        })
      )
      .subscribe();

    this.sub$.sink = fromEvent(this.input.nativeElement, 'keyup')
      .pipe(
        debounceTime(1000),
        distinctUntilChanged(),
        tap(() => {
          this.paginator.pageIndex = 0;
          this.documentResource.skip = 0;
          this.documentResource.name = this.input.nativeElement.value;
          this.dataSource.loadDocuments(this.documentResource);
        })
      )
      .subscribe();

    this.sub$.sink = fromEvent(this.metatag.nativeElement, 'keyup')
      .pipe(
        debounceTime(1000),
        distinctUntilChanged(),
        tap(() => {
          this.paginator.pageIndex = 0;
          this.documentResource.skip = 0;
          this.documentResource.metaTags = this.metatag.nativeElement.value;
          this.dataSource.loadDocuments(this.documentResource);
        })
      )
      .subscribe();
  }

  onCategoryChange(filtervalue: string) {
    if (filtervalue) {
      this.documentResource.categoryId = filtervalue;
    } else {
      this.documentResource.categoryId = '';
    }
    this.documentResource.skip = 0;
    this.paginator.pageIndex = 0;
    this.dataSource.loadDocuments(this.documentResource);
  }

  onStorageChange(filtervalue: string) {
    if (filtervalue) {
      this.documentResource.location = filtervalue;
    } else {
      this.documentResource.location = '';
    }
    this.documentResource.skip = 0;
    this.paginator.pageIndex = 0;
    this.dataSource.loadDocuments(this.documentResource);
  }

  onClientChange(filterValue: string) {
    if (filterValue) {
      this.documentResource.clientId = filterValue;
    } else {
      this.documentResource.clientId = '';
    }
    this.documentResource.skip = 0;
    this.paginator.pageIndex = 0;
    this.dataSource.loadDocuments(this.documentResource);
  }

  onDocumentStatusChange(filterValue: string) {
    if (filterValue) {
      this.documentResource.statusId = filterValue;
    } else {
      this.documentResource.statusId = '';
    }
    this.documentResource.skip = 0;
    this.paginator.pageIndex = 0;
    this.dataSource.loadDocuments(this.documentResource);
  }

  getResourceParameter() {
    this.sub$.sink = this.dataSource.responseHeaderSubject$.subscribe(
      (c: ResponseHeader) => {
        if (c) {
          this.documentResource.pageSize = c.pageSize;
          this.documentResource.skip = c.skip;
          this.documentResource.totalCount = c.totalCount;
        }
      }
    );
  }

  getDocuments(): void {
    this.sub$.sink = this.documentLibraryService
      .getDocuments(this.documentResource)
      .subscribe(
        (resp: HttpResponse<DocumentInfo[]>) => {
          const paginationParam = JSON.parse(
            resp.headers.get('X-Pagination')
          ) as ResponseHeader;
          this.documentResource.pageSize = paginationParam.pageSize;
          this.documentResource.skip = paginationParam.skip;
          this.documents = [...resp.body];
        },
      );
  }

  getExpiryDate(
    maxRolePermissionEndDate: Date,
    maxUserPermissionEndDate: Date
  ) {
    if (maxRolePermissionEndDate && maxUserPermissionEndDate) {
      return maxRolePermissionEndDate > maxUserPermissionEndDate
        ? maxRolePermissionEndDate
        : maxUserPermissionEndDate;
    } else if (maxRolePermissionEndDate) {
      return maxRolePermissionEndDate;
    } else if (maxUserPermissionEndDate) {
      return maxUserPermissionEndDate;
    } else {
      return null;
    }
  }

  addReminder(documentInfo: DocumentInfo | null) {
    if (!documentInfo) {
      return;
    }
    this.dialog.open(DocumentReminderComponent, {
      data: documentInfo,
      width: '80vw',
      maxHeight: '90vh',
    });
  }

  onReminderList() {
    this.dialog.open(ReminderListComponent, {
      data: null,
      width: '80vw',
      maxHeight: '80vh',
    });
  }

  onAddDocument() {
    const dialogRef = this.dialog.open(AddDocumentComponent, {
      data: null,
      width: '80vw',
      maxHeight: '80vh',
    });

    this.sub$.sink = dialogRef.afterClosed().subscribe((result: boolean) => {
      if (result) {
        this.dataSource.loadDocuments(this.documentResource);
      }
    });
  }

  onDocumentView(document: DocumentInfo) {
    const urls = document.url.split('.');
    const extension = urls[1];
    const documentView: DocumentView = {
      documentId: document.id,
      name: document.name,
      extension: extension,
      isVersion: false,
      isFromPublicPreview: false,
      isPreviewDownloadEnabled: false,
      isFromFileRequest: false,
    };
    this.overlay.open(BasePreviewComponent, {
      position: 'center',
      origin: 'global',
      panelClass: ['file-preview-overlay-container', 'white-background'],
      data: documentView,
    });
  }

  addDocumentTrail(id: string, operation: string) {
    const objDocumentAuditTrail: DocumentAuditTrail = {
      documentId: id,
      operationName: operation,
    };
    this.sub$.sink = this.commonService
      .addDocumentAuditTrail(objDocumentAuditTrail)
      // eslint-disable-next-line @typescript-eslint/no-empty-function
      .subscribe(() => { });
  }

  addComment(document: DocumentInfo | null) {
    if (!document) {
      return;
    }
    const dialogRef = this.dialog.open(DocumentCommentComponent, {
      ...DMS_DOCUMENT_COMMENT_DIALOG_CONFIG,
      data: Object.assign({}, document),
    });

    this.sub$.sink = dialogRef.afterClosed().subscribe((isCommentChanged: boolean) => {
      if (isCommentChanged) {
        this.dataSource.loadDocuments(this.documentResource);
      }
    });
  }

  setActionDocument(document: DocumentInfo): void {
    this.actionDocument = document;
  }

  openDocumentDetails(): void {
    if (this.actionDocument?.id) {
      void this.router.navigate(['/document-details', this.actionDocument.id]);
    }
  }

  editDocument(documentInfo: DocumentInfo | null) {
    if (!documentInfo) {
      return;
    }
    const documentCategories: DocumentCategory = {
      document: documentInfo,
      categories: this.categoryStore.categories(),
      clients: this.clientStore.clients(),
    };
    const dialogRef = this.dialog.open(DocumentEditComponent, {
      ...DMS_DOCUMENT_EDIT_DIALOG_CONFIG,
      data: Object.assign({}, documentCategories),
    });

    this.sub$.sink = dialogRef.afterClosed().subscribe((result: string) => {
      if (result === 'loaded') {
        this.dataSource.loadDocuments(this.documentResource);
      }
    });
  }

  onVersionHistoryClick(document: DocumentInfo | null): void {
    if (!document) {
      return;
    }
    const documentInfo = this.clonerService.deepClone<DocumentInfo>(document);
    this.sub$.sink = this.documentService
      .getDocumentVersion(document.id)
      .subscribe((documentVersions: DocumentVersion[]) => {
        documentInfo.documentVersions = documentVersions;
        const dialogRef = this.dialog.open(DocumentVersionHistoryComponent, {
          width: '70vw',
          maxHeight: '70vh',
          panelClass: 'full-width-dialog',
          data: Object.assign({}, documentInfo),
        });

        this.sub$.sink = dialogRef.afterClosed().subscribe((result: boolean) => {
          if (result) {
            this.dataSource.loadDocuments(this.documentResource);
          }
        });
      });


  }

  manageDocumentPermission(documentInfo: DocumentInfo | null) {
    if (!documentInfo) {
      return;
    }
    this.dialog.open(DocumentPermissionListComponent, {
      data: documentInfo,
      width: '80vw',
      maxHeight: '80vh',
    });
  }

  uploadNewVersion(document: DocumentInfo | null) {
    if (!document) {
      return;
    }
    const dialogRef = this.dialog.open(DocumentUploadNewVersionComponent, {
      width: '800px',
      maxHeight: '70vh',
      data: Object.assign({}, document),
    });

    this.sub$.sink = dialogRef.afterClosed().subscribe((result: boolean) => {
      if (result) {
        this.dataSource.loadDocuments(this.documentResource);
      }
    });
  }

  sendEmail(documentInfo: DocumentInfo | null) {
    if (!documentInfo) {
      return;
    }
    this.dialog.open(SendEmailComponent, {
      data: documentInfo,
      width: '80vw',
      maxHeight: '80vh',
    });
  }

  archiveDocument(document: DocumentInfo | null) {
    if (!document) {
      return;
    }
    this.sub$.sink = this.commonDialogService
      .deleteConformationDialog(
        this.translationService.getValue('ARE_YOU_SURE_YOU_WANT_TO_ARCHIVE'),
        document.name
      )
      .subscribe((isTrue: boolean) => {
        if (isTrue) {
          this.sub$.sink = this.documentService
            .archiveDocument(document.id)
            .subscribe(() => {
              this.addDocumentTrail(
                document.id,
                DocumentOperation.Archived.toString()
              );
              this.toastrService.success(
                this.translationService.getValue(
                  'DOCUMENT_ARCHIVED_SUCCESSFULLY'
                )
              );
              this.dataSource.loadDocuments(this.documentResource);
            });
        }
      });
  }

  deleteDocument(document: DocumentInfo | null) {
    if (!document) {
      return;
    }
    const dialogRef = this.dialog.open(DocumentDeleteDialogComponent, {
      ...DMS_CONFIRM_DIALOG_CONFIG,
      width: '480px',
      maxHeight: '85vh',
    });

    dialogRef.afterClosed().subscribe((isTrue: boolean) => {
      if (isTrue) {
        this.sub$.sink = this.documentService
          .deleteDocument(document.id)
          .subscribe(() => {
            this.addDocumentTrail(
              document.id,
              DocumentOperation.Deleted.toString()
            );
            this.toastrService.success(
              this.translationService.getValue('DOCUMENT_DELETED_SUCCESSFULLY')
            );
            this.dataSource.loadDocuments(this.documentResource);
          });
      }
    });
  }

  onCreateShareableLink(document: DocumentInfo | null) {
    if (!document) {
      return;
    }
    this.sub$.sink = this.documentService
      .getDocumentShareableLink(document.id)
      .subscribe((link: DocumentShareableLink) => {
        this.dialog.open(SharableLinkComponent, {
          width: '500px',
          data: { document, link },
        });
      });
  }

  manageWorkflowInstance(documentInfo: DocumentInfo | null) {
    if (!documentInfo) {
      return;
    }
    const document = {
      document: documentInfo,
    };
    const dialogRef = this.dialog.open(DocumentWorkflowDialogComponent, {
      width: '40vw',
      maxHeight: '70vh',
      data: Object.assign({}, document),
    });

    this.sub$.sink = dialogRef
      .afterClosed()
      .subscribe((result: DocumentWorkflow) => {
        if (result && result?.workflowId) {
          this.dataSource.loadDocuments(this.documentResource);
        }
      });
  }

  // checkWorkflowInstance(documentInfo: DocumentInfo) {
  //   if (documentInfo?.isWorkflowCompleted) {
  //     return true;
  //   }
  //   return false;
  // }

  viewVisualWorkflow(workflowInstance: DocumentInfo): void {
    this.documentWorkflowService.getRunningVisualWorkflow(workflowInstance.documentWorkflowId)
      .subscribe({
        next: (data: VisualWorkflowInstance) => {
          data.documentId = workflowInstance.id;
          data.documentName = workflowInstance.name;
          this.dialog.open(VisualWorkflowGraphComponent, {
            ...DMS_WORKFLOW_VIEW_DIALOG_CONFIG,
            data: Object.assign({}, data),
          });
        },
        error: (error) => { },
      });
  }

  signDocument(document: DocumentInfo | null) {
    if (!document) {
      return;
    }
    const dialogRef = this.dialog.open(DocumentSignatureComponent, {
      width: '60vw',
      data: Object.assign({}, document),
    });
    dialogRef.afterClosed().subscribe((result: boolean) => {
      if (result) {
        this.dataSource.loadDocuments(this.documentResource);
      }
    });
  }

  generateSummary(document: DocumentInfo | null) {
    if (!document) {
      return;
    }
    this.dialog.open(AiDocumentSummaryComponent, {
      width: '60vw',
      data: Object.assign({}, document),
    });
  }

  watermarkDocument(document: DocumentInfo | null) {
    if (!document) {
      return;
    }
    const dialogRef = this.dialog.open(DocumentWatermarkComponent, {
      width: '500px',
      data: Object.assign({}, document),
    });
    dialogRef.afterClosed().subscribe((result: boolean) => {
      if (result) {
        this.toastrService.success(this.translationService.getValue('WATERMARK_CREATED_SUCCESSFULLY'));
        this.dataSource.loadDocuments(this.documentResource);
      }
    });
  }
}
