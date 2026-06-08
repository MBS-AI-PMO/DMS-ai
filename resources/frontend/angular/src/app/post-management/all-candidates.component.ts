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
import {
  AllCandidatesResponse,
  CANDIDATE_STAGE_LABELS,
  CandidateStage,
  GroupedCandidate,
} from './all-candidate.types';
import { filterBySearch, formatDisplayDate } from './post-management.utils';

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

  viewHistory(candidate: GroupedCandidate): void {
    const candidateId = candidate.latestApplicationId || candidate.applications[0]?.id;
    if (!candidateId) {
      return;
    }
    void this.router.navigate(['/all-candidates', candidateId, 'history']);
  }

  getStageLabel(stage: CandidateStage): string {
    return CANDIDATE_STAGE_LABELS[stage];
  }

  formatDisplayDate = formatDisplayDate;
}
