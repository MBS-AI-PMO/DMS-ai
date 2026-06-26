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
import { ActivatedRoute, RouterLink } from '@angular/router';
import { TranslateModule } from '@ngx-translate/core';
import { ToastrService } from 'ngx-toastr';
import { DMS_FORM_DIALOG_WIDE_CONFIG } from '@core/common-dialog/form-dialog.config';
import { FeatherIconsModule } from '@shared/feather-icons.module';
import { BaseComponent } from '../base.component';
import {
  ManageCategoryDialogComponent,
  ManageCategoryDialogData,
} from './manage-category-dialog.component';
import { PostBoardData, ProposalCategory, ProposalDepartment } from './post-management.types';
import { clampPageIndex, filterBySearch, slicePage } from './post-management.utils';

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
    MatDialogModule,
    MatFormFieldModule,
    MatIconModule,
    MatInputModule,
    MatTooltipModule,
    MatPaginatorModule,
    FeatherIconsModule,
  ],
  templateUrl: './post-categories.component.html',
  styleUrl: './post-categories.component.scss',
})
export class PostCategoriesComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly toastrService = inject(ToastrService);
  private readonly route = inject(ActivatedRoute);
  private readonly dialog = inject(MatDialog);

  categories: ProposalCategory[] = [];
  departments: ProposalDepartment[] = [];

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
        if (categoryId) {
          const cat = this.categories.find((c) => c.id === categoryId);
          if (cat) {
            this.openCategoryDialog(cat);
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

  openCategoryDialog(category?: ProposalCategory): void {
    const data: ManageCategoryDialogData = {
      category,
      departments: this.departments,
    };
    this.sub$.sink = this.dialog
      .open(ManageCategoryDialogComponent, { ...DMS_FORM_DIALOG_WIDE_CONFIG, data })
      .afterClosed()
      .subscribe((saved) => {
        if (saved) {
          this.loadData();
        }
      });
  }

  editCategory(cat: ProposalCategory): void {
    this.openCategoryDialog(cat);
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

  private clampCategoryPage(): void {
    this.categoryPageIndex = clampPageIndex(
      this.filteredCategories.length,
      this.categoryPageIndex,
      this.categoryPageSize
    );
  }
}
