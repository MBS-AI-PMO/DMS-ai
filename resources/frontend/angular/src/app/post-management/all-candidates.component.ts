import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatDialog } from '@angular/material/dialog';
import { Router, RouterModule } from '@angular/router';
import { TranslateModule } from '@ngx-translate/core';
import { ToastrService } from 'ngx-toastr';
import { BaseComponent } from '../base.component';
import { TranslationService } from '@core/services/translation.service';
import { openRejectionReasonDialog } from './all-candidate-status.util';
import {
  AllCandidatesAiSearchResponse,
  AllCandidatesResponse,
  CANDIDATE_STAGE_LABELS,
  CandidateSearchMatch,
  CandidateSearchMatchType,
  CandidateStage,
  GroupedCandidate,
} from './all-candidate.types';
import { formatDisplayDate } from './post-management.utils';

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
  private readonly dialog = inject(MatDialog);
  private readonly toastrService = inject(ToastrService);
  private readonly translationService = inject(TranslationService);

  candidates: GroupedCandidate[] = [];
  searchQuery = '';
  activeSearchQuery = '';
  aiInterpretation = '';
  usedAiSearch = false;
  searching = false;
  loading = true;

  ngOnInit(): void {
    this.loadCandidates();
  }

  loadCandidates(): void {
    this.loading = true;
    this.sub$.sink = this.httpClient
      .get<AllCandidatesResponse>('proposal-management/all-candidates')
      .subscribe({
        next: (response) => {
          this.candidates = response.candidates || [];
          this.activeSearchQuery = '';
          this.aiInterpretation = '';
          this.usedAiSearch = false;
          this.loading = false;
        },
        error: () => {
          this.loading = false;
        },
      });
  }

  searchCandidates(showNotFoundMessage = true): void {
    const trimmed = this.searchQuery.trim();
    if (!trimmed) {
      this.clearSearch();
      return;
    }

    this.searching = true;
    this.sub$.sink = this.httpClient
      .post<AllCandidatesAiSearchResponse>('proposal-management/all-candidates/ai-search', {
        query: trimmed,
      })
      .subscribe({
        next: (response) => {
          this.candidates = response.candidates || [];
          this.activeSearchQuery = trimmed;
          this.aiInterpretation = response.interpretation || '';
          this.usedAiSearch = !!response.usedAi;
          this.searching = false;
          this.loading = false;

          if (showNotFoundMessage && this.candidates.length === 0) {
            this.toastrService.warning(
              this.translationService.getValue('NO_CANDIDATES_FOUND')
            );
          }
        },
        error: (err: { error?: { message?: string } }) => {
          this.searching = false;
          this.toastrService.error(err?.error?.message || 'AI search failed');
        },
      });
  }

  clearSearch(): void {
    this.searchQuery = '';
    this.loadCandidates();
  }

  get hasActiveSearch(): boolean {
    return !!this.activeSearchQuery.trim();
  }

  viewHistory(candidate: GroupedCandidate): void {
    const candidateId = candidate.latestApplicationId || candidate.applications[0]?.id;
    if (!candidateId) {
      return;
    }
    void this.router.navigate(['/all-candidates', candidateId, 'history']);
  }

  showRejectionReason(candidate: GroupedCandidate): void {
    openRejectionReasonDialog(this.dialog, {
      candidateName: candidate.candidateName,
      postTitle: candidate.latestPostTitle,
      rejectionReason: candidate.latestRejectionReason || '',
    });
  }

  hasRejectionReason(stage: CandidateStage): boolean {
    return stage === 'rejected';
  }

  getStageLabel(stage: CandidateStage): string {
    return CANDIDATE_STAGE_LABELS[stage];
  }

  getMatchSourceLabel(match: CandidateSearchMatch): string {
    if (match.matchType === 'profile' || match.label) {
      return match.label || 'Candidate profile';
    }
    return match.cvOriginalName || 'Uploaded CV';
  }

  getMatchContextLabel(match: CandidateSearchMatch): string {
    if (match.matchType === 'profile' || !match.postTitle) {
      return 'Profile fields';
    }
    return match.postTitle;
  }

  getMatchTypeLabel(type: CandidateSearchMatchType): string {
    const labels: Record<CandidateSearchMatchType, string> = {
      profile: 'Profile',
      post_title: 'Job post',
      cv_filename: 'File name',
      cv_content: 'CV content',
    };
    return labels[type] || type;
  }

  openMatchCv(applicationId?: string): void {
    if (!applicationId) {
      return;
    }

    this.sub$.sink = this.httpClient
      .get(`proposal-management/candidates/${applicationId}/cv`, { responseType: 'blob' })
      .subscribe({
        next: (blob) => {
          const url = URL.createObjectURL(blob);
          window.open(url, '_blank');
        },
        error: () => {
          this.toastrService.error('Could not open CV');
        },
      });
  }

  formatDisplayDate = formatDisplayDate;
}
