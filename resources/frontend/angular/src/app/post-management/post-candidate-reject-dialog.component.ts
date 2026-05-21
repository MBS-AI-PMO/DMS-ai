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

export interface PostCandidateRejectDialogData {
  candidateName: string;
}

export interface PostCandidateRejectDialogResult {
  reason: string;
}

@Component({
  selector: 'app-post-candidate-reject-dialog',
  standalone: true,
  imports: [
    FormsModule,
    MatButtonModule,
    MatDialogModule,
    MatFormFieldModule,
    MatInputModule,
  ],
  template: `
    <h2 mat-dialog-title>Rejection form</h2>
    <mat-dialog-content class="reject-dialog-content">
      <p class="text-muted small mb-2">Provide a reason for rejection.</p>
      <p class="text-muted small mb-2">Candidate: <strong>{{ data.candidateName }}</strong></p>
      <mat-form-field appearance="outline" class="w-100">
        <mat-label>Reason</mat-label>
        <textarea matInput rows="4" [(ngModel)]="reason" placeholder="Explain why this candidate is rejected" required></textarea>
      </mat-form-field>
    </mat-dialog-content>
    <mat-dialog-actions align="end">
      <button mat-button type="button" (click)="cancel()">Cancel</button>
      <button mat-flat-button color="warn" type="button" (click)="submit()">Reject</button>
    </mat-dialog-actions>
  `,
  styles: [
    `
      .reject-dialog-content {
        min-width: min(400px, 92vw);
        padding-top: 8px;
      }
      textarea {
        resize: vertical;
      }
    `,
  ],
})
export class PostCandidateRejectDialogComponent {
  reason = '';

  constructor(
    private readonly dialogRef: MatDialogRef<
      PostCandidateRejectDialogComponent,
      PostCandidateRejectDialogResult | undefined
    >,
    @Inject(MAT_DIALOG_DATA) readonly data: PostCandidateRejectDialogData,
    private readonly toastr: ToastrService,
  ) {}

  cancel(): void {
    this.dialogRef.close(undefined);
  }

  submit(): void {
    const trimmed = this.reason.trim();
    if (!trimmed) {
      this.toastr.warning('Please enter a rejection reason.');
      return;
    }
    this.dialogRef.close({ reason: trimmed });
  }
}
