import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, inject } from '@angular/core';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { BaseComponent } from '../base.component';

type CandidateStage =
  | 'cv_received'
  | 'shortlisted'
  | 'interview_scheduled'
  | 'approved'
  | 'rejected'
  | 'selected';

interface CandidateHistoryRow {
  postTitle: string;
  stage: CandidateStage;
  createdDate: string;
  interviewDate?: string | null;
  interviewer?: string | null;
}

interface AssignedInterviewHistoryResponse {
  candidateName: string;
  candidateCode?: string | null;
  phone?: string | null;
  email?: string | null;
  postTitle?: string;
  stage: CandidateStage;
  createdDate?: string | null;
  history: CandidateHistoryRow[];
}

@Component({
  selector: 'app-assigned-interview-history',
  standalone: true,
  imports: [
    CommonModule,
    MatButtonModule,
    MatCardModule,
    MatIconModule,
    MatProgressSpinnerModule,
  ],
  templateUrl: './assigned-interview-history.component.html',
  styleUrl: './assigned-interview-history.component.scss',
})
export class AssignedInterviewHistoryComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly route = inject(ActivatedRoute);
  private readonly router = inject(Router);
  private readonly toastr = inject(ToastrService);

  candidateId = '';
  loading = true;
  data: AssignedInterviewHistoryResponse | null = null;

  ngOnInit(): void {
    this.candidateId = this.route.snapshot.paramMap.get('candidateId') || '';
    this.loadData();
  }

  loadData(): void {
    if (!this.candidateId) {
      this.loading = false;
      return;
    }

    this.sub$.sink = this.httpClient
      .get<AssignedInterviewHistoryResponse>(
        `proposal-management/assigned-interviews/${this.candidateId}/history`,
      )
      .subscribe({
        next: (resp) => {
          this.data = resp;
          this.loading = false;
          if (!resp.history?.length) {
            void this.router.navigate(['/assigned-interviews']);
            this.toastr.info('No other applications found for this candidate.');
          }
        },
        error: (err) => {
          this.loading = false;
          this.toastr.error(err?.error?.message || 'Could not load candidate history');
        },
      });
  }

  goBack(): void {
    void this.router.navigate(['/assigned-interviews']);
  }

  getStageLabel(stage: CandidateStage): string {
    const labels: Record<CandidateStage, string> = {
      cv_received: 'CV Received',
      shortlisted: 'Shortlisted',
      interview_scheduled: 'Interview Scheduled',
      approved: 'Approved',
      rejected: 'Rejected',
      selected: 'Selected',
    };
    return labels[stage] ?? stage;
  }

  getStageBadgeClass(stage: CandidateStage): string {
    const classes: Record<CandidateStage, string> = {
      cv_received: 'bg-secondary',
      shortlisted: 'bg-info',
      interview_scheduled: 'bg-primary',
      approved: 'bg-warning text-dark',
      rejected: 'bg-danger',
      selected: 'bg-success',
    };
    return classes[stage] ?? 'bg-secondary';
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
