import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MAT_DIALOG_DATA, MatDialogModule, MatDialogRef } from '@angular/material/dialog';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatSelectModule } from '@angular/material/select';
import { ToastrService } from 'ngx-toastr';
import { FeatherIconsModule } from '@shared/feather-icons.module';
import { BaseComponent } from '../base.component';
import { ProposalCategory, ProposalDepartment, QuestionLevel } from './post-management.types';
import {
  getDefaultQuestions,
  parseQuestions,
  serializeQuestions,
} from './post-management.utils';

export interface ManageDepartmentDialogData {
  department?: ProposalDepartment;
  categories: ProposalCategory[];
}

@Component({
  selector: 'app-manage-department-dialog',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    MatDialogModule,
    MatButtonModule,
    MatFormFieldModule,
    MatIconModule,
    MatSelectModule,
    FeatherIconsModule,
  ],
  templateUrl: './manage-department-dialog.component.html',
  styleUrl: './post-departments.component.scss',
})
export class ManageDepartmentDialogComponent extends BaseComponent {
  private readonly dialogRef = inject(MatDialogRef<ManageDepartmentDialogComponent>);
  private readonly data = inject<ManageDepartmentDialogData>(MAT_DIALOG_DATA);
  private readonly httpClient = inject(HttpClient);
  private readonly toastrService = inject(ToastrService);

  categories: ProposalCategory[] = [];
  editingDepartmentId = '';
  departmentCategoryId = '';
  departmentName = '';
  deptBasicQuestions: string[] = [];
  deptIntermediateQuestions: string[] = [];
  deptExpertQuestions: string[] = [];
  readonly questionLevels: QuestionLevel[] = ['basic', 'intermediate', 'expert'];

  constructor() {
    super();
    this.categories = [...(this.data.categories ?? [])];
    if (this.data.department) {
      const dept = this.data.department;
      this.editingDepartmentId = dept.id;
      this.departmentCategoryId = dept.categoryId;
      this.departmentName = dept.name;
      this.deptBasicQuestions = parseQuestions(dept.basicQuestions, 'basic');
      this.deptIntermediateQuestions = parseQuestions(dept.intermediateQuestions, 'intermediate');
      this.deptExpertQuestions = parseQuestions(dept.expertQuestions, 'expert');
    } else {
      this.departmentCategoryId = this.categories[0]?.id || '';
      this.deptBasicQuestions = getDefaultQuestions('basic');
      this.deptIntermediateQuestions = getDefaultQuestions('intermediate');
      this.deptExpertQuestions = getDefaultQuestions('expert');
    }
  }

  saveDepartment(): void {
    if (!this.departmentName.trim() || !this.departmentCategoryId) {
      this.toastrService.warning('Enter department name and select a category');
      return;
    }
    const body = {
      categoryId: this.departmentCategoryId,
      name: this.departmentName.trim(),
      basicQuestions: serializeQuestions(this.deptBasicQuestions),
      intermediateQuestions: serializeQuestions(this.deptIntermediateQuestions),
      expertQuestions: serializeQuestions(this.deptExpertQuestions),
    };
    const req = this.editingDepartmentId
      ? this.httpClient.put(`proposal-management/departments/${this.editingDepartmentId}`, body)
      : this.httpClient.post('proposal-management/departments', body);
    this.sub$.sink = req.subscribe(() => {
      this.toastrService.success(this.editingDepartmentId ? 'Department updated' : 'Department created');
      this.dialogRef.close(true);
    });
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

  close(): void {
    this.dialogRef.close(false);
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
}
