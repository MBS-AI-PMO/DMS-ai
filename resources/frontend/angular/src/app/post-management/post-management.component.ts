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
import { MatTabsModule } from '@angular/material/tabs';
import { MatTooltipModule } from '@angular/material/tooltip';
import { Router } from '@angular/router';
import { TranslateModule } from '@ngx-translate/core';
import { ToastrService } from 'ngx-toastr';
import { BaseComponent } from '../base.component';

type WorkMode = 'remote' | 'physical';
type QuestionLevel = 'basic' | 'intermediate' | 'expert';

interface ProposalCandidate {
  id: string;
}

interface ProposalCategory {
  id: string;
  name: string;
}

interface ProposalDepartment {
  id: string;
  categoryId: string;
  categoryName?: string;
  name: string;
  basicQuestions?: string;
  intermediateQuestions?: string;
  expertQuestions?: string;
}

interface ProposalPost {
  id: string;
  title: string;
  departmentId?: string;
  department?: string;
  category?: string;
  experienceYears?: number;
  workMode?: WorkMode;
  address?: string;
  description?: string;
  createdDate: string;
  candidates: ProposalCandidate[];
}

interface PostBoardData {
  categories: ProposalCategory[];
  departments: ProposalDepartment[];
  posts: ProposalPost[];
}

