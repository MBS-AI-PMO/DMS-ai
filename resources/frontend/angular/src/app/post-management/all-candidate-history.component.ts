import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, inject } from '@angular/core';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { MatDialog } from '@angular/material/dialog';
import { ActivatedRoute, Router } from '@angular/router';
import { BaseComponent } from '../base.component';
import { openRejectionReasonDialog } from './all-candidate-status.util';
import {
  CANDIDATE_STAGE_LABELS,
  CandidateApplication,
  CandidateStage,
  GroupedCandidate,
} from './all-candidate.types';
import { clampPageIndex, formatDisplayDate, slicePage } from './post-management.utils';

interface CandidateHistoryResponse {
  candidate: GroupedCandidate;
}

@Component({
  selector: 'app-all-candidate-history',
  standalone: true,
  imports: [
    CommonModule,
    MatButtonModule,
    MatCardModule,
    MatIconModule,
    MatPaginatorModule,
  ],
  templateUrl: './all-candidate-history.component.html',
  styleUrl: './all-candidate-history.component.scss',
})
export class AllCandidateHistoryComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly route = inject(ActivatedRoute);
  private readonly router = inject(Router);
  private readonly dialog = inject(MatDialog);

  candidateId = '';
  candidate: GroupedCandidate | null = null;
  loading = true;
  pageIndex = 0;
  readonly pageSizeOptions = [10, 25, 50];
  currentPageSize = 10;

  ngOnInit(): void {
    this.candidateId = this.route.snapshot.paramMap.get('candidateId') || '';
    this.loadCandidate();
  }

  loadCandidate(): void {
    if (!this.candidateId) {
      this.loading = false;
      return;
    }

    this.loading = true;
    this.sub$.sink = this.httpClient
      .get<CandidateHistoryResponse>(`proposal-management/all-candidates/${this.candidateId}/history`)
      .subscribe({
        next: (response) => {
          this.candidate = response.candidate || null;
          this.pageIndex = 0;
          this.loading = false;
        },
        error: () => {
          this.candidate = null;
          this.loading = false;
        },
      });
  }

  get applications(): CandidateApplication[] {
    return this.candidate?.applications || [];
  }

  get pagedApplications(): CandidateApplication[] {
    return slicePage(this.applications, this.pageIndex, this.currentPageSize);
  }

  onPageChange(event: PageEvent): void {
    this.pageIndex = clampPageIndex(this.applications.length, event.pageIndex, event.pageSize);
    this.currentPageSize = event.pageSize;
  }

  goBack(): void {
    void this.router.navigate(['/all-candidates']);
  }

  navigateToPost(postId: string): void {
    void this.router.navigate(['/post-management', postId, 'candidates']);
  }

  openApplicationCv(application: CandidateApplication): void {
    if (!application.hasCv) {
      return;
    }

    this.sub$.sink = this.httpClient
      .get(`proposal-management/candidates/${application.id}/cv`, { responseType: 'blob' })
      .subscribe((blob) => {
        const url = URL.createObjectURL(blob);
        window.open(url, '_blank');
      });
  }

  getStageLabel(stage: CandidateStage): string {
    return CANDIDATE_STAGE_LABELS[stage];
  }

  hasRejectionReason(stage: CandidateStage): boolean {
    return stage === 'rejected';
  }

  showRejectionReason(app: CandidateApplication): void {
    openRejectionReasonDialog(this.dialog, {
      candidateName: this.candidate?.candidateName,
      postTitle: app.postTitle,
      rejectionReason: app.rejectionReason || '',
    });
  }

  formatDisplayDate = formatDisplayDate;

  formatDisplayDateTime(value?: string | null): string {
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
      hour: 'numeric',
      minute: '2-digit',
    });
  }
}
