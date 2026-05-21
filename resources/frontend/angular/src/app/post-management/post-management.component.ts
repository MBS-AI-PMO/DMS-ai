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

interface ProposalPost {
  id: string;
  title: string;
  department?: string;
  category?: string;
  experienceYears?: number;
  basicQuestions?: string;
  intermediateQuestions?: string;
  expertQuestions?: string;
  workMode?: WorkMode;
  address?: string;
  description?: string;
  createdDate: string;
  candidates: ProposalCandidate[];
}

interface PostManagementData {
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
    MatTooltipModule,
  ],
  templateUrl: './post-management.component.html',
  styleUrl: './post-management.component.scss',
})
export class PostManagementComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly router = inject(Router);
  private readonly toastrService = inject(ToastrService);
  private readonly applyBaseUrl = `${window.location.protocol}//${window.location.host}/post-apply/`;

  posts: ProposalPost[] = [];
  showPostForm = false;
  editingPostId = '';
  newPostTitle = '';
  newPostDepartment = '';
  newPostCategory = '';
  newPostExperienceYears: number | null = null;
  newPostWorkMode: WorkMode = 'physical';
  newPostAddress = '';
  newPostDescription = '';
  newPostBasicQuestions = this.getDefaultQuestions('basic');
  newPostIntermediateQuestions = this.getDefaultQuestions('intermediate');
  newPostExpertQuestions = this.getDefaultQuestions('expert');

  ngOnInit(): void {
    this.loadData();
  }

  loadData(): void {
    this.sub$.sink = this.httpClient
      .get<PostManagementData>('proposal-management')
      .subscribe((response) => {
        this.posts = response.posts || [];
      });
  }

  createPost(): void {
    if (!this.newPostTitle.trim()) {
      return;
    }

    if (this.editingPostId) {
      this.sub$.sink = this.httpClient
        .put(`proposal-management/posts/${this.editingPostId}`, {
          title: this.newPostTitle.trim(),
          department: this.newPostDepartment.trim(),
          category: this.newPostCategory.trim(),
          experienceYears: this.newPostExperienceYears,
          basicQuestions: this.serializeQuestions(this.newPostBasicQuestions),
          intermediateQuestions: this.serializeQuestions(this.newPostIntermediateQuestions),
          expertQuestions: this.serializeQuestions(this.newPostExpertQuestions),
          workMode: this.newPostWorkMode,
          address: this.newPostWorkMode === 'physical' ? this.newPostAddress.trim() : '',
          description: this.newPostDescription.trim(),
        })
        .subscribe(() => {
          this.toastrService.success('Post updated successfully');
          this.resetPostForm();
          this.loadData();
        });
      return;
    }

    this.sub$.sink = this.httpClient
      .post<ProposalPost>('proposal-management/posts', {
        title: this.newPostTitle.trim(),
        department: this.newPostDepartment.trim(),
        category: this.newPostCategory.trim(),
        experienceYears: this.newPostExperienceYears,
        basicQuestions: this.serializeQuestions(this.newPostBasicQuestions),
        intermediateQuestions: this.serializeQuestions(this.newPostIntermediateQuestions),
        expertQuestions: this.serializeQuestions(this.newPostExpertQuestions),
        workMode: this.newPostWorkMode,
        address: this.newPostWorkMode === 'physical' ? this.newPostAddress.trim() : '',
        description: this.newPostDescription.trim(),
      })
      .subscribe((post) => {
        this.toastrService.success('Post created successfully');
        this.resetPostForm();
        this.loadData();
      });
  }

  editPost(post: ProposalPost): void {
    this.editingPostId = post.id;
    this.newPostTitle = post.title;
    this.newPostDepartment = post.department || '';
    this.newPostCategory = post.category || '';
    this.newPostExperienceYears = post.experienceYears ?? null;
    this.newPostBasicQuestions = this.parseQuestions(post.basicQuestions, 'basic');
    this.newPostIntermediateQuestions = this.parseQuestions(post.intermediateQuestions, 'intermediate');
    this.newPostExpertQuestions = this.parseQuestions(post.expertQuestions, 'expert');
    this.newPostWorkMode = post.workMode || 'physical';
    this.newPostAddress = post.address || '';
    this.newPostDescription = post.description || '';
    this.showPostForm = true;
  }

  deletePost(post: ProposalPost): void {
    if (!window.confirm(`Delete post "${post.title}"?`)) {
      return;
    }

    this.sub$.sink = this.httpClient
      .delete(`proposal-management/posts/${post.id}`)
      .subscribe(() => {
        this.toastrService.success('Post deleted successfully');
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

  addQuestion(level: QuestionLevel): void {
    this.getQuestions(level).push('');
  }

  removeQuestion(level: QuestionLevel, index: number): void {
    const questions = this.getQuestions(level);
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
    this.newPostDepartment = '';
    this.newPostCategory = '';
    this.newPostExperienceYears = null;
    this.newPostWorkMode = 'physical';
    this.newPostAddress = '';
    this.newPostDescription = '';
    this.newPostBasicQuestions = this.getDefaultQuestions('basic');
    this.newPostIntermediateQuestions = this.getDefaultQuestions('intermediate');
    this.newPostExpertQuestions = this.getDefaultQuestions('expert');
    this.showPostForm = false;
  }

  private getQuestions(level: QuestionLevel): string[] {
    if (level === 'basic') {
      return this.newPostBasicQuestions;
    }
    if (level === 'intermediate') {
      return this.newPostIntermediateQuestions;
    }
    return this.newPostExpertQuestions;
  }

  private getDefaultQuestions(level: QuestionLevel): string[] {
    const defaults: Record<QuestionLevel, string[]> = {
      basic: [
        'Tell us about yourself and your background.',
        'Why are you interested in this role?',
        'What basic tools or skills do you have for this job?',
        'Describe one task or project you completed.',
      ],
      intermediate: [
        'Explain a challenging project you handled.',
        'How do you prioritize multiple assigned tasks?',
        'Describe a problem you solved independently.',
        'How do you communicate blockers and progress?',
      ],
      expert: [
        'Describe a complex problem you owned end-to-end.',
        'How do you mentor or support junior team members?',
        'Explain a decision where you balanced speed, quality, and risk.',
        'How would you improve a workflow for this role?',
      ],
    };
    return [...defaults[level]];
  }

  private parseQuestions(value: string | undefined, level: QuestionLevel): string[] {
    const questions = (value || '')
      .split(/\r?\n/)
      .map((question) => question.trim())
      .filter((question) => question.length > 0);

    return questions.length ? questions : this.getDefaultQuestions(level);
  }

  private serializeQuestions(questions: string[]): string {
    return questions
      .map((question) => question.trim())
      .filter((question) => question.length > 0)
      .join('\n');
  }

  formatDisplayDate(value?: string | null): string {
    if (value == null || value === '' || value === 'null') {
      return '—';
    }
    const parsed = new Date(value);
    if (isNaN(parsed.getTime())) {
      return '—';
    }
    return parsed.toLocaleDateString(undefined, {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
    });
  }
}
