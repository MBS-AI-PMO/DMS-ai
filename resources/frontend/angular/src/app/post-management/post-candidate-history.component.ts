import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, inject } from '@angular/core';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { ActivatedRoute, Router } from '@angular/router';
import { BaseComponent } from '../base.component';

type CandidateStage = 'cv_received' | 'shortlisted' | 'interview_scheduled' | 'approved' | 'rejected' | 'selected';

interface CandidateHistory {
  postTitle: string;
  stage: CandidateStage;
  createdDate: string;
  interviewDate?: string;
  interviewer?: string | null;
}

interface ProposalCandidate {
  id: string;
  candidateName: string;
  candidateCode?: string;
  phone?: string;
  email?: string;
  stage: CandidateStage;
  createdDate: string;
  history?: CandidateHistory[];
}

interface ProposalPost {
  id: string;
  title: string;
  candidates: ProposalCandidate[];
}

interface PostManagementData {
  posts: ProposalPost[];
}

@Component({
  selector: 'app-post-candidate-history',
  standalone: true,
  imports: [
    CommonModule,
    MatButtonModule,
    MatCardModule,
    MatIconModule,
  ],
  templateUrl: './post-candidate-history.component.html',
  styleUrl: './post-candidate-history.component.scss',
})
export class PostCandidateHistoryComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly route = inject(ActivatedRoute);
  private readonly router = inject(Router);

  postId = '';
  candidateId = '';
  post: ProposalPost | null = null;
  candidate: ProposalCandidate | null = null;

  ngOnInit(): void {
    this.postId = this.route.snapshot.paramMap.get('id') || '';
    this.candidateId = this.route.snapshot.paramMap.get('candidateId') || '';
    this.loadData();
  }

  loadData(): void {
    this.sub$.sink = this.httpClient.get<PostManagementData>('proposal-management').subscribe((response) => {
      this.post = (response.posts || []).find((p) => p.id === this.postId) || null;
      this.candidate =
        this.post?.candidates.find((c) => c.id === this.candidateId) || null;
    });
  }

  goBack(): void {
    void this.router.navigate(['/post-management', this.postId, 'candidates']);
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

  getStageBadgeClass(stage: CandidateStage): string {
    const badgeClasses: Record<CandidateStage, string> = {
      cv_received: 'bg-secondary',
      shortlisted: 'bg-info',
      interview_scheduled: 'bg-primary',
      approved: 'bg-warning text-dark',
      rejected: 'bg-danger',
      selected: 'bg-success',
    };
    return badgeClasses[stage];
  }

  formatDisplayDate(value?: string | null): string {
    if (value == null || value === '' || value === 'null') {
      return '—';
    }
    const parsed = new Date(value);
    if (isNaN(parsed.getTime())) {
      return '—';
    }
    return parsed.toLocaleDateString(undefined, {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: 'numeric',
      minute: '2-digit',
    });
  }
}
