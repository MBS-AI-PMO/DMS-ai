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
import { MatTooltipModule } from '@angular/material/tooltip';
import { RouterLink } from '@angular/router';
import { TranslateModule } from '@ngx-translate/core';
import { ToastrService } from 'ngx-toastr';
import { BaseComponent } from '../base.component';
import { PostBoardData, ProposalCategory, ProposalDepartment, QuestionLevel } from './post-management.types';
import {
  clampPageIndex,
  filterBySearch,
  getDefaultQuestions,
  parseQuestions,
  serializeQuestions,
  slicePage,
} from './post-management.utils';

@Component({
  selector: 'app-post-departments',
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
  templateUrl: './post-departments.component.html',
  styleUrl: './post-departments.component.scss',
})
export class PostDepartmentsComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly toastrService = inject(ToastrService);

  categories: ProposalCategory[] = [];
  departments: ProposalDepartment[] = [];

  showDepartmentForm = false;
  editingDepartmentId = '';
  departmentCategoryId = '';
  departmentName = '';
  deptBasicQuestions: string[] = [];
  deptIntermediateQuestions: string[] = [];
  deptExpertQuestions: string[] = [];

  departmentSearch = '';
  departmentPageIndex = 0;
  departmentPageSize = 10;
  readonly pageSizeOptions = [5, 10, 25, 50];
  readonly questionLevels: QuestionLevel[] = ['basic', 'intermediate', 'expert'];

  ngOnInit(): void {
    this.loadData();
  }

  loadData(): void {
    this.sub$.sink = this.httpClient
      .get<PostBoardData>('proposal-management/post-board')
      .subscribe((response) => {
        this.categories = response.categories || [];
        this.departments = response.departments || [];
        this.clampDepartmentPage();
      });
  }

  get filteredDepartments(): ProposalDepartment[] {
    return filterBySearch(
      this.departments,
      this.departmentSearch,
      (d) => `${d.name} ${d.categoryName || ''}`
    );
  }

  get paginatedDepartments(): ProposalDepartment[] {
    return slicePage(this.filteredDepartments, this.departmentPageIndex, this.departmentPageSize);
  }

  onDepartmentPage(event: PageEvent): void {
    this.departmentPageIndex = event.pageIndex;
    this.departmentPageSize = event.pageSize;
  }

  onDepartmentSearchChange(): void {
    this.departmentPageIndex = 0;
    this.clampDepartmentPage();
  }

  openAddDepartment(): void {
    this.resetDepartmentForm();
    this.departmentCategoryId = this.categories[0]?.id || '';
    this.showDepartmentForm = true;
  }

  saveDepartment(): void {
    if (!this.departmentName.trim() || !this.departmentCategoryId) {
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
      this.resetDepartmentForm();
      this.loadData();
    });
  }

  editDepartment(dept: ProposalDepartment): void {
    this.editingDepartmentId = dept.id;
    this.departmentCategoryId = dept.categoryId;
    this.departmentName = dept.name;
    this.deptBasicQuestions = parseQuestions(dept.basicQuestions, 'basic');
    this.deptIntermediateQuestions = parseQuestions(dept.intermediateQuestions, 'intermediate');
    this.deptExpertQuestions = parseQuestions(dept.expertQuestions, 'expert');
    this.showDepartmentForm = true;
  }

  deleteDepartment(dept: ProposalDepartment): void {
    if (!window.confirm(`Delete department "${dept.name}"?`)) {
      return;
    }
    this.sub$.sink = this.httpClient.delete(`proposal-management/departments/${dept.id}`).subscribe({
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
    this.deptBasicQuestions = getDefaultQuestions('basic');
    this.deptIntermediateQuestions = getDefaultQuestions('intermediate');
    this.deptExpertQuestions = getDefaultQuestions('expert');
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

  private getDeptQuestions(level: QuestionLevel): string[] {
    if (level === 'basic') {
      return this.deptBasicQuestions;
    }
    if (level === 'intermediate') {
      return this.deptIntermediateQuestions;
    }
    return this.deptExpertQuestions;
  }

  private clampDepartmentPage(): void {
    this.departmentPageIndex = clampPageIndex(
      this.filteredDepartments.length,
      this.departmentPageIndex,
      this.departmentPageSize
    );
  }
}