@Component({
  selector: 'app-post-management',
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
    MatTabsModule,
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

  showCategoryForm = false;
  editingCategoryId = '';
  categoryName = '';

  showDepartmentForm = false;
  editingDepartmentId = '';
  departmentCategoryId = '';
  departmentName = '';
  deptBasicQuestions: string[] = [];
  deptIntermediateQuestions: string[] = [];
  deptExpertQuestions: string[] = [];

  showPostForm = false;
  editingPostId = '';
  newPostTitle = '';
  newPostCategoryId = '';
  newPostDepartmentId = '';
  newPostExperienceYears: number | null = null;
  newPostWorkMode: WorkMode = 'physical';
  newPostAddress = '';
  newPostDescription = '';

  readonly pageSizeOptions = [5, 10, 25, 50];

  categorySearch = '';
  categoryPageIndex = 0;
  categoryPageSize = 10;

  departmentSearch = '';
  departmentPageIndex = 0;
  departmentPageSize = 10;

  postSearch = '';
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
        this.clampAllPages();
      });
  }

  get filteredCategories(): ProposalCategory[] {
    return this.filterBySearch(this.categories, this.categorySearch, (c) => c.name);
  }

  get paginatedCategories(): ProposalCategory[] {
    return this.slicePage(this.filteredCategories, this.categoryPageIndex, this.categoryPageSize);
  }

  get filteredDepartments(): ProposalDepartment[] {
    return this.filterBySearch(
      this.departments,
      this.departmentSearch,
      (d) => `${d.name} ${d.categoryName || ''}`
    );
  }

  get paginatedDepartments(): ProposalDepartment[] {
    return this.slicePage(this.filteredDepartments, this.departmentPageIndex, this.departmentPageSize);
  }

  get filteredPosts(): ProposalPost[] {
    return this.filterBySearch(
      this.posts,
      this.postSearch,
      (p) => `${p.title} ${p.department || ''} ${p.category || ''}`
    );
  }

  get paginatedPosts(): ProposalPost[] {
    return this.slicePage(this.filteredPosts, this.postPageIndex, this.postPageSize);
  }

  onCategoryPage(event: PageEvent): void {
    this.categoryPageIndex = event.pageIndex;
    this.categoryPageSize = event.pageSize;
  }

  onDepartmentPage(event: PageEvent): void {
    this.departmentPageIndex = event.pageIndex;
    this.departmentPageSize = event.pageSize;
  }

  onPostPage(event: PageEvent): void {
    this.postPageIndex = event.pageIndex;
    this.postPageSize = event.pageSize;
  }

  onCategorySearchChange(): void {
    this.categoryPageIndex = 0;
    this.clampCategoryPage();
  }

  onDepartmentSearchChange(): void {
    this.departmentPageIndex = 0;
    this.clampDepartmentPage();
  }

  onPostSearchChange(): void {
    this.postPageIndex = 0;
    this.clampPostPage();
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

  // —— Categories ——
  saveCategory(): void {
    if (!this.categoryName.trim()) {
      return;
    }
    const body = { name: this.categoryName.trim() };
    const req = this.editingCategoryId
      ? this.httpClient.put(`proposal-management/categories/${this.editingCategoryId}`, body)
      : this.httpClient.post('proposal-management/categories', body);
    this.sub$.sink = req.subscribe(() => {
      this.toastrService.success(this.editingCategoryId ? 'Category updated' : 'Category created');
      this.resetCategoryForm();
      this.loadData();
    });
  }

  editCategory(cat: ProposalCategory): void {
    this.editingCategoryId = cat.id;
    this.categoryName = cat.name;
    this.showCategoryForm = true;
  }

  deleteCategory(cat: ProposalCategory): void {
    if (!window.confirm(`Delete category "${cat.name}"?`)) {
      return;
    }
    this.sub$.sink = this.httpClient
      .delete(`proposal-management/categories/${cat.id}`)
      .subscribe({
        next: () => {
          this.toastrService.success('Category deleted');
          this.loadData();
        },
        error: (err) => this.toastrService.error(err?.error?.message || 'Could not delete category'),
      });
  }

  resetCategoryForm(): void {
    this.showCategoryForm = false;
    this.editingCategoryId = '';
    this.categoryName = '';
  }

  // —— Departments ——
  saveDepartment(): void {
    if (!this.departmentName.trim() || !this.departmentCategoryId) {
      return;
    }
    const body = {
      categoryId: this.departmentCategoryId,
      name: this.departmentName.trim(),
      basicQuestions: this.serializeQuestions(this.deptBasicQuestions),
      intermediateQuestions: this.serializeQuestions(this.deptIntermediateQuestions),
      expertQuestions: this.serializeQuestions(this.deptExpertQuestions),
    };
    const req = this.editingDepartmentId
      ? this.httpClient.put(`proposal-management/departments/${this.editingDepartmentId}`, body)
      : this.httpClient.post('proposal-management/departments', body);
    this.sub$.sink = req.subscribe(() => {
      this.toastrService.success(this.editingDepartmentId ? 'Department updated' : 'Department created');
      this.resetDepartmentForm();
      this.loadData();
    });
  }

  editDepartment(dept: ProposalDepartment): void {
    this.editingDepartmentId = dept.id;
    this.departmentCategoryId = dept.categoryId;
    this.departmentName = dept.name;
    this.deptBasicQuestions = this.parseQuestions(dept.basicQuestions, 'basic');
    this.deptIntermediateQuestions = this.parseQuestions(dept.intermediateQuestions, 'intermediate');
    this.deptExpertQuestions = this.parseQuestions(dept.expertQuestions, 'expert');
    this.showDepartmentForm = true;
  }

  deleteDepartment(dept: ProposalDepartment): void {
    if (!window.confirm(`Delete department "${dept.name}"?`)) {
      return;
    }
    this.sub$.sink = this.httpClient
      .delete(`proposal-management/departments/${dept.id}`)
      .subscribe({
        next: () => {
          this.toastrService.success('Department deleted');
          this.loadData();
        },
        error: (err) => this.toastrService.error(err?.error?.message || 'Could not delete department'),
      });
  }

  resetDepartmentForm(): void {
    this.showDepartmentForm = false;
    this.editingDepartmentId = '';
    this.departmentCategoryId = this.categories[0]?.id || '';
    this.departmentName = '';
    this.deptBasicQuestions = this.getDefaultQuestions('basic');
    this.deptIntermediateQuestions = this.getDefaultQuestions('intermediate');
    this.deptExpertQuestions = this.getDefaultQuestions('expert');
  }

  openNewDepartmentForm(): void {
    this.resetDepartmentForm();
    this.departmentCategoryId = this.categories[0]?.id || '';
    this.showDepartmentForm = true;
  }

  // —— Posts ——
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

  addDeptQuestion(level: QuestionLevel): void {
    this.getDeptQuestions(level).push('');
  }

  removeDeptQuestion(level: QuestionLevel, index: number): void {
    const questions = this.getDeptQuestions(level);
    if (questions.length === 1) {
      questions[0] = '';
      return;
    }
    questions.splice(index, 1);
  }

  trackByIndex(index: number): number {
    return index;
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
  }

  openNewPostForm(): void {
    this.resetPostForm();
    this.showPostForm = true;
  }

  private getDeptQuestions(level: QuestionLevel): string[] {
    if (level === 'basic') {
      return this.deptBasicQuestions;
    }
    if (level === 'intermediate') {
      return this.deptIntermediateQuestions;
    }
    return this.deptExpertQuestions;
  }

  private getDefaultQuestions(level: QuestionLevel): string[] {
    const defaults: Record<QuestionLevel, string[]> = {
      basic: ['Tell us about yourself.', 'Why this role?', 'Relevant skills?', 'Describe a task you completed.'],
      intermediate: ['Challenging project?', 'Prioritize tasks?', 'Problem you solved?', 'Communication style?'],
      expert: ['Complex problem end-to-end?', 'Mentoring experience?', 'Trade-offs decision?', 'Improve workflow?'],
    };
    return [...defaults[level]];
  }

  private parseQuestions(value: string | undefined, level: QuestionLevel): string[] {
    const questions = (value || '')
      .split(/\r?\n/)
      .map((q) => q.trim())
      .filter((q) => q.length > 0);
    return questions.length ? questions : this.getDefaultQuestions(level);
  }

  private serializeQuestions(questions: string[]): string {
    return questions.map((q) => q.trim()).filter((q) => q.length > 0).join('\n');
  }

  formatDisplayDate(value?: string | null): string {
    if (value == null || value === '' || value === 'null') {
      return '—';
    }
    const parsed = new Date(value);
    if (isNaN(parsed.getTime())) {
      return '—';
    }
    return parsed.toLocaleDateString(undefined, { year: 'numeric', month: 'short', day: 'numeric' });
  }

  private filterBySearch<T>(items: T[], query: string, getText: (item: T) => string): T[] {
    const term = query.trim().toLowerCase();
    if (!term) {
      return items;
    }
    return items.filter((item) => getText(item).toLowerCase().includes(term));
  }

  private slicePage<T>(items: T[], pageIndex: number, pageSize: number): T[] {
    const start = pageIndex * pageSize;
    return items.slice(start, start + pageSize);
  }

  private clampAllPages(): void {
    this.clampCategoryPage();
    this.clampDepartmentPage();
    this.clampPostPage();
  }

  private clampCategoryPage(): void {
    this.categoryPageIndex = this.clampPageIndex(
      this.filteredCategories.length,
      this.categoryPageIndex,
      this.categoryPageSize
    );
  }

  private clampDepartmentPage(): void {
    this.departmentPageIndex = this.clampPageIndex(
      this.filteredDepartments.length,
      this.departmentPageIndex,
      this.departmentPageSize
    );
  }

  private clampPostPage(): void {
    this.postPageIndex = this.clampPageIndex(
      this.filteredPosts.length,
      this.postPageIndex,
      this.postPageSize
    );
  }

  private clampPageIndex(total: number, pageIndex: number, pageSize: number): number {
    if (total === 0) {
      return 0;
    }
    const maxPage = Math.max(0, Math.ceil(total / pageSize) - 1);
    return Math.min(pageIndex, maxPage);
  }
}
