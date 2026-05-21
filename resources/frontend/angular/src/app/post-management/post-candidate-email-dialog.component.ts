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

export interface PostCandidateEmailDialogData {
  candidateName: string;
  candidateEmail: string;
  interviewerName?: string | null;
  postTitle: string;
}

export interface PostCandidateEmailDialogResult {
  message: string;
  subject?: string | null;
}

@Component({
  selector: 'app-post-candidate-email-dialog',
  standalone: true,
  imports: [CommonModule, FormsModule, MatButtonModule, MatDialogModule, MatFormFieldModule, MatInputModule],
  template: `
    <h2 mat-dialog-title>Email candidate</h2>
    <mat-dialog-content class="email-dialog-content">
      <p class="text-muted small mb-2">
        To: <strong>{{ data.candidateEmail }}</strong>
        <span *ngIf="data.interviewerName"> · CC: <strong>{{ data.interviewerName }}</strong> (interviewer)</span>
      </p>
      <p class="text-muted small mb-3">Post: <strong>{{ data.postTitle }}</strong></p>
      <mat-form-field appearance="outline" class="w-100 mb-2">
        <mat-label>Subject (optional)</mat-label>
        <input matInput [(ngModel)]="subject" [placeholder]="defaultSubject" />
      </mat-form-field>
      <mat-form-field appearance="outline" class="w-100">
        <mat-label>Message</mat-label>
        <textarea
          matInput
          rows="6"
          [(ngModel)]="message"
          placeholder="Write your message to the candidate"
          required></textarea>
      </mat-form-field>
    </mat-dialog-content>
    <mat-dialog-actions align="end">
      <button mat-button type="button" (click)="cancel()">Cancel</button>
      <button mat-flat-button color="primary" type="button" (click)="submit()">Send email</button>
    </mat-dialog-actions>
  `,
  styles: [
    `
      .email-dialog-content {
        min-width: min(440px, 92vw);
        padding-top: 8px;
      }
      textarea {
        resize: vertical;
      }
    `,
  ],
})
export class PostCandidateEmailDialogComponent {
  message = '';
  subject = '';
  readonly defaultSubject: string;

  constructor(
    private readonly dialogRef: MatDialogRef<
      PostCandidateEmailDialogComponent,
      PostCandidateEmailDialogResult | undefined
    >,
    @Inject(MAT_DIALOG_DATA) readonly data: PostCandidateEmailDialogData,
    private readonly toastr: ToastrService,
  ) {
    this.defaultSubject = `Regarding your interview – ${data.postTitle}`;
  }

  cancel(): void {
    this.dialogRef.close(undefined);
  }

  submit(): void {
    const text = this.message.trim();
    if (!text) {
      this.toastr.warning('Please enter a message.');
      return;
    }
    this.dialogRef.close({
      message: text,
      subject: (this.subject || '').trim() || null,
    });
  }
}
