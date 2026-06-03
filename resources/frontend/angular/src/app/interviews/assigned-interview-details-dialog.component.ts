import { CommonModule } from '@angular/common';
import { Component, Inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import {
  MAT_DIALOG_DATA,
  MatDialogModule,
  MatDialogRef,
} from '@angular/material/dialog';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { ToastrService } from 'ngx-toastr';

export type AssignedInterviewStage =
  | 'interview_scheduled'
  | 'approved'
  | 'rejected'
  | 'selected';

export interface AssignedInterviewDetailsDialogData {
  candidateName: string;
  candidateCode?: string | null;
  phone?: string | null;
  email?: string | null;
  postTitle?: string;
  interviewDate?: string | null;
  interviewLevel?: string | null;
  stage: string;
  analysisNotes?: string | null;
  rejectionReason?: string | null;
}

export interface AssignedInterviewDetailsDialogResult {
  stage: AssignedInterviewStage;
  analysisNotes: string | null;
  rejectionReason: string | null;
}

@Component({
  selector: 'app-assigned-interview-details-dialog',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    MatButtonModule,
    MatDialogModule,
    MatFormFieldModule,
    MatInputModule,
  ],
  template: `
    <h2 mat-dialog-title>Interview details</h2>
    <mat-dialog-content class="ai-details-dialog">
      <p class="ai-details-name">{{ data.candidateName }}</p>
      <p class="ai-details-meta text-muted small mb-3">
        CNIC {{ data.candidateCode || '—' }}
        <span *ngIf="data.phone"> · {{ data.phone }}</span>
        <span *ngIf="data.email"> · {{ data.email }}</span>
      </p>
      <p class="text-muted small mb-3" *ngIf="data.postTitle">
        <strong>Post:</strong> {{ data.postTitle }}
        <span *ngIf="data.interviewDate"> · {{ data.interviewDate }}</span>
        <span *ngIf="data.interviewLevel"> · {{ data.interviewLevel }}</span>
      </p>

      <label class="form-label small text-muted mb-1">Status</label>
      <select class="form-select mb-3" [(ngModel)]="stage">
        <option value="interview_scheduled">Scheduled</option>
        <option value="approved">Approved</option>
        <option value="rejected">Rejected</option>
        <option value="selected">Selected</option>
      </select>

      <mat-form-field appearance="outline" class="w-100">
        <mat-label>Analysis notes</mat-label>
        <textarea
          matInput
          rows="4"
          [(ngModel)]="analysisNotes"
          placeholder="Screening / interview notes"
        ></textarea>
      </mat-form-field>

      <mat-form-field appearance="outline" class="w-100" *ngIf="stage === 'rejected'">
        <mat-label>Rejection reason</mat-label>
        <textarea
          matInput
          rows="3"
          [(ngModel)]="rejectionReason"
          placeholder="Required when status is Rejected"
          required
        ></textarea>
      </mat-form-field>
    </mat-dialog-content>
    <mat-dialog-actions align="end">
      <button mat-button type="button" (click)="cancel()">Close</button>
      <button mat-flat-button color="primary" type="button" (click)="submit()">Save</button>
    </mat-dialog-actions>
  `,
  styles: [
    `
      .ai-details-dialog {
        min-width: min(440px, 92vw);
        padding-top: 4px;
      }
      .ai-details-name {
        font-size: 1.05rem;
        font-weight: 600;
        margin: 0 0 4px;
      }
      textarea {
        resize: vertical;
      }
    `,
  ],
})
export class AssignedInterviewDetailsDialogComponent {
  stage: AssignedInterviewStage;
  analysisNotes: string;
  rejectionReason: string;

  constructor(
    private readonly dialogRef: MatDialogRef<
      AssignedInterviewDetailsDialogComponent,
      AssignedInterviewDetailsDialogResult | undefined
    >,
    @Inject(MAT_DIALOG_DATA) readonly data: AssignedInterviewDetailsDialogData,
    private readonly toastr: ToastrService,
  ) {
    this.stage = (data.stage || 'interview_scheduled') as AssignedInterviewStage;
    this.analysisNotes = data.analysisNotes ?? '';
    this.rejectionReason = data.rejectionReason ?? '';
  }

  cancel(): void {
    this.dialogRef.close(undefined);
  }

  submit(): void {
    if (this.stage === 'rejected' && !this.rejectionReason.trim()) {
      this.toastr.warning('Please enter a rejection reason.');
      return;
    }
    this.dialogRef.close({
      stage: this.stage,
      analysisNotes: this.analysisNotes.trim() || null,
      rejectionReason:
        this.stage === 'rejected' ? this.rejectionReason.trim() || null : null,
    });
  }
}
