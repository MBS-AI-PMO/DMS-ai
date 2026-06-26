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
import { MatPaginatorModule, PageEvent } from '@angular/material/paginator';
import { MatTooltipModule } from '@angular/material/tooltip';
import { RouterLink } from '@angular/router';
import { TranslateModule } from '@ngx-translate/core';
import { ToastrService } from 'ngx-toastr';
import { DMS_FORM_DIALOG_LARGE_CONFIG } from '@core/common-dialog/form-dialog.config';
import { FeatherIconsModule } from '@shared/feather-icons.module';
import { BaseComponent } from '../base.component';
import {
  ManageDepartmentDialogComponent,
  ManageDepartmentDialogData,
} from './manage-department-dialog.component';
import { PostBoardData, ProposalCategory, ProposalDepartment } from './post-management.types';
import { clampPageIndex, filterBySearch, slicePage } from './post-management.utils';

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
    MatDialogModule,
    MatFormFieldModule,
    MatIconModule,
    MatInputModule,
    MatTooltipModule,
    MatPaginatorModule,
    FeatherIconsModule,
  ],
  templateUrl: './post-departments.component.html',
  styleUrl: './post-departments.component.scss',
})
export class PostDepartmentsComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly toastrService = inject(ToastrService);
  private readonly dialog = inject(MatDialog);

  categories: ProposalCategory[] = [];
  departments: ProposalDepartment[] = [];

  departmentSearch = '';
  departmentPageIndex = 0;
  departmentPageSize = 10;
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

  openDepartmentDialog(department?: ProposalDepartment): void {
    const data: ManageDepartmentDialogData = {
      department,
      categories: this.categories,
    };
    this.sub$.sink = this.dialog
      .open(ManageDepartmentDialogComponent, { ...DMS_FORM_DIALOG_LARGE_CONFIG, data })
      .afterClosed()
      .subscribe((saved) => {
        if (saved) {
          this.loadData();
        }
      });
  }

  editDepartment(dept: ProposalDepartment): void {
    this.openDepartmentDialog(dept);
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

  private clampDepartmentPage(): void {
    this.departmentPageIndex = clampPageIndex(
      this.filteredDepartments.length,
      this.departmentPageIndex,
      this.departmentPageSize
    );
  }
}
