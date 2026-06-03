import { CommonModule } from '@angular/common';

import { HttpClient } from '@angular/common/http';

import { Component, OnInit, inject } from '@angular/core';
import { Router } from '@angular/router';

import { FormsModule } from '@angular/forms';

import { MatButtonModule } from '@angular/material/button';

import { MatCardModule } from '@angular/material/card';

import { MatDialog, MatDialogModule } from '@angular/material/dialog';

import { MatFormFieldModule } from '@angular/material/form-field';

import { MatIconModule } from '@angular/material/icon';

import { MatInputModule } from '@angular/material/input';

import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';

import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';

import { MatTooltipModule } from '@angular/material/tooltip';

import { TranslateModule } from '@ngx-translate/core';

import { ToastrService } from 'ngx-toastr';

import { BaseComponent } from '../base.component';

import {

  AssignedInterviewDetailsDialogComponent,

  AssignedInterviewDetailsDialogResult,

} from './assigned-interview-details-dialog.component';

import { AssignedInterviewHistoryDialogComponent } from './assigned-interview-history-dialog.component';



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

  savedStage?: string;

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

    MatFormFieldModule,

    MatInputModule,

    MatButtonModule,

    MatIconModule,

    MatProgressSpinnerModule,

    MatPaginatorModule,

    MatDialogModule,

    MatTooltipModule,

  ],

  templateUrl: './assigned-interviews.component.html',

  styleUrl: './assigned-interviews.component.scss',

})

export class AssignedInterviewsComponent extends BaseComponent implements OnInit {

  private readonly httpClient = inject(HttpClient);

  private readonly toastr = inject(ToastrService);

  private readonly dialog = inject(MatDialog);
  private readonly router = inject(Router);



  loading = false;

  savingId = '';

  search = '';

  items: AssignedInterview[] = [];



  pageIndex = 0;

  pageSize = 10;

  readonly pageSizeOptions = [5, 10, 25, 50];



  ngOnInit(): void {

    this.load();

  }



  load(): void {

    this.loading = true;

    this.sub$.sink = this.httpClient

      .get<AssignedInterviewResponse>('proposal-management/assigned-interviews')

      .subscribe({

        next: (resp) => {

          this.items = (resp?.candidates || []).map((c) => ({

            ...c,

            savedStage: c.stage,

          }));

          this.clampPage();

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



  get paginatedRows(): AssignedInterview[] {

    const start = this.pageIndex * this.pageSize;

    return this.filtered.slice(start, start + this.pageSize);

  }



  onSearchChange(): void {

    this.pageIndex = 0;

    this.clampPage();

  }



  onPage(event: PageEvent): void {

    this.pageIndex = event.pageIndex;

    this.pageSize = event.pageSize;

  }



  onStageChange(row: AssignedInterview, newStage: CandidateStage): void {

    const previous = (row.savedStage || row.stage) as CandidateStage;

    if (newStage === previous) {

      return;

    }



    if (newStage === 'rejected' && !(row.rejectionReason || '').trim()) {

      row.stage = previous;

      this.openDetails(row);

      this.toastr.info('Add rejection reason in interview details.');

      return;

    }



    row.stage = newStage;

    this.save(row, () => {

      row.savedStage = newStage;

    }, () => {

      row.stage = previous;

    });

  }



  openDetails(row: AssignedInterview): void {

    const ref = this.dialog.open(AssignedInterviewDetailsDialogComponent, {

      width: '520px',

      autoFocus: false,

      restoreFocus: false,

      data: {

        candidateName: row.candidateName,

        candidateCode: row.candidateCode,

        phone: row.phone,

        email: row.email,

        postTitle: row.postTitle,

        interviewDate: this.formatDisplayDate(row.interviewDate),

        interviewLevel: row.interviewLevel,

        stage: row.stage,

        analysisNotes: row.analysisNotes,

        rejectionReason: row.rejectionReason,

      },

    });



    this.sub$.sink = ref.afterClosed().subscribe((result?: AssignedInterviewDetailsDialogResult) => {

      if (!result) {

        return;

      }

      row.stage = result.stage;

      row.analysisNotes = result.analysisNotes;

      row.rejectionReason = result.rejectionReason;

      this.save(row, () => {

        row.savedStage = result.stage;

      });

    });

  }



  openHistory(row: AssignedInterview): void {
    this.sub$.sink = this.httpClient
      .get<{ history?: unknown[] }>(
        `proposal-management/assigned-interviews/${row.id}/history`,
      )
      .subscribe({
        next: (resp) => {
          const hasHistory = (resp?.history?.length ?? 0) > 0;
          if (hasHistory) {
            void this.router.navigate(['/assigned-interviews', row.id, 'history']);
            return;
          }
          this.dialog.open(AssignedInterviewHistoryDialogComponent, {
            width: '480px',
            autoFocus: false,
            restoreFocus: false,
            data: {
              candidateName: row.candidateName,
              candidateCode: row.candidateCode,
              postTitle: row.postTitle,
            },
          });
        },
        error: (err) => {
          this.toastr.error(err?.error?.message || 'Could not load candidate history');
        },
      });
  }



  save(

    row: AssignedInterview,

    onSuccess?: () => void,

    onError?: () => void,

  ): void {

    const stage = (row.stage || '') as CandidateStage;

    const body: Record<string, unknown> = {

      stage,

      analysisNotes: row.analysisNotes ?? null,

    };



    if (stage === 'rejected') {

      body['rejectionReason'] = row.rejectionReason ?? null;

    }



    this.savingId = row.id;

    this.sub$.sink = this.httpClient

      .put<AssignedInterview>(`proposal-management/assigned-interviews/${row.id}`, body)

      .subscribe({

        next: (updated) => {

          const idx = this.items.findIndex((x) => x.id === updated.id);

          if (idx >= 0) {

            this.items[idx] = {

              ...this.items[idx],

              ...updated,

              savedStage: updated.stage,

            };

          }

          this.savingId = '';

          this.toastr.success('Saved');

          onSuccess?.();

        },

        error: (err) => {

          this.savingId = '';

          this.toastr.error(err?.error?.message || 'Could not save');

          onError?.();

        },

      });

  }



  getStageLabel(stage: string): string {

    const labels: Record<string, string> = {

      interview_scheduled: 'Scheduled',

      approved: 'Approved',

      rejected: 'Rejected',

      selected: 'Selected',

    };

    return labels[stage] ?? stage;

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



  private clampPage(): void {

    if (this.filtered.length === 0) {

      this.pageIndex = 0;

      return;

    }

    const maxPage = Math.max(0, Math.ceil(this.filtered.length / this.pageSize) - 1);

    this.pageIndex = Math.min(this.pageIndex, maxPage);

  }

}

