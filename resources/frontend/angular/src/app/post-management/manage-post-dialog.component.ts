import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MAT_DIALOG_DATA, MatDialogModule, MatDialogRef } from '@angular/material/dialog';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { ToastrService } from 'ngx-toastr';
import { CKEditorModule } from '@ckeditor/ckeditor5-angular';
import ClassicEditor from '@ckeditor/ckeditor5-build-classic';
import { firstValueFrom, forkJoin, of, switchMap } from 'rxjs';
import { FeatherIconsModule } from '@shared/feather-icons.module';
import { BaseComponent } from '../base.component';
import {
  PostBoardData,
  ProposalCategory,
  ProposalDepartment,
  ProposalPost,
  WorkMode,
} from './post-management.types';
import { getDefaultQuestions, serializeQuestions } from './post-management.utils';

export interface ManagePostDialogData {
  post?: ProposalPost;
  categories: ProposalCategory[];
  departments: ProposalDepartment[];
}

interface PostInlineDeptRow {
  name: string;
}

@Component({
  selector: 'app-manage-post-dialog',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    MatDialogModule,
    MatButtonModule,
    MatFormFieldModule,
    MatIconModule,
    MatInputModule,
    MatSelectModule,
    FeatherIconsModule,
    CKEditorModule,
  ],
  templateUrl: './manage-post-dialog.component.html',
  styleUrl: './manage-post-dialog.component.scss',
})
export class ManagePostDialogComponent extends BaseComponent {
  private readonly dialogRef = inject(MatDialogRef<ManagePostDialogComponent>);
  private readonly data = inject<ManagePostDialogData>(MAT_DIALOG_DATA);
  private readonly httpClient = inject(HttpClient);
  private readonly toastrService = inject(ToastrService);

  categories: ProposalCategory[] = [];
  departments: ProposalDepartment[] = [];

  readonly addCategoryOption = '__add_category__';
  readonly addDepartmentOption = '__add_department__';

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

  readonly editor = ClassicEditor;
  onEditorReady(editor: ClassicEditor): void {
    editor.plugins.get('FileRepository').createUploadAdapter = (loader) => {
      return new PostDescriptionImageUploadAdapter(loader, this.httpClient, this.toastrService);
    };
  }

  readonly editorConfig = {
    toolbar: {
      items: [
        'heading',
        '|',
        'bold',
        'italic',
        '|',
        'bulletedList',
        'numberedList',
        '|',
        'link',
        'uploadImage',
        'blockQuote',
        '|',
        'undo',
        'redo',
      ],
    },
    image: {
      toolbar: ['imageTextAlternative', 'imageStyle:inline', 'imageStyle:block', 'imageStyle:side'],
    },
    removePlugins: ['CKBox', 'CKFinder', 'EasyImage'],
    language: 'en',
    placeholder: 'Job summary and requirements',
  };

  constructor() {
    super();
    this.categories = [...(this.data.categories ?? [])];
    this.departments = [...(this.data.departments ?? [])];
    if (this.data.post) {
      this.loadPost(this.data.post);
    }
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
      this.toastrService.warning('Select a category first, or add a new one');
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
        this.toastrService.success('Category added');
        this.cancelPostInlineCategory();
        this.refreshBoard(categoryId, departmentId);
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
        this.refreshBoard(this.newPostCategoryId, department.id);
      });
  }

  private refreshBoard(categoryId: string, departmentId: string | null): void {
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

  savePost(): void {
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
      description: this.newPostDescription || '',
    };

    const req = this.editingPostId
      ? this.httpClient.put(`proposal-management/posts/${this.editingPostId}`, body)
      : this.httpClient.post('proposal-management/posts', body);

    this.sub$.sink = req.subscribe(() => {
      this.toastrService.success(this.editingPostId ? 'Post updated' : 'Post created');
      this.dialogRef.close(true);
    });
  }

  close(): void {
    this.dialogRef.close(false);
  }

  private loadPost(post: ProposalPost): void {
    this.editingPostId = post.id;
    this.newPostTitle = post.title;
    const dept = this.departments.find(
      (d) => d.id === post.departmentId || d.name === post.department
    );
    this.newPostDepartmentId = dept?.id || post.departmentId || '';
    this.newPostCategoryId =
      dept?.categoryId || this.categories.find((c) => c.name === post.category)?.id || '';
    this.newPostExperienceYears = post.experienceYears ?? null;
    this.newPostWorkMode = post.workMode || 'physical';
    this.newPostAddress = post.address || '';
    this.newPostDescription = post.description || '';
  }
}

class PostDescriptionImageUploadAdapter {
  constructor(
    private loader: { file: Promise<File> },
    private http: HttpClient,
    private toastrService: ToastrService
  ) {}

  upload(): Promise<{ default: string }> {
    return this.loader.file.then((file) => {
      const formData = new FormData();
      formData.append('image', file);
      return firstValueFrom(
        this.http.post<{ url: string }>('proposal-management/post-description-images', formData)
      )
        .then((response) => ({
          default: response?.url || '',
        }))
        .catch(() => {
          this.toastrService.error('Failed to upload image');
          return Promise.reject();
        });
    });
  }

  abort(): void {
    // No-op: uploads are single-shot.
  }
}
