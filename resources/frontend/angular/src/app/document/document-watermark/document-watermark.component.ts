import { Component, Inject, OnInit } from '@angular/core';
import {
  UntypedFormGroup,
  UntypedFormBuilder,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA, MatDialogModule } from '@angular/material/dialog';
import { DocumentInfo } from '@core/domain-classes/document-info';
import { ToastrService } from 'ngx-toastr';
import { BaseComponent } from 'src/app/base.component';
import { DocumentService } from '../document.service';
import { TranslationService } from '@core/services/translation.service';
import { CommonModule } from '@angular/common';
import { MatAutocompleteModule } from '@angular/material/autocomplete';
import { MatButtonModule } from '@angular/material/button';
import { NgSelectModule } from '@ng-select/ng-select';
import { SharedModule } from '@shared/shared.module';
import { FeatherModule } from 'angular-feather';
import { DocumentWatermark } from '@core/domain-classes/document-watermark';

@Component({
  selector: 'app-document-watermark',
  standalone: true,
  imports: [
    MatDialogModule,
    FeatherModule,
    SharedModule,
    ReactiveFormsModule,
    MatButtonModule,
    NgSelectModule,
    CommonModule,
    MatAutocompleteModule
  ],
  templateUrl: './document-watermark.component.html',
  styleUrl: './document-watermark.component.scss'
})
export class DocumentWatermarkComponent extends BaseComponent implements OnInit {
  documentWatermarkForm: UntypedFormGroup;
  isEditMode = false;
  constructor(
    public dialogRef: MatDialogRef<DocumentWatermarkComponent>,
    @Inject(MAT_DIALOG_DATA)
    public data: DocumentInfo,
    private fb: UntypedFormBuilder,
    private documentService: DocumentService) {
    super();
  }

  ngOnInit(): void {
    this.createDocumentLinkForm();
    if (this.data) {
      this.isEditMode = true;
      this.pathValue();
    }
  }

  pathValue() {
    this.documentWatermarkForm.get('documentId').setValue(this.data.id);
  }

  createDocumentLinkForm() {
    this.documentWatermarkForm = this.fb.group(
      {
        documentId: [''],
        watermarkText: ['', [Validators.required]],
      }
    );
  }

  createWatermark() {
    if (!this.documentWatermarkForm.valid) {
      this.documentWatermarkForm.markAllAsTouched();
      return;
    }
    const watermarkData: DocumentWatermark = this.documentWatermarkForm.getRawValue();
    this.sub$.sink = this.documentService
      .watermarkDocument(watermarkData)
      .subscribe({
        next: () => {
          this.dialogRef.close(true);
        },
      });
  }

  closeDialog() {
    this.dialogRef.close();
  }
}