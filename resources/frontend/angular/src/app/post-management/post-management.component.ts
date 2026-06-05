import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { MatTooltipModule } from '@angular/material/tooltip';
import { Router, RouterLink } from '@angular/router';
import { TranslateModule } from '@ngx-translate/core';
import { ToastrService } from 'ngx-toastr';
import { forkJoin, of, switchMap } from 'rxjs';
import { BaseComponent } from '../base.component';
import {
  PostBoardData,
  ProposalCategory,
  ProposalDepartment,
  ProposalPost,
  WorkMode,
} from './post-management.types';
import {
  clampPageIndex,
  filterBySearch,
  formatDisplayDate,
  getDefaultQuestions,
  serializeQuestions,
  slicePage,
} from './post-management.utils';

interface PostInlineDeptRow {
  name: string;
}

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
    MatFormFieldModule,
    MatIconModule,
    MatInputModule,
    MatSelectModule,
    MatTooltipModule,
    MatPaginatorModule,
  ],
  templateUrl: './post-management.component.html',
  styleUrl: './post-management.component.scss',
})
export class PostManagementComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly router = inject(Router);
  private readonly toastrService = inject(ToastrService);
  private readonly applyBaseUrl = `${window.location.protocol}//${window.location.host}/post-apply/`;

  categories: ProposalCategory[] = [];
  departments: ProposalDepartment[] = [];
  posts: ProposalPost[] = [];

  readonly addCategoryOption = '__add_category__';
  readonly addDepartmentOption = '__add_department__';

  showPostForm = false;
  editingPostId = '';
  newPostTitle = '';
  newPostCategoryId = '';
  newPostDepartmentId = '';

  showPostInlineCategory = false;
  showPostInlineDepartment = false;
  postInlineCategoryName = '';
  postInlineDepartmentName = '';
  postInlineDeptRows: PostInlineDeptRow[] = [];

  newPostExperienceYears: number | null = null;
  newPostWorkMode: WorkMode = 'physical';
  newPostAddress = '';
  newPostDescription = '';

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

  get postFormDepartments(): ProposalDepartment[] {
    if (!this.newPostCategoryId) {
      return [];
    }
    return this.departments.filter((d) => d.categoryId === this.newPostCategoryId);
  }

  get selectedDepartment(): ProposalDepartment | undefined {
    return this.departments.find((d) => d.id === this.newPostDepartmentId);
  }

  onPostCategoryChange(): void {
    const depts = this.postFormDepartments;
    if (!depts.some((d) => d.id === this.newPostDepartmentId)) {
      this.newPostDepartmentId = '';
    }
  }

  onPostCategorySelect(value: string): void {
    if (value === this.addCategoryOption) {
      this.newPostCategoryId = '';
      this.newPostDepartmentId = '';
      this.openPostInlineCategory();
      return;
    }
    this.showPostInlineCategory = false;
    this.onPostCategoryChange();
  }

  onPostDepartmentSelect(value: string): void {
    if (value === this.addDepartmentOption) {
      this.newPostDepartmentId = '';
      this.openPostInlineDepartment();
      return;
    }
    this.showPostInlineDepartment = false;
  }

  openPostInlineCategory(): void {
    this.showPostInlineCategory = true;
    this.showPostInlineDepartment = false;
    this.postInlineCategoryName = '';
    this.postInlineDeptRows = [{ name: '' }];
  }

  cancelPostInlineCategory(): void {
    this.showPostInlineCategory = false;
    this.postInlineCategoryName = '';
    this.postInlineDeptRows = [];
  }

  addPostInlineDeptRow(): void {
    this.postInlineDeptRows.push({ name: '' });
  }

  removePostInlineDeptRow(index: number): void {
    if (this.postInlineDeptRows.length === 1) {
      this.postInlineDeptRows[0].name = '';
      return;
    }
    this.postInlineDeptRows.splice(index, 1);
  }

  trackByIndex(index: number): number {
    return index;
  }

  openPostInlineDepartment(): void {
    if (!this.newPostCategoryId) {
      this.toastrService.warning('Select a category first, or add a new one below');
      this.openPostInlineCategory();
      return;
    }
    this.showPostInlineDepartment = true;
    this.showPostInlineCategory = false;
    this.postInlineDepartmentName = '';
  }

  cancelPostInlineDepartment(): void {
    this.showPostInlineDepartment = false;
    this.postInlineDepartmentName = '';
  }

  savePostInlineCategory(): void {
    const name = this.postInlineCategoryName.trim();
    if (!name) {
      this.toastrService.warning('Enter a category name');
      return;
    }
    this.sub$.sink = this.httpClient
      .post<ProposalCategory>('proposal-management/categories', { name })
      .pipe(
        switchMap((category) => {
          const deptNames = this.postInlineDeptRows.map((r) => r.name.trim()).filter((n) => n.length > 0);
          if (!deptNames.length) {
            return of({ categoryId: category.id, departmentId: null as string | null });
          }
          const requests = deptNames.map((deptName) =>
            this.httpClient.post<ProposalDepartment>('proposal-management/departments', {
              categoryId: category.id,
              name: deptName,
              basicQuestions: serializeQuestions(getDefaultQuestions('basic')),
              intermediateQuestions: serializeQuestions(getDefaultQuestions('intermediate')),
              expertQuestions: serializeQuestions(getDefaultQuestions('expert')),
            })
          );
          return forkJoin(requests).pipe(
            switchMap((depts) =>
              of({ categoryId: category.id, departmentId: depts[depts.length - 1]?.id ?? null })
            )
          );
        })
      )
      .subscribe(({ categoryId, departmentId }) => {
        this.finishCategoryInlineSave(categoryId, departmentId);
      });
  }

  private finishCategoryInlineSave(categoryId: string, departmentId: string | null): void {
    this.toastrService.success('Category added');
    this.cancelPostInlineCategory();
    this.sub$.sink = this.httpClient.get<PostBoardData>('proposal-management/post-board').subscribe((response) => {
      this.categories = response.categories || [];
      this.departments = response.departments || [];
      this.newPostCategoryId = categoryId;
      this.onPostCategoryChange();
      if (departmentId) {
        this.newPostDepartmentId = departmentId;
      }
    });
  }

  savePostInlineDepartment(): void {
    const name = this.postInlineDepartmentName.trim();
    if (!name) {
      this.toastrService.warning('Enter a department name');
      return;
    }
    if (!this.newPostCategoryId) {
      this.toastrService.warning('Select a category first');
      return;
    }
    const body = {
      categoryId: this.newPostCategoryId,
      name,
      basicQuestions: serializeQuestions(getDefaultQuestions('basic')),
      intermediateQuestions: serializeQuestions(getDefaultQuestions('intermediate')),
      expertQuestions: serializeQuestions(getDefaultQuestions('expert')),
    };
    this.sub$.sink = this.httpClient
      .post<ProposalDepartment>('proposal-management/departments', body)
      .subscribe((department) => {
        this.toastrService.success('Department added');
        this.cancelPostInlineDepartment();
        this.sub$.sink = this.httpClient.get<PostBoardData>('proposal-management/post-board').subscribe((response) => {
          this.categories = response.categories || [];
          this.departments = response.departments || [];
          this.newPostDepartmentId = department.id;
        });
      });
  }

  createPost(): void {
    if (!this.newPostCategoryId) {
      this.toastrService.warning('Select a category');
      return;
    }
    if (!this.newPostTitle.trim() || !this.newPostDepartmentId) {
      this.toastrService.warning('Select a department for this post');
      return;
    }

    const body = {
      title: this.newPostTitle.trim(),
      departmentId: this.newPostDepartmentId,
      experienceYears: this.newPostExperienceYears,
      workMode: this.newPostWorkMode,
      address: this.newPostWorkMode === 'physical' ? this.newPostAddress.trim() : '',
      description: this.newPostDescription.trim(),
    };

    if (this.editingPostId) {
      this.sub$.sink = this.httpClient
        .put(`proposal-management/posts/${this.editingPostId}`, body)
        .subscribe(() => {
          this.toastrService.success('Post updated');
          this.resetPostForm();
          this.loadData();
        });
      return;
    }

    this.sub$.sink = this.httpClient.post('proposal-management/posts', body).subscribe(() => {
      this.toastrService.success('Post created — interview questions copied from department');
      this.resetPostForm();
      this.loadData();
    });
  }

  editPost(post: ProposalPost): void {
    this.editingPostId = post.id;
    this.newPostTitle = post.title;
    const dept = this.departments.find(
      (d) => d.id === post.departmentId || d.name === post.department
    );
    this.newPostDepartmentId = dept?.id || post.departmentId || '';
    this.newPostCategoryId =
      dept?.categoryId ||
      this.categories.find((c) => c.name === post.category)?.id ||
      '';
    this.newPostExperienceYears = post.experienceYears ?? null;
    this.newPostWorkMode = post.workMode || 'physical';
    this.newPostAddress = post.address || '';
    this.newPostDescription = post.description || '';
    this.showPostForm = true;
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

  resetPostForm(): void {
    this.editingPostId = '';
    this.newPostTitle = '';
    this.newPostCategoryId = '';
    this.newPostDepartmentId = '';
    this.newPostExperienceYears = null;
    this.newPostWorkMode = 'physical';
    this.newPostAddress = '';
    this.newPostDescription = '';
    this.showPostForm = false;
    this.cancelPostInlineCategory();
    this.cancelPostInlineDepartment();
  }

  openNewPostForm(): void {
    this.resetPostForm();
    this.showPostForm = true;
  }

  formatDisplayDate = formatDisplayDate;

  private clampPostPage(): void {
    this.postPageIndex = clampPageIndex(
      this.filteredPosts.length,
      this.postPageIndex,
      this.postPageSize
    );
  }
}
