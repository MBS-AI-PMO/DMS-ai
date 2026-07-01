import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { TranslateModule } from '@ngx-translate/core';
import { BaseComponent } from '../base.component';
import { CandidateApplication } from './candidate-portal.types';
import { formatPortalDate, stageBadgeClass } from './candidate-portal.utils';

@Component({
  selector: 'app-candidate-portal-applications',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    TranslateModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatIconModule,
    MatPaginatorModule,
    MatProgressSpinnerModule,
  ],
  templateUrl: './candidate-portal-applications.component.html',
  styleUrl: './candidate-portal-applications.component.scss',
})
export class CandidatePortalApplicationsComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);

  loading = false;
  items: CandidateApplication[] = [];
  search = '';
  pageIndex = 0;
  pageSize = 10;
  readonly pageSizeOptions = [5, 10, 25, 50];

  ngOnInit(): void {
    this.load();
  }

  load(): void {
    this.loading = true;
    this.sub$.sink = this.httpClient
      .get<CandidateApplication[]>('candidate-portal/applications')
      .subscribe({
        next: (response) => {
          this.items = response || [];
          this.clampPage();
          this.loading = false;
        },
        error: () => {
          this.loading = false;
        },
      });
  }

  get filtered(): CandidateApplication[] {
    const q = this.search.trim().toLowerCase();
    if (!q) {
      return this.items;
    }
    return this.items.filter((item) =>
      `${item.postTitle} ${item.department || ''} ${item.category || ''} ${item.stageLabel}`
        .toLowerCase()
        .includes(q)
    );
  }

  get paginated(): CandidateApplication[] {
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

  formatPortalDate = formatPortalDate;
  stageBadgeClass = stageBadgeClass;

  private clampPage(): void {
    if (this.filtered.length === 0) {
      this.pageIndex = 0;
      return;
    }
    const maxPage = Math.max(0, Math.ceil(this.filtered.length / this.pageSize) - 1);
    this.pageIndex = Math.min(this.pageIndex, maxPage);
  }
}
