import { Component, Inject } from '@angular/core';
import { MatButtonModule } from '@angular/material/button';
import {
  MAT_DIALOG_DATA,
  MatDialogModule,
  MatDialogRef,
} from '@angular/material/dialog';
import { MatIconModule } from '@angular/material/icon';

export interface CandidateRejectionReasonDialogData {
  candidateName?: string;
  postTitle?: string;
  rejectionReason: string;
}

@Component({
  selector: 'app-candidate-rejection-reason-dialog',
  standalone: true,
  imports: [MatButtonModule, MatDialogModule, MatIconModule],
  template: `
    <h2 mat-dialog-title>
      <mat-icon class="dialog-title-icon">info</mat-icon>
      Rejection reason
    </h2>
    <mat-dialog-content class="rejection-dialog-content">
      <p class="text-muted small mb-1" *ngIf="data.candidateName">
        Candidate: <strong>{{ data.candidateName }}</strong>
      </p>
      <p class="text-muted small mb-3" *ngIf="data.postTitle">
        Job post: <strong>{{ data.postTitle }}</strong>
      </p>
      <div class="rejection-reason-box">{{ data.rejectionReason || 'No reason provided.' }}</div>
    </mat-dialog-content>
    <mat-dialog-actions align="end">
      <button mat-flat-button color="primary" type="button" (click)="close()">Close</button>
    </mat-dialog-actions>
  `,
  styles: [`
    .dialog-title-icon {
      font-size: 22px;
      height: 22px;
      margin-right: 6px;
      vertical-align: middle;
      width: 22px;
    }

    .rejection-dialog-content {
      min-width: 320px;
    }

    .rejection-reason-box {
      background: #fef2f2;
      border: 1px solid #fecaca;
      border-radius: 8px;
      color: #7f1d1d;
      line-height: 1.5;
      padding: 12px 14px;
      white-space: pre-wrap;
    }
  `],
})
export class CandidateRejectionReasonDialogComponent {
  constructor(
    @Inject(MAT_DIALOG_DATA) public readonly data: CandidateRejectionReasonDialogData,
    private readonly dialogRef: MatDialogRef<CandidateRejectionReasonDialogComponent>
  ) {}

  close(): void {
    this.dialogRef.close();
  }
}
