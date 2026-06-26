import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatDialog, MatDialogModule } from '@angular/material/dialog';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { MatTooltipModule } from '@angular/material/tooltip';
import { Router, RouterLink } from '@angular/router';
import { TranslateModule } from '@ngx-translate/core';
import { ToastrService } from 'ngx-toastr';
import { DMS_FORM_DIALOG_LARGE_CONFIG } from '@core/common-dialog/form-dialog.config';
import { FeatherIconsModule } from '@shared/feather-icons.module';
import { BaseComponent } from '../base.component';
import {
  ManagePostDialogComponent,
  ManagePostDialogData,
} from './manage-post-dialog.component';
import { PostBoardData, ProposalCategory, ProposalDepartment, ProposalPost } from './post-management.types';
import {
  clampPageIndex,
  filterBySearch,
  formatDisplayDate,
  slicePage,
} from './post-management.utils';

@Component({
  selector: 'app-post-management',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    RouterLink,
    TranslateModule,
    MatButtonModule,
    MatCardModule,
    MatDialogModule,
    MatFormFieldModule,
    MatIconModule,
    MatInputModule,
    MatSelectModule,
    MatTooltipModule,
    MatPaginatorModule,
    FeatherIconsModule,
  ],
  templateUrl: './post-management.component.html',
  styleUrl: './post-management.component.scss',
})
export class PostManagementComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly router = inject(Router);
  private readonly dialog = inject(MatDialog);
  private readonly toastrService = inject(ToastrService);
  private readonly applyBaseUrl = `${window.location.protocol}//${window.location.host}/post-apply/`;

  categories: ProposalCategory[] = [];
  departments: ProposalDepartment[] = [];
  posts: ProposalPost[] = [];

  readonly pageSizeOptions = [5, 10, 25, 50];

  postSearch = '';
  postFilterCategoryId = '';
  postFilterDepartmentId = '';
  postPageIndex = 0;
  postPageSize = 10;

  ngOnInit(): void {
    this.loadData();
  }

  loadData(): void {
    this.sub$.sink = this.httpClient
      .get<PostBoardData>('proposal-management/post-board')
      .subscribe((response) => {
        this.categories = response.categories || [];
        this.departments = response.departments || [];
        this.posts = response.posts || [];
        this.clampPostPage();
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

  openManagePostDialog(post?: ProposalPost): void {
    const data: ManagePostDialogData = {
      post,
      categories: this.categories,
      departments: this.departments,
    };
    this.sub$.sink = this.dialog
      .open(ManagePostDialogComponent, { ...DMS_FORM_DIALOG_LARGE_CONFIG, data })
      .afterClosed()
      .subscribe((saved) => {
        if (saved) {
          this.loadData();
        }
      });
  }

  editPost(post: ProposalPost): void {
    this.openManagePostDialog(post);
  }

  deletePost(post: ProposalPost): void {
    if (!window.confirm(`Delete post "${post.title}"?`)) {
      return;
    }
    this.sub$.sink = this.httpClient.delete(`proposal-management/posts/${post.id}`).subscribe(() => {
      this.toastrService.success('Post deleted');
      this.loadData();
    });
  }

  selectPost(postId: string): void {
    this.router.navigate(['/post-management', postId, 'candidates']);
  }

  getApplyLink(post: ProposalPost): string {
    return `${this.applyBaseUrl}${post.id}`;
  }

  copyApplyLink(post: ProposalPost): void {
    navigator.clipboard.writeText(this.getApplyLink(post));
    this.toastrService.success('Apply link copied');
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
