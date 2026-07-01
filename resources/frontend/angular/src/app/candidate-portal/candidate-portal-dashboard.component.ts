import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, inject } from '@angular/core';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { Router } from '@angular/router';
import { TranslateModule } from '@ngx-translate/core';
import { BaseComponent } from '../base.component';
import { CandidateDashboardResponse } from './candidate-portal.types';
import { formatPortalDate, stageBadgeClass } from './candidate-portal.utils';

@Component({
  selector: 'app-candidate-portal-dashboard',
  standalone: true,
  imports: [
    CommonModule,
    TranslateModule,
    MatCardModule,
    MatButtonModule,
    MatIconModule,
    MatProgressSpinnerModule,
  ],
  templateUrl: './candidate-portal-dashboard.component.html',
  styleUrl: './candidate-portal-dashboard.component.scss',
})
export class CandidatePortalDashboardComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly router = inject(Router);

  loading = false;
  data: CandidateDashboardResponse | null = null;

  ngOnInit(): void {
    this.load();
  }

  load(): void {
    this.loading = true;
    this.sub$.sink = this.httpClient
      .get<CandidateDashboardResponse>('candidate-portal/dashboard')
      .subscribe({
        next: (response) => {
          this.data = response;
          this.loading = false;
        },
        error: () => {
          this.loading = false;
        },
      });
  }

  goApplications(): void {
    void this.router.navigate(['/candidate-portal/applications']);
  }

  goJobs(): void {
    void this.router.navigate(['/candidate-portal/jobs']);
  }

  formatPortalDate = formatPortalDate;
  stageBadgeClass = stageBadgeClass;
}
