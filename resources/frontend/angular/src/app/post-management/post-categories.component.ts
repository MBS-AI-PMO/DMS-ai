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
import { MatTooltipModule } from '@angular/material/tooltip';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { TranslateModule } from '@ngx-translate/core';
import { ToastrService } from 'ngx-toastr';
import { forkJoin, of, switchMap } from 'rxjs';
import { BaseComponent } from '../base.component';
import { PostBoardData, ProposalCategory, ProposalDepartment } from './post-management.types';
import {
  clampPageIndex,
  filterBySearch,
  getDefaultQuestions,
  serializeQuestions,
  slicePage,
} from './post-management.utils';

interface DepartmentFormRow {
  id?: string;
  name: string;
}

@Component({
  selector: 'app-post-categories',
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
    MatTooltipModule,
    MatPaginatorModule,
  ],
  templateUrl: './post-categories.component.html',
  styleUrl: './post-categories.component.scss',
})
export class PostCategoriesComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly toastrService = inject(ToastrService);
  private readonly route = inject(ActivatedRoute);

  categories: ProposalCategory[] = [];
  departments: ProposalDepartment[] = [];

  showCategoryForm = false;
  editingCategoryId = '';
  categoryName = '';
  departmentRows: DepartmentFormRow[] = [];

  categorySearch = '';
  categoryPageIndex = 0;
  categoryPageSize = 10;
  readonly pageSizeOptions = [5, 10, 25, 50];

  ngOnInit(): void {
    this.loadData();
  }

  loadData(): void {
    this.sub$.sink = this.httpClient
      .get<PostBoardData>('proposal-management/post-board')
      .subscribe((response) => {
        this.categories = response.categories || [];
        this.departments = response.departments || [];
        this.clampCategoryPage();

        const categoryId = this.route.snapshot.queryParamMap.get('categoryId');
        if (categoryId && !this.showCategoryForm) {
          const cat = this.categories.find((c) => c.id === categoryId);
          if (cat) {
            this.editCategory(cat);
          }
        }
      });
  }

  get filteredCategories(): ProposalCategory[] {
    return filterBySearch(this.categories, this.categorySearch, (c) => c.name);
  }

  get paginatedCategories(): ProposalCategory[] {
    return slicePage(this.filteredCategories, this.categoryPageIndex, this.categoryPageSize);
  }

  getDepartmentsForCategory(categoryId: string): ProposalDepartment[] {
    return this.departments.filter((d) => d.categoryId === categoryId);
  }

  getDepartmentLabels(categoryId: string): string {
    const names = this.getDepartmentsForCategory(categoryId).map((d) => d.name);
    return names.length ? names.join(', ') : '—';
  }

  onCategoryPage(event: PageEvent): void {
    this.categoryPageIndex = event.pageIndex;
    this.categoryPageSize = event.pageSize;
  }

  onCategorySearchChange(): void {
    this.categoryPageIndex = 0;
    this.clampCategoryPage();
  }

  openAddCategory(): void {
    this.resetCategoryForm();
    this.departmentRows = [{ name: '' }];
    this.showCategoryForm = true;
  }

  addDepartmentRow(): void {
    this.departmentRows.push({ name: '' });
  }

  removeDepartmentRow(index: number): void {
    if (this.departmentRows.length === 1) {
      this.departmentRows[0].name = '';
      return;
    }
    this.departmentRows.splice(index, 1);
  }

  trackByIndex(index: number): number {
    return index;
  }

  saveCategory(): void {
    if (!this.categoryName.trim()) {
      this.toastrService.warning('Enter a category name');
      return;
    }

    const body = { name: this.categoryName.trim() };

    if (this.editingCategoryId) {
      this.sub$.sink = this.httpClient
        .put(`proposal-management/categories/${this.editingCategoryId}`, body)
        .pipe(switchMap(() => this.syncDepartmentsForCategory(this.editingCategoryId)))
        .subscribe(() => {
          this.toastrService.success('Category and departments saved');
          this.resetCategoryForm();
          this.loadData();
        });
      return;
    }

    this.sub$.sink = this.httpClient
      .post<ProposalCategory>('proposal-management/categories', body)
      .pipe(switchMap((category) => this.syncDepartmentsForCategory(category.id)))
      .subscribe(() => {
        this.toastrService.success('Category and departments created');
        this.resetCategoryForm();
        this.loadData();
      });
  }

  private syncDepartmentsForCategory(categoryId: string) {
    const rows = this.departmentRows.filter((r) => r.name.trim());
    if (!rows.length) {
      return of(null);
    }

    const requests = rows.map((row) => {
      const deptBody = {
        categoryId,
        name: row.name.trim(),
        basicQuestions: serializeQuestions(getDefaultQuestions('basic')),
        intermediateQuestions: serializeQuestions(getDefaultQuestions('intermediate')),
        expertQuestions: serializeQuestions(getDefaultQuestions('expert')),
      };
      if (row.id) {
        return this.httpClient.put(`proposal-management/departments/${row.id}`, deptBody);
      }
      return this.httpClient.post('proposal-management/departments', deptBody);
    });

    return forkJoin(requests);
  }

  editCategory(cat: ProposalCategory): void {
    this.editingCategoryId = cat.id;
    this.categoryName = cat.name;
    const existing = this.getDepartmentsForCategory(cat.id);
    this.departmentRows = existing.length
      ? existing.map((d) => ({ id: d.id, name: d.name }))
      : [{ name: '' }];
    this.showCategoryForm = true;
  }

  deleteCategory(cat: ProposalCategory): void {
    if (!window.confirm(`Delete category "${cat.name}" and its departments?`)) {
      return;
    }
    this.sub$.sink = this.httpClient.delete(`proposal-management/categories/${cat.id}`).subscribe({
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
    this.departmentRows = [];
  }

  private clampCategoryPage(): void {
    this.categoryPageIndex = clampPageIndex(
      this.filteredCategories.length,
      this.categoryPageIndex,
      this.categoryPageSize
    );
  }
}
