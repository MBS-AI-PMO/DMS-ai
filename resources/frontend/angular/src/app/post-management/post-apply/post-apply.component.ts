import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { ActivatedRoute } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { BaseComponent } from '../../base.component';

interface PublicPost {
  id: string;
  title: string;
  department?: string;
  experienceYears?: number;
  workMode?: string;
  address?: string;
  description?: string;
}

interface ExistingApplication {
  id: string;
  candidateName: string;
  candidateCode?: string;
  phone?: string;
  email?: string;
  experienceYears?: number;
  cvOriginalName?: string;
  hasCv: boolean;
  stage: string;
  createdDate: string;
}

interface CandidateProfile {
  candidateName: string;
  candidateCode?: string;
  phone?: string;
  email?: string;
  experienceYears?: number;
  cvOriginalName?: string;
  hasCv?: boolean;
}

interface LookupResponse {
  appliedOnThisPost: boolean;
  application?: ExistingApplication;
  profile?: CandidateProfile | null;
}

@Component({
  selector: 'app-post-apply',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    MatButtonModule,
    MatCardModule,
    MatFormFieldModule,
    MatIconModule,
    MatInputModule,
  ],
  templateUrl: './post-apply.component.html',
  styleUrl: './post-apply.component.scss',
})
export class PostApplyComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly route = inject(ActivatedRoute);
  private readonly toastrService = inject(ToastrService);

  post: PublicPost | null = null;
  postId = '';
  candidateName = '';
  candidateCode = '';
  phone = '';
  email = '';
  experienceYears: number | null = null;
  cv: File | null = null;
  submitted = false;
  loading = false;
  loadError = '';
  cnicTouched = false;
  lookupLoading = false;
  alreadyApplied = false;
  existingCvName = '';
  existingHasCv = false;
  submittedAsUpdate = false;
  submittedKeptExistingCv = false;
  profileCvName = '';
  profileHasCv = false;

  ngOnInit(): void {
    this.postId = this.route.snapshot.paramMap.get('id') || '';
    this.loadPost();
  }

  loadPost(): void {
    if (!this.postId) {
      this.loadError = 'Invalid application link.';
      return;
    }

    this.loading = true;
    this.loadError = '';
    this.sub$.sink = this.httpClient
      .get<PublicPost>(`proposal-management/posts/${this.postId}/apply`)
      .subscribe({
        next: (post) => {
          this.post = post;
          this.loading = false;
        },
        error: (err: { error?: { message?: string } }) => {
          this.loading = false;
          this.loadError =
            err?.error?.message || 'This job post is not available or the link has expired.';
        },
      });
  }

  onCvSelected(file: File | null): void {
    this.cv = file;
  }

  onCnicInput(): void {
    const digits = this.candidateCode.replace(/\D/g, '').slice(0, 13);
    if (digits.length <= 5) {
      this.candidateCode = digits;
      return;
    }
    if (digits.length <= 12) {
      this.candidateCode = `${digits.slice(0, 5)}-${digits.slice(5)}`;
      return;
    }
    this.candidateCode = `${digits.slice(0, 5)}-${digits.slice(5, 12)}-${digits.slice(12)}`;
  }

  onCnicBlur(): void {
    this.cnicTouched = true;
    this.onCnicInput();
    this.lookupCandidate();
  }

  onEmailBlur(): void {
    if (this.email.trim()) {
      this.lookupCandidate();
    }
  }

  lookupCandidate(): void {
    if (!this.postId || !this.isCnicValid()) {
      return;
    }

    const params: Record<string, string> = {
      candidateCode: this.candidateCode.trim(),
    };
    if (this.email.trim()) {
      params['email'] = this.email.trim();
    }

    this.lookupLoading = true;
    this.sub$.sink = this.httpClient
      .get<LookupResponse>(`proposal-management/posts/${this.postId}/apply/lookup`, { params })
      .subscribe({
        next: (response) => {
          this.lookupLoading = false;
          if (response.appliedOnThisPost && response.application) {
            this.applyExistingApplication(response.application);
            return;
          }

          this.alreadyApplied = false;
          this.existingCvName = '';
          this.existingHasCv = false;
          this.profileCvName = '';
          this.profileHasCv = false;

          if (response.profile) {
            this.prefillFromProfile(response.profile);
          }
        },
        error: () => {
          this.lookupLoading = false;
        },
      });
  }

  private applyExistingApplication(application: ExistingApplication): void {
    this.alreadyApplied = true;
    this.candidateName = application.candidateName || '';
    this.candidateCode = application.candidateCode || this.candidateCode;
    this.phone = application.phone || '';
    this.email = application.email || '';
    this.experienceYears = application.experienceYears ?? null;
    this.existingCvName = application.cvOriginalName || '';
    this.existingHasCv = application.hasCv;
    this.profileCvName = '';
    this.profileHasCv = false;
    this.cv = null;
  }

  private prefillFromProfile(profile: CandidateProfile): void {
    if (!this.candidateName.trim()) {
      this.candidateName = profile.candidateName || '';
    }
    if (!this.phone.trim()) {
      this.phone = profile.phone || '';
    }
    if (!this.email.trim()) {
      this.email = profile.email || '';
    }
    if (this.experienceYears === null || this.experienceYears === undefined) {
      this.experienceYears = profile.experienceYears ?? null;
    }
    this.profileCvName = profile.cvOriginalName || '';
    this.profileHasCv = !!profile.hasCv;
  }

  viewExistingCv(): void {
    if (!this.postId || !this.isCnicValid() || !this.existingHasCv) {
      return;
    }

    this.sub$.sink = this.httpClient
      .get(`proposal-management/posts/${this.postId}/apply/cv`, {
        params: { candidateCode: this.candidateCode.trim() },
        responseType: 'blob',
      })
      .subscribe({
        next: (blob) => {
          const url = URL.createObjectURL(blob);
          window.open(url, '_blank');
        },
        error: () => {
          this.toastrService.error('Could not open your CV');
        },
      });
  }

  getCnicDigits(): string {
    return this.candidateCode.replace(/\D/g, '');
  }

  isCnicValid(): boolean {
    return this.getCnicDigits().length === 13;
  }

  get cnicErrorMessage(): string {
    if (!this.cnicTouched && !this.candidateCode.trim()) {
      return '';
    }
    if (!this.candidateCode.trim()) {
      return 'CNIC is required';
    }
    if (!this.isCnicValid()) {
      return 'Enter a valid 13-digit CNIC (e.g. 35201-1234567-1)';
    }
    return '';
  }

  get submitButtonLabel(): string {
    if (!this.alreadyApplied) {
      return 'Submit Application';
    }
    return this.cv ? 'Update CV' : 'Continue with existing CV';
  }

  submitApplication(): void {
    this.cnicTouched = true;
    this.onCnicInput();

    if (!this.isCnicValid()) {
      this.toastrService.error('Please enter a valid 13-digit CNIC');
      return;
    }

    if (this.isApplicationInvalid()) {
      return;
    }

    const formData = new FormData();
    formData.append('candidateName', this.candidateName.trim());
    formData.append('candidateCode', this.candidateCode.trim());
    formData.append('phone', this.phone.trim());
    formData.append('email', this.email.trim());
    formData.append('experienceYears', String(this.experienceYears));

    if (this.alreadyApplied) {
      formData.append('updateCvOnly', '1');
    }

    if (this.cv) {
      formData.append('cv', this.cv);
    }

    const keptExistingCv = this.alreadyApplied && !this.cv;

    this.sub$.sink = this.httpClient
      .post(`proposal-management/posts/${this.postId}/apply`, formData)
      .subscribe({
        next: () => {
          this.submitted = true;
          this.submittedAsUpdate = this.alreadyApplied && !!this.cv;
          this.submittedKeptExistingCv = keptExistingCv;
          if (this.submittedAsUpdate) {
            this.toastrService.success('CV updated successfully');
          } else if (keptExistingCv) {
            this.toastrService.success('Your existing application is confirmed');
          } else {
            this.toastrService.success('Application submitted successfully');
          }
        },
        error: (err: { error?: { errors?: Record<string, string[]>; message?: string } }) => {
          const cnicErrors = err?.error?.errors?.['candidateCode'];
          if (cnicErrors?.length) {
            this.toastrService.error(cnicErrors[0]);
            return;
          }
          this.toastrService.error(err?.error?.message || 'Could not submit application');
        },
      });
  }

  isApplicationInvalid(): boolean {
    const baseInvalid =
      !this.postId
      || !this.candidateName.trim()
      || !this.isCnicValid()
      || !this.phone.trim()
      || !this.email.trim()
      || this.experienceYears === null
      || this.experienceYears === undefined
      || this.experienceYears < 0;

    if (this.alreadyApplied) {
      return baseInvalid;
    }

    return baseInvalid || !this.cv;
  }
}
