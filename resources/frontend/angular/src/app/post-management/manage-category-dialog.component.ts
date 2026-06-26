import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MAT_DIALOG_DATA, MatDialogModule, MatDialogRef } from '@angular/material/dialog';
import { MatIconModule } from '@angular/material/icon';
import { MatTooltipModule } from '@angular/material/tooltip';
import { ToastrService } from 'ngx-toastr';
import { forkJoin, of, switchMap } from 'rxjs';
import { FeatherIconsModule } from '@shared/feather-icons.module';
import { BaseComponent } from '../base.component';
import { ProposalCategory, ProposalDepartment } from './post-management.types';
import { getDefaultQuestions, serializeQuestions } from './post-management.utils';

export interface ManageCategoryDialogData {
  category?: ProposalCategory;
  departments: ProposalDepartment[];
}

interface DepartmentFormRow {
  id?: string;
  name: string;
}

@Component({
  selector: 'app-manage-category-dialog',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    MatDialogModule,
    MatButtonModule,
    MatIconModule,
    MatTooltipModule,
    FeatherIconsModule,
  ],
  templateUrl: './manage-category-dialog.component.html',
})
export class ManageCategoryDialogComponent extends BaseComponent {
  private readonly dialogRef = inject(MatDialogRef<ManageCategoryDialogComponent>);
  private readonly data = inject<ManageCategoryDialogData>(MAT_DIALOG_DATA);
  private readonly httpClient = inject(HttpClient);
  private readonly toastrService = inject(ToastrService);

  editingCategoryId = '';
  categoryName = '';
  departmentRows: DepartmentFormRow[] = [{ name: '' }];

  constructor() {
    super();
    if (this.data.category) {
      this.editingCategoryId = this.data.category.id;
      this.categoryName = this.data.category.name;
      const existing = this.data.departments.filter((d) => d.categoryId === this.data.category!.id);
      this.departmentRows = existing.length
        ? existing.map((d) => ({ id: d.id, name: d.name }))
        : [{ name: '' }];
    }
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
          this.dialogRef.close(true);
        });
      return;
    }

    this.sub$.sink = this.httpClient
      .post<ProposalCategory>('proposal-management/categories', body)
      .pipe(switchMap((category) => this.syncDepartmentsForCategory(category.id)))
      .subscribe(() => {
        this.toastrService.success('Category and departments created');
        this.dialogRef.close(true);
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

  close(): void {
    this.dialogRef.close(false);
  }
}
