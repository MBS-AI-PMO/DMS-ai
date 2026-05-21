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
import { MatTooltipModule } from '@angular/material/tooltip';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { BaseComponent } from '../base.component';
import { PostCandidateEmailDialogComponent } from './post-candidate-email-dialog.component';
import { PostCandidateRejectDialogComponent } from './post-candidate-reject-dialog.component';
import { PostCandidateScheduleDialogComponent } from './post-candidate-schedule-dialog.component';

type CandidateStage = 'cv_received' | 'shortlisted' | 'interview_scheduled' | 'approved' | 'rejected' | 'selected';
type InterviewLevel = 'basic' | 'intermediate' | 'advanced';
type WorkMode = 'remote' | 'physical';

interface CandidateHistory {
  postTitle: string;
  stage: CandidateStage;
  createdDate: string;
  interviewDate?: string;
  interviewer?: string | null;
}

interface ProposalCandidate {
  id: string;
  postId: string;
  candidateName: string;
  candidateCode?: string;
  phone?: string;
  email?: string;
  category?: string;
  experienceYears?: number;
  workMode?: WorkMode;
  address?: string;
  cvOriginalName?: string;
  hasCv: boolean;
  stage: CandidateStage;
  interviewLevel?: InterviewLevel;
  interviewDate?: string;
  interviewer?: string | null;
  interviewerUserId?: string | null;
  analysisNotes?: string;
  rejectionReason?: string | null;
  createdDate: string;
  history?: CandidateHistory[];
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
  selector: 'app-post-candidates',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    RouterModule,
    MatButtonModule,
    MatCardModule,
    MatDialogModule,
    MatFormFieldModule,
    MatIconModule,
    MatInputModule,
    MatTooltipModule,
  ],
  templateUrl: './post-candidates.component.html',
  styleUrl: './post-candidates.component.scss',
})
export class PostCandidatesComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly route = inject(ActivatedRoute);
  private readonly router = inject(Router);
  private readonly toastrService = inject(ToastrService);
  private readonly dialog = inject(MatDialog);
  private readonly applyBaseUrl = `${window.location.protocol}//${window.location.host}/post-apply/`;

  postId = '';
  post: ProposalPost | null = null;
  selectedCandidateId = '';
  readonly candidateStages: CandidateStage[] = [
    'cv_received',
    'shortlisted',
    'interview_scheduled',
    'approved',
    'rejected',
    'selected',
  ];
  readonly interviewLevels: InterviewLevel[] = ['basic', 'intermediate', 'advanced'];
  readonly interviewQuestions: Record<InterviewLevel, string[]> = {
    basic: [
      'Tell us about yourself and your education/background.',
      'Why are you interested in this role?',
      'What basic tools or technologies have you used related to this job?',
      'Describe a task or project you completed successfully.',
      'How do you handle feedback and learning new things?',
    ],
    intermediate: [
      'Explain a challenging project you worked on and your role in it.',
      'How do you prioritize work when multiple tasks are assigned?',
      'Describe a problem you solved independently.',
      'How do you communicate progress and blockers with your team?',
      'What improvements would you suggest for a process you have worked with?',
    ],
    advanced: [
      'Describe a complex problem you owned end-to-end and how you solved it.',
      'How do you mentor junior team members or support team growth?',
      'Explain a decision where you had to balance speed, quality, and risk.',
      'How do you design or improve a scalable workflow for this role?',
      'Tell us about a failure or difficult situation and what you changed afterward.',
    ],
  };

  ngOnInit(): void {
    this.postId = this.route.snapshot.paramMap.get('id') || '';
    this.loadData();
  }

  loadData(): void {
    this.sub$.sink = this.httpClient
      .get<PostManagementData>('proposal-management')
      .subscribe((response) => {
        this.post = (response.posts || []).find((post) => post.id === this.postId) || null;
        const candidates = this.post?.candidates || [];
        if (this.selectedCandidateId && !candidates.find((candidate) => candidate.id === this.selectedCandidateId)) {
          this.selectedCandidateId = '';
        }
      });
  }

  getApplyLink(post: ProposalPost): string {
    return `${this.applyBaseUrl}${post.id}`;
  }

  copyApplyLink(post: ProposalPost): void {
    navigator.clipboard.writeText(this.getApplyLink(post));
    this.toastrService.success('Apply link copied');
  }

  viewCandidate(candidate: ProposalCandidate): void {
    this.selectedCandidateId = candidate.id;
  }

  /** Uses Router (not routerLink) so navigation works with APP base href under `/assets/angular/browser/`. */
  navigateToHistory(candidate: ProposalCandidate): void {
    void this.router.navigate([
      '/post-management',
      this.postId,
      'candidates',
      candidate.id,
      'history',
    ]);
  }

  updateCandidate(
    candidate: ProposalCandidate,
    changes: Partial<ProposalCandidate> & { rejectionReason?: string | null },
  ): void {
    const stage = changes.stage ?? candidate.stage;
    const payload: Record<string, unknown> = {
      stage,
      interviewLevel: changes.interviewLevel ?? candidate.interviewLevel,
      interviewDate: this.toIsoInterviewDate(changes.interviewDate ?? candidate.interviewDate),
      analysisNotes: changes.analysisNotes ?? candidate.analysisNotes,
    };

    if (changes.interviewerUserId !== undefined) {
      payload['interviewerUserId'] = changes.interviewerUserId;
    }
    if (changes.rejectionReason !== undefined) {
      payload['rejectionReason'] = changes.rejectionReason;
    }
    this.sub$.sink = this.httpClient.put(`proposal-management/candidates/${candidate.id}`, payload).subscribe({
      next: () => {
        this.toastrService.success('Candidate updated successfully');
        this.loadData();
      },
      error: (err: { error?: { message?: string } }) => {
        const message = err?.error?.message || 'Update failed';
        this.toastrService.error(message);
      },
    });
  }

  openApproveScheduleDialog(candidate: ProposalCandidate, presetInterviewLevel?: InterviewLevel): void {
    const isReschedule = this.canRescheduleInterview(candidate);
    const ref = this.dialog.open(PostCandidateScheduleDialogComponent, {
      width: isReschedule ? '520px' : '480px',
      autoFocus: true,
      restoreFocus: true,
      data: {
        candidateName: candidate.candidateName,
        defaultInterviewLevel: this.getAutoInterviewLevel(candidate),
        presetInterviewLevel,
        existingInterviewDate: candidate.interviewDate,
        existingInterviewerUserId: candidate.interviewerUserId,
        isReschedule,
      },
    });

    this.sub$.sink = ref.afterClosed().subscribe((result) => {
      if (!result) {
        return;
      }

      this.updateCandidate(candidate, {
        stage: 'interview_scheduled',
        interviewLevel: result.interviewLevel,
        interviewDate: result.interviewIso,
        interviewerUserId: result.interviewerUserId,
        analysisNotes: candidate.analysisNotes,
      });
    });
  }

  canEmailCandidate(candidate: ProposalCandidate): boolean {
    return candidate.stage === 'interview_scheduled' && !!(candidate.email || '').trim();
  }

  openCandidateEmailDialog(candidate: ProposalCandidate): void {
    if (!this.canEmailCandidate(candidate)) {
      this.toastrService.warning('Candidate email is not available.');
      return;
    }

    const ref = this.dialog.open(PostCandidateEmailDialogComponent, {
      width: '480px',
      autoFocus: true,
      restoreFocus: true,
      data: {
        candidateName: candidate.candidateName,
        candidateEmail: candidate.email || '',
        interviewerName: candidate.interviewer,
        postTitle: this.post?.title || 'Job post',
      },
    });

    this.sub$.sink = ref.afterClosed().subscribe((result) => {
      if (!result) {
        return;
      }

      this.sub$.sink = this.httpClient
        .post(`proposal-management/candidates/${candidate.id}/email`, {
          message: result.message,
          subject: result.subject,
        })
        .subscribe({
          next: (res: { message?: string }) => {
            this.toastrService.success(res?.message || 'Email sent successfully');
          },
          error: (err: { error?: { message?: string } }) => {
            this.toastrService.error(err?.error?.message || 'Failed to send email');
          },
        });
    });
  }

  openRejectDialog(candidate: ProposalCandidate): void {
    const ref = this.dialog.open(PostCandidateRejectDialogComponent, {
      width: '440px',
      autoFocus: true,
      restoreFocus: true,
      data: { candidateName: candidate.candidateName },
    });

    this.sub$.sink = ref.afterClosed().subscribe((result) => {
      if (!result) {
        return;
      }

      this.updateCandidate(candidate, {
        stage: 'rejected',
        rejectionReason: result.reason,
        analysisNotes: candidate.analysisNotes,
      });
    });
  }

  private toIsoInterviewDate(value?: string | null): string | undefined {
    if (value === undefined || value === null || value === '') {
      return undefined;
    }
    const parsed = new Date(value);
    if (isNaN(parsed.getTime())) {
      return undefined;
    }
    return parsed.toISOString();
  }

  openCandidateCv(candidate: ProposalCandidate): void {
    if (!candidate.hasCv) {
      return;
    }

    this.sub$.sink = this.httpClient
      .get(`proposal-management/candidates/${candidate.id}/cv`, { responseType: 'blob' })
      .subscribe((blob) => {
        const fileUrl = window.URL.createObjectURL(blob);
        window.open(fileUrl, '_blank');
        setTimeout(() => window.URL.revokeObjectURL(fileUrl), 60_000);
      });
  }

  /** Approve / schedule only while CV is under review (not yet scheduled or decided). */
  canApproveCandidate(candidate: ProposalCandidate): boolean {
    return candidate.stage === 'cv_received' || candidate.stage === 'shortlisted';
  }

  canRejectCandidate(candidate: ProposalCandidate): boolean {
    return candidate.stage === 'cv_received' || candidate.stage === 'shortlisted';
  }

  canRescheduleInterview(candidate: ProposalCandidate): boolean {
    return candidate.stage === 'interview_scheduled';
  }

  getStageLabel(stage: CandidateStage): string {
    const stageLabels: Record<CandidateStage, string> = {
      cv_received: 'CV Received',
      shortlisted: 'Shortlisted',
      interview_scheduled: 'Interview Scheduled',
      approved: 'Approved',
      rejected: 'Rejected',
      selected: 'Selected',
    };
    return stageLabels[stage];
  }

  getStageBadgeClass(stage: CandidateStage): string {
    const badgeClasses: Record<CandidateStage, string> = {
      cv_received: 'bg-secondary',
      shortlisted: 'bg-info',
      interview_scheduled: 'bg-primary',
      approved: 'bg-warning text-dark',
      rejected: 'bg-danger',
      selected: 'bg-success',
    };
    return badgeClasses[stage];
  }

  getInterviewLevelLabel(level?: InterviewLevel): string {
    if (!level) {
      return 'Not selected';
    }

    const levelLabels: Record<InterviewLevel, string> = {
      basic: 'Beginner',
      intermediate: 'Intermediate',
      advanced: 'Advanced',
    };
    return levelLabels[level];
  }

  getAutoInterviewLevel(candidate: ProposalCandidate): InterviewLevel {
    const experienceYears = candidate.experienceYears ?? 0;

    if (experienceYears <= 1) {
      return 'basic';
    }
    if (experienceYears < 3) {
      return 'intermediate';
    }
    return 'advanced';
  }

  getCandidateInterviewLevel(candidate: ProposalCandidate): InterviewLevel {
    return candidate.interviewLevel || this.getAutoInterviewLevel(candidate);
  }

  getInterviewQuestions(candidate: ProposalCandidate): string[] {
    const level = this.getCandidateInterviewLevel(candidate);
    const postQuestions: Record<InterviewLevel, string | undefined> = {
      basic: this.post?.basicQuestions,
      intermediate: this.post?.intermediateQuestions,
      advanced: this.post?.expertQuestions,
    };
    const questions = this.parseQuestions(postQuestions[level]);
    return questions.length ? questions : this.interviewQuestions[level];
  }

  private parseQuestions(value?: string): string[] {
    return (value || '')
      .split(/\r?\n/)
      .map((question) => question.trim())
      .filter((question) => question.length > 0);
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

  formatDisplayDateTime(value?: string | null): string {
    if (value == null || value === '' || value === 'null') {
      return '—';
    }
    const parsed = new Date(value);
    if (isNaN(parsed.getTime())) {
      return '—';
    }
    return parsed.toLocaleString(undefined, {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
      hour: 'numeric',
      minute: '2-digit',
    });
  }

  get selectedCandidate(): ProposalCandidate | null {
    if (!this.post || !this.selectedCandidateId) {
      return null;
    }
    return this.post.candidates.find((candidate) => candidate.id === this.selectedCandidateId) || null;
  }
}
