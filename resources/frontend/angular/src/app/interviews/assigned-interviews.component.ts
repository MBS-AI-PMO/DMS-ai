import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatTableModule } from '@angular/material/table';
import { MatTooltipModule } from '@angular/material/tooltip';
import { TranslateModule } from '@ngx-translate/core';
import { ToastrService } from 'ngx-toastr';
import { BaseComponent } from '../base.component';

type CandidateStage = 'interview_scheduled' | 'approved' | 'rejected' | 'selected';

interface AssignedInterview {
  id: string;
  postId: string;
  postTitle: string;
  candidateName: string;
  candidateCode: string;
  phone?: string | null;
  email?: string | null;
  stage: string;
  interviewLevel?: string | null;
  interviewDate?: string | null;
  analysisNotes?: string | null;
  rejectionReason?: string | null;
  createdDate?: string | null;
}

interface AssignedInterviewResponse {
  candidates: AssignedInterview[];
}

@Component({
  selector: 'app-assigned-interviews',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    TranslateModule,
    MatCardModule,
    MatTableModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatButtonModule,
    MatTooltipModule,
  ],
  template: `
    <div class="pm-container">
      <div class="pm-page-header">
        <div>
          <span class="page-title">{{ 'ASSIGNED_INTERVIEWS' | translate }}</span>
          <p class="pm-page-subtitle">Your assigned interview candidates.</p>
        </div>
        <div>
          <button mat-stroked-button color="primary" (click)="load()">Refresh</button>
        </div>
      </div>

      <mat-card class="pm-card">
        <div class="pm-toolbar">
          <mat-form-field appearance="outline" class="pm-search">
            <mat-label>Search</mat-label>
            <input matInput [(ngModel)]="search" placeholder="Candidate / Post / CNIC" />
          </mat-form-field>
        </div>

        <div class="pm-table-wrap">
          <table mat-table [dataSource]="filtered" class="mat-elevation-z0 pm-table">
            <ng-container matColumnDef="candidate">
              <th mat-header-cell *matHeaderCellDef>Candidate</th>
              <td mat-cell *matCellDef="let row">
                <div class="pm-strong">{{ row.candidateName }}</div>
                <div class="pm-muted">{{ row.candidateCode || '—' }}</div>
              </td>
            </ng-container>

            <ng-container matColumnDef="post">
              <th mat-header-cell *matHeaderCellDef>Post</th>
              <td mat-cell *matCellDef="let row">
                <div class="pm-strong">{{ row.postTitle || '—' }}</div>
                <div class="pm-muted">{{ formatDisplayDate(row.interviewDate) }}</div>
              </td>
            </ng-container>

            <ng-container matColumnDef="stage">
              <th mat-header-cell *matHeaderCellDef>Status</th>
              <td mat-cell *matCellDef="let row">
                <mat-form-field appearance="outline" class="pm-small-field">
                  <mat-select [(ngModel)]="row.stage">
                    <mat-option value="interview_scheduled">Scheduled</mat-option>
                    <mat-option value="approved">Approved</mat-option>
                    <mat-option value="rejected">Rejected</mat-option>
                    <mat-option value="selected">Selected</mat-option>
                  </mat-select>
                </mat-form-field>
              </td>
            </ng-container>

            <ng-container matColumnDef="notes">
              <th mat-header-cell *matHeaderCellDef>Notes</th>
              <td mat-cell *matCellDef="let row">
                <mat-form-field appearance="outline" class="pm-notes">
                  <textarea
                    matInput
                    rows="2"
                    [(ngModel)]="row.analysisNotes"
                    placeholder="Your analysis notes"
                  ></textarea>
                </mat-form-field>

                <mat-form-field
                  *ngIf="row.stage === 'rejected'"
                  appearance="outline"
                  class="pm-notes"
                >
                  <textarea
                    matInput
                    rows="2"
                    [(ngModel)]="row.rejectionReason"
                    placeholder="Rejection reason (required)"
                  ></textarea>
                </mat-form-field>
              </td>
            </ng-container>

            <ng-container matColumnDef="actions">
              <th mat-header-cell *matHeaderCellDef>Actions</th>
              <td mat-cell *matCellDef="let row">
                <button
                  mat-raised-button
                  color="primary"
                  (click)="save(row)"
                  [disabled]="savingId === row.id"
                >
                  Save
                </button>
              </td>
            </ng-container>

            <tr mat-header-row *matHeaderRowDef="displayedColumns"></tr>
            <tr mat-row *matRowDef="let row; columns: displayedColumns"></tr>
          </table>

          <div *ngIf="!loading && filtered.length === 0" class="pm-empty">No assigned interviews.</div>
        </div>
      </mat-card>
    </div>
  `,
  styles: [
    `
      .pm-container {
        padding: 18px;
      }
      .pm-page-header {
        display: flex;
        align-items: flex-start;
        justify-content: space-between;
        margin-bottom: 14px;
      }
      .page-title {
        font-size: 20px;
        font-weight: 700;
      }
      .pm-page-subtitle {
        margin: 4px 0 0;
        opacity: 0.75;
      }
      .pm-card {
        padding: 14px;
      }
      .pm-toolbar {
        display: flex;
        gap: 10px;
        align-items: center;
        margin-bottom: 10px;
      }
      .pm-search {
        width: 420px;
        max-width: 100%;
      }
      .pm-table-wrap {
        overflow: auto;
      }
      .pm-table {
        width: 100%;
        min-width: 900px;
      }
      .pm-strong {
        font-weight: 600;
      }
      .pm-muted {
        opacity: 0.7;
        font-size: 12px;
      }
      .pm-notes {
        width: 360px;
        max-width: 100%;
      }
      .pm-small-field {
        width: 180px;
      }
      .pm-empty {
        padding: 14px;
        opacity: 0.8;
      }
    `,
  ],
})
export class AssignedInterviewsComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly toastr = inject(ToastrService);

  loading = false;
  savingId = '';
  search = '';
  items: AssignedInterview[] = [];
  displayedColumns: Array<'candidate' | 'post' | 'stage' | 'notes' | 'actions'> = [
    'candidate',
    'post',
    'stage',
    'notes',
    'actions',
  ];

  ngOnInit(): void {
    this.load();
  }

  load(): void {
    this.loading = true;
    this.sub$.sink = this.httpClient
      .get<AssignedInterviewResponse>('proposal-management/assigned-interviews')
      .subscribe({
        next: (resp) => {
          this.items = resp?.candidates || [];
          this.loading = false;
        },
        error: (err) => {
          this.loading = false;
          this.toastr.error(err?.error?.message || 'Could not load assigned interviews');
        },
      });
  }

  get filtered(): AssignedInterview[] {
    const q = this.search.trim().toLowerCase();
    if (!q) {
      return this.items;
    }
    return this.items.filter((x) =>
      `${x.candidateName} ${x.candidateCode} ${x.postTitle}`.toLowerCase().includes(q)
    );
  }

  save(row: AssignedInterview): void {
    const stage = (row.stage || '') as CandidateStage;
    const body: any = {
      stage,
      analysisNotes: row.analysisNotes ?? null,
    };

    if (stage === 'rejected') {
      body.rejectionReason = row.rejectionReason ?? null;
    }

    this.savingId = row.id;
    this.sub$.sink = this.httpClient
      .put<AssignedInterview>(`proposal-management/assigned-interviews/${row.id}`, body)
      .subscribe({
        next: (updated) => {
          const idx = this.items.findIndex((x) => x.id === updated.id);
          if (idx >= 0) {
            this.items[idx] = { ...this.items[idx], ...updated };
          }
          this.savingId = '';
          this.toastr.success('Saved');
        },
        error: (err) => {
          this.savingId = '';
          this.toastr.error(err?.error?.message || 'Could not save');
        },
      });
  }

  formatDisplayDate(value?: string | null): string {
    if (value == null || value === '' || value === 'null') {
      return '—';
    }
    const parsed = new Date(value);
    if (isNaN(parsed.getTime())) {
      return '—';
    }
    return parsed.toLocaleString(undefined, {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    });
  }
}

