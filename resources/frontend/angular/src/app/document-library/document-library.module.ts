import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DocumentLibraryListComponent } from './document-library-list/document-library-list.component';
import { DocumentLibraryRoutingModule } from './document-library-routing.module';
import { MatSortModule } from '@angular/material/sort';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ScrollingModule } from '@angular/cdk/scrolling';
import { SharedModule } from '@shared/shared.module';
import { DocumentDialogsModule } from 'src/app/document/document-dialogs.module';
import { DocumentReminderComponent } from './document-reminder/document-reminder.component';
import { AddDocumentComponent } from './add-document/add-document.component';
import { ReminderListComponent } from './reminder-list/reminder-list.component';
import { PipesModule } from '@shared/pipes/pipes.module';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { MatDialogModule } from '@angular/material/dialog';
import { MatInputModule } from '@angular/material/input';
import { MatMenuModule } from '@angular/material/menu';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatRadioModule } from '@angular/material/radio';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { MatTableModule } from '@angular/material/table';
import {
  OwlDateTimeModule,
  OwlNativeDateTimeModule,
} from 'ng-pick-datetime-ex';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { NgSelectModule } from '@ng-select/ng-select';
import { DocumentDeleteDialogComponent } from 'src/app/document-delete-dialog/document-delete-dialog.component';
import { DocumentSignatureComponent } from '@shared/document-signature/document-signature.component';
import { DocumentWorkflowDialogComponent } from 'src/app/document/document-workflow-dialog/document-workflow-dialog.component';
import { AiDocumentSummaryComponent } from 'src/app/open-ai/ai-document-summary/ai-document-summary.component';
import { DocumentWatermarkComponent } from 'src/app/document/document-watermark/document-watermark.component';
import { VisualWorkflowGraphComponent } from 'src/app/workflows/visual-workflow-graph/visual-workflow-graph.component';

@NgModule({
  declarations: [
    DocumentLibraryListComponent,
    DocumentReminderComponent,
    AddDocumentComponent,
    ReminderListComponent,
  ],
  imports: [
    CommonModule,
    SharedModule,
    ReactiveFormsModule,
    DocumentLibraryRoutingModule,
    DocumentDialogsModule,
    MatTableModule,
    MatDialogModule,
    MatSlideToggleModule,
    MatSortModule,
    MatPaginatorModule,
    MatInputModule,
    MatCheckboxModule,
    FormsModule,
    PipesModule,
    MatButtonModule,
    MatIconModule,
    MatRadioModule,
    MatMenuModule,
    MatProgressBarModule,
    ScrollingModule,
    OwlDateTimeModule,
    OwlNativeDateTimeModule,
    NgSelectModule,
    DocumentDeleteDialogComponent,
    DocumentSignatureComponent,
    DocumentWorkflowDialogComponent,
    AiDocumentSummaryComponent,
    DocumentWatermarkComponent,
    VisualWorkflowGraphComponent,
  ],
})
export class DocumentLibraryModule {}
