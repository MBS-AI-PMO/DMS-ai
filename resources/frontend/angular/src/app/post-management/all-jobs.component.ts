import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { MatSelectModule } from '@angular/material/select';
import { Router } from '@angular/router';
import { TranslateModule } from '@ngx-translate/core';
import { FeatherIconsModule } from '@shared/feather-icons.module';
import { BaseComponent } from '../base.component';
import { PostBoardData, ProposalCategory, ProposalDepartment, ProposalPost } from './post-management.types';
import { clampPageIndex, filterBySearch, formatDisplayDate, slicePage } from './post-management.utils';

@Component({
  selector: 'app-all-jobs',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    TranslateModule,
    MatButtonModule,
    MatCardModule,
    MatFormFieldModule,
    MatIconModule,
    MatInputModule,
    MatSelectModule,
    MatPaginatorModule,
    FeatherIconsModule,
  ],
  templateUrl: './all-jobs.component.html',
  styleUrl: './all-jobs.component.scss',
})
export class AllJobsComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly router = inject(Router);

  categories: ProposalCategory[] = [];
  departments: ProposalDepartment[] = [];
  posts: ProposalPost[] = [];
  loading = false;

  readonly pageSizeOptions = [6, 12, 24, 48];

  postSearch = '';
  postFilterCategoryId = '';
  postFilterDepartmentId = '';
  postPageIndex = 0;
  postPageSize = 12;

  ngOnInit(): void {
    this.loadData();
  }

  loadData(): void {
    this.loading = true;
    this.sub$.sink = this.httpClient.get<PostBoardData>('proposal-management/post-board').subscribe({
      next: (response) => {
        this.categories = response.categories || [];
        this.departments = response.departments || [];
        this.posts = response.posts || [];
        this.clampPostPage();
        this.loading = false;
      },
      error: () => {
        this.loading = false;
      },
    });
  }

  get listFilterDepartments(): ProposalDepartment[] {
    if (!this.postFilterCategoryId) {
      return this.departments;
    }
    return this.departments.filter((d) => d.categoryId === this.postFilterCategoryId);
  }

  get hasActivePostFilters(): boolean {
    return !!(this.postFilterCategoryId || this.postFilterDepartmentId || this.postSearch.trim());
  }

  get filteredPosts(): ProposalPost[] {
    let items = this.posts;
    if (this.postFilterCategoryId) {
      items = items.filter((p) => this.postMatchesCategory(p, this.postFilterCategoryId));
    }
    if (this.postFilterDepartmentId) {
      items = items.filter((p) => this.postMatchesDepartment(p, this.postFilterDepartmentId));
    }
    return filterBySearch(
      items,
      this.postSearch,
      (p) => `${p.title} ${p.department || ''} ${p.category || ''}`
    );
  }

  get paginatedPosts(): ProposalPost[] {
    return slicePage(this.filteredPosts, this.postPageIndex, this.postPageSize);
  }

  onPostPage(event: PageEvent): void {
    this.postPageIndex = event.pageIndex;
    this.postPageSize = event.pageSize;
  }

  onPostSearchChange(): void {
    this.postPageIndex = 0;
    this.clampPostPage();
  }

  onPostFilterCategoryChange(): void {
    if (this.postFilterDepartmentId) {
      const dept = this.departments.find((d) => d.id === this.postFilterDepartmentId);
      if (dept && this.postFilterCategoryId && dept.categoryId !== this.postFilterCategoryId) {
        this.postFilterDepartmentId = '';
      }
    }
    this.postPageIndex = 0;
    this.clampPostPage();
  }

  onPostFilterDepartmentChange(): void {
    this.postPageIndex = 0;
    this.clampPostPage();
  }

  clearPostFilters(): void {
    this.postSearch = '';
    this.postFilterCategoryId = '';
    this.postFilterDepartmentId = '';
    this.postPageIndex = 0;
    this.clampPostPage();
  }

  viewJob(post: ProposalPost): void {
    void this.router.navigate(['/all-jobs', post.id]);
  }

  formatDisplayDate = formatDisplayDate;

  private postMatchesCategory(post: ProposalPost, categoryId: string): boolean {
    const cat = this.categories.find((c) => c.id === categoryId);
    if (!cat) {
      return true;
    }
    if (post.category === cat.name) {
      return true;
    }
    const dept = this.departments.find(
      (d) => d.id === post.departmentId || d.name === post.department
    );
    return dept?.categoryId === categoryId;
  }

  private postMatchesDepartment(post: ProposalPost, departmentId: string): boolean {
    if (post.departmentId === departmentId) {
      return true;
    }
    const dept = this.departments.find((d) => d.id === departmentId);
    return dept ? post.department === dept.name : false;
  }

  private clampPostPage(): void {
    this.postPageIndex = clampPageIndex(
      this.filteredPosts.length,
      this.postPageIndex,
      this.postPageSize
    );
  }
}
