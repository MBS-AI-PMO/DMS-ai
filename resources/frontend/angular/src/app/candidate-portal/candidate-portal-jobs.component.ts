import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, inject } from '@angular/core';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { TranslateModule } from '@ngx-translate/core';
import { BaseComponent } from '../base.component';
import { RecommendedJob } from './candidate-portal.types';
import { formatPortalDate } from './candidate-portal.utils';

@Component({
  selector: 'app-candidate-portal-jobs',
  standalone: true,
  imports: [
    CommonModule,
    TranslateModule,
    MatCardModule,
    MatButtonModule,
    MatIconModule,
    MatProgressSpinnerModule,
  ],
  templateUrl: './candidate-portal-jobs.component.html',
  styleUrl: './candidate-portal-jobs.component.scss',
})
export class CandidatePortalJobsComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);

  loading = false;
  jobs: RecommendedJob[] = [];

  ngOnInit(): void {
    this.load();
  }

  load(): void {
    this.loading = true;
    this.sub$.sink = this.httpClient
      .get<RecommendedJob[]>('candidate-portal/recommended-jobs')
      .subscribe({
        next: (response) => {
          this.jobs = response || [];
          this.loading = false;
        },
        error: () => {
          this.loading = false;
        },
      });
  }

  openApply(job: RecommendedJob): void {
    window.open(job.applyUrl, '_blank');
  }

  formatPortalDate = formatPortalDate;
}
