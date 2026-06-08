import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { Router, RouterModule } from '@angular/router';
import { TranslateModule } from '@ngx-translate/core';
import { BaseComponent } from '../base.component';
import { filterBySearch, formatDisplayDate } from './post-management.utils';

type CandidateStage = 'cv_received' | 'shortlisted' | 'interview_scheduled' | 'approved' | 'rejected' | 'selected';

interface CandidateApplication {
  id: string;
  postId: string;
  postTitle: string;
  stage: CandidateStage;
  createdDate: string;
  interviewDate?: string;
  interviewer?: string | null;
  hasCv: boolean;
  cvOriginalName?: string;
}

interface GroupedCandidate {
  groupKey: string;
  candidateName: string;
  candidateCode?: string;
  phone?: string;
  email?: string;
  experienceYears?: number;
  applicationCount: number;
  latestApplicationId?: string;
  latestPostId?: string;
  latestPostTitle: string;
  latestStage: CandidateStage;
  latestAppliedDate?: string;
  hasCv: boolean;
  cvOriginalName?: string;
  applications: CandidateApplication[];
}

interface AllCandidatesResponse {
  candidates: GroupedCandidate[];
}

@Component({
  selector: 'app-all-candidates',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    RouterModule,
    TranslateModule,
    MatButtonModule,
    MatCardModule,
    MatFormFieldModule,
    MatIconModule,
    MatInputModule,
  ],
  templateUrl: './all-candidates.component.html',
  styleUrl: './all-candidates.component.scss',
})
export class AllCandidatesComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly router = inject(Router);

  candidates: GroupedCandidate[] = [];
  searchQuery = '';
  loading = true;
  expandedGroupKey = '';

  ngOnInit(): void {
    this.loadCandidates();
  }

  loadCandidates(): void {
    this.loading = true;
    this.sub$.sink = this.httpClient.get<AllCandidatesResponse>('proposal-management/all-candidates').subscribe({
      next: (response) => {
        this.candidates = response.candidates || [];
        this.loading = false;
      },
      error: () => {
        this.loading = false;
      },
    });
  }

  get filteredCandidates(): GroupedCandidate[] {
    return filterBySearch(this.candidates, this.searchQuery, (candidate) =>
      [
        candidate.candidateName,
        candidate.candidateCode,
        candidate.phone,
        candidate.email,
        candidate.latestPostTitle,
        ...candidate.applications.map((app) => app.postTitle),
        this.getStageLabel(candidate.latestStage),
      ]
        .filter(Boolean)
        .join(' ')
    );
  }

  toggleHistory(candidate: GroupedCandidate): void {
    this.expandedGroupKey = this.expandedGroupKey === candidate.groupKey ? '' : candidate.groupKey;
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
    const stageLabels: Record<CandidateStage, string> = {
      cv_received: 'CV Received',
      shortlisted: 'Shortlisted',
      interview_scheduled: 'Interview Scheduled',
      approved: 'Approved',
      rejected: 'Rejected',
      selected: 'Selected',
    };
    return stageLabels[stage];
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
