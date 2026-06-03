import { CommonModule } from '@angular/common';
import { Component, Inject } from '@angular/core';
import { MatButtonModule } from '@angular/material/button';
import {
  MAT_DIALOG_DATA,
  MatDialogModule,
  MatDialogRef,
} from '@angular/material/dialog';
import { MatIconModule } from '@angular/material/icon';

export interface AssignedInterviewHistoryDialogData {
  candidateName: string;
  candidateCode?: string | null;
  postTitle?: string | null;
}

@Component({
  selector: 'app-assigned-interview-history-dialog',
  standalone: true,
  imports: [CommonModule, MatButtonModule, MatDialogModule, MatIconModule],
  template: `
    <h2 mat-dialog-title>
      <mat-icon class="align-middle me-1">history</mat-icon>
      Candidate history
    </h2>
    <mat-dialog-content class="ai-history-dialog">
      <p class="ai-history-name mb-1">{{ data.candidateName }}</p>
      <p class="text-muted small mb-3" *ngIf="data.candidateCode || data.postTitle">
        <span *ngIf="data.candidateCode">CNIC {{ data.candidateCode }}</span>
        <span *ngIf="data.postTitle">
          <span *ngIf="data.candidateCode"> · </span>
          Current post: <strong>{{ data.postTitle }}</strong>
        </span>
      </p>
      <div class="text-muted small border rounded p-3 bg-light">
        No other applications found for this candidate (matched by CNIC or email only).
      </div>
    </mat-dialog-content>
    <mat-dialog-actions align="end">
      <button mat-button type="button" (click)="close()">Close</button>
    </mat-dialog-actions>
  `,
  styles: [
    `
      .ai-history-dialog {
        min-width: min(400px, 92vw);
        padding-top: 4px;
      }
      .ai-history-name {
        font-weight: 600;
        margin: 0;
      }
    `,
  ],
})
export class AssignedInterviewHistoryDialogComponent {
  constructor(
    private readonly dialogRef: MatDialogRef<AssignedInterviewHistoryDialogComponent>,
    @Inject(MAT_DIALOG_DATA) readonly data: AssignedInterviewHistoryDialogData,
  ) {}

  close(): void {
    this.dialogRef.close();
  }
}
