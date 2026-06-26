import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule } from '@angular/forms';
import { ClipboardModule } from '@angular/cdk/clipboard';
import { CKEditorModule } from '@ckeditor/ckeditor5-angular';
import { NgSelectModule } from '@ng-select/ng-select';
import {
  OwlDateTimeModule,
  OwlNativeDateTimeModule,
} from 'ng-pick-datetime-ex';
import { MatButtonModule } from '@angular/material/button';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatChipsModule } from '@angular/material/chips';
import { MatDialogModule } from '@angular/material/dialog';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { MatRadioModule } from '@angular/material/radio';
import { MatTableModule } from '@angular/material/table';
import { SharedModule } from '@shared/shared.module';
import { DocumentEditComponent } from './document-edit/document-edit.component';
import { SendEmailComponent } from './send-email/send-email.component';
import { DocumentCommentComponent } from './document-comment/document-comment.component';
import { DocumentUploadNewVersionComponent } from './document-upload-new-version/document-upload-new-version.component';
import { DocumentVersionHistoryComponent } from './document-version-history/document-version-history.component';
import { SharableLinkComponent } from './sharable-link/sharable-link.component';
import { DocumentPermissionModule } from './document-permission/document-permission.module';

@NgModule({
  declarations: [
    DocumentEditComponent,
    SendEmailComponent,
    DocumentCommentComponent,
    DocumentUploadNewVersionComponent,
    DocumentVersionHistoryComponent,
    SharableLinkComponent,
  ],
  imports: [
    CommonModule,
    SharedModule,
    ReactiveFormsModule,
    MatDialogModule,
    MatButtonModule,
    MatIconModule,
    MatInputModule,
    MatProgressBarModule,
    MatTableModule,
    MatCheckboxModule,
    MatPaginatorModule,
    CKEditorModule,
    MatChipsModule,
    MatRadioModule,
    OwlDateTimeModule,
    OwlNativeDateTimeModule,
    NgSelectModule,
    ClipboardModule,
    DocumentPermissionModule,
  ],
  exports: [
    DocumentEditComponent,
    SendEmailComponent,
    DocumentCommentComponent,
    DocumentUploadNewVersionComponent,
    DocumentVersionHistoryComponent,
    SharableLinkComponent,
    DocumentPermissionModule,
  ],
})
export class DocumentDialogsModule {}
