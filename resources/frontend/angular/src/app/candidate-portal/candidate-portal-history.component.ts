import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, inject } from '@angular/core';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { TranslateModule } from '@ngx-translate/core';
import { BaseComponent } from '../base.component';
import { CandidateHistoryResponse } from './candidate-portal.types';
import { formatPortalDate, stageBadgeClass } from './candidate-portal.utils';

@Component({
  selector: 'app-candidate-portal-history',
  standalone: true,
  imports: [CommonModule, TranslateModule, MatProgressSpinnerModule],
  templateUrl: './candidate-portal-history.component.html',
  styleUrl: './candidate-portal-history.component.scss',
})
export class CandidatePortalHistoryComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);

  loading = false;
  history: CandidateHistoryResponse | null = null;

  ngOnInit(): void {
    this.load();
  }

  load(): void {
    this.loading = true;
    this.sub$.sink = this.httpClient
      .get<CandidateHistoryResponse>('candidate-portal/history')
      .subscribe({
        next: (response) => {
          this.history = response;
          this.loading = false;
        },
        error: () => {
          this.loading = false;
        },
      });
  }

  formatPortalDate = formatPortalDate;
  stageBadgeClass = stageBadgeClass;
}
