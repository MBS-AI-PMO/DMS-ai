import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatRadioModule } from '@angular/material/radio';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { BaseComponent } from '../../base.component';
import { PostDescriptionHtmlPipe } from '../post-description-html.pipe';
import { formatDisplayDate } from '../post-management.utils';

interface PublicPost {
  id: string;
  title: string;
  department?: string;
  category?: string;
  experienceYears?: number;
  workMode?: string;
  address?: string;
  description?: string;
}

type ApplyStep = 'details' | 'form';

interface VaultCv {
  id: string;
  cvOriginalName?: string;
  createdDate?: string;
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
  selectedCvId?: string;
  stage: string;
  createdDate: string;
}

interface CandidateProfile {
  candidateName: string;
  candidateCode?: string;
  phone?: string;
  email?: string;
  experienceYears?: number;
}

interface LookupResponse {
  appliedOnThisPost: boolean;
  portalAccountCreated?: boolean;
  portalCredentialsEmailed?: boolean;
  application?: ExistingApplication;
  profile?: CandidateProfile | null;
  cvs: VaultCv[];
  maxCvs: number;
  cvRetentionDays?: number;
}

type CvMode = 'existing' | 'new';

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
    MatRadioModule,
    RouterLink,
    PostDescriptionHtmlPipe,
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
  applyStep: ApplyStep = 'details';
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
  existingApplicationCvName = '';
  existingApplicationHasCv = false;
  submittedAsUpdate = false;
  submittedKeptExistingCv = false;
  portalAccountCreated = false;
  portalCredentialsEmailed = false;
  portalAccountRepaired = false;
  availableCvs: VaultCv[] = [];
  maxCvs = 5;
  cvRetentionDays = 365;
  selectedCvId = '';
  cvMode: CvMode = 'new';

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
    if (file) {
      this.cvMode = 'new';
      this.selectedCvId = '';
    }
  }

  onCvModeChange(mode: CvMode): void {
    this.cvMode = mode;
    if (mode === 'existing') {
      this.cv = null;
      if (!this.selectedCvId && this.availableCvs.length) {
        this.selectedCvId = this.availableCvs[0].id;
      }
    }
  }

  onCvChoiceChange(choice: string): void {
    if (choice === 'new') {
      this.onCvModeChange('new');
      return;
    }
    this.onSelectedCvChange(choice);
  }

  onSelectedCvChange(cvId: string): void {
    this.selectedCvId = cvId;
    this.cvMode = 'existing';
    this.cv = null;
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
          this.availableCvs = response.cvs || [];
          this.maxCvs = response.maxCvs || 5;
          this.cvRetentionDays = response.cvRetentionDays || 365;

          if (response.appliedOnThisPost && response.application) {
            this.portalAccountRepaired = !!response.portalAccountCreated;
            this.portalAccountCreated = !!response.portalAccountCreated;
            this.portalCredentialsEmailed = !!response.portalCredentialsEmailed;
            if (this.portalAccountRepaired) {
              this.toastrService.success(
                response.portalCredentialsEmailed
                  ? 'Portal account created. Check your email for login details.'
                  : 'Portal account created. You can log in with your email.'
              );
            }
            this.applyExistingApplication(response.application);
            return;
          }

          this.alreadyApplied = false;
          if (response.profile) {
            this.prefillFromProfile(response.profile);
          }
          this.setupCvSelection();
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
    this.existingApplicationCvName = application.cvOriginalName || '';
    this.existingApplicationHasCv = application.hasCv;
    this.cv = null;
    this.selectedCvId = '';
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
  }

  private setupCvSelection(preferredCvId = ''): void {
    if (this.availableCvs.length === 0) {
      this.cvMode = 'new';
      this.selectedCvId = '';
      return;
    }

    const matched = preferredCvId && this.availableCvs.some((cv) => cv.id === preferredCvId)
      ? preferredCvId
      : this.availableCvs[0].id;
    this.selectedCvId = matched;
    this.cvMode = 'existing';
    this.cv = null;
  }

  viewApplicationCv(): void {
    if (!this.postId || !this.isCnicValid()) {
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
          this.toastrService.error('Could not open CV');
        },
      });
  }

  viewVaultCv(cv: VaultCv): void {
    if (!this.postId || !this.isCnicValid()) {
      return;
    }

    this.sub$.sink = this.httpClient
      .get(`proposal-management/posts/${this.postId}/apply/cv-vault/${cv.id}`, {
        params: { candidateCode: this.candidateCode.trim() },
        responseType: 'blob',
      })
      .subscribe({
        next: (blob) => {
          const url = URL.createObjectURL(blob);
          window.open(url, '_blank');
        },
        error: () => {
          this.toastrService.error('Could not open CV');
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

  isApplicationInvalid(): boolean {
    if (this.alreadyApplied) {
      return true;
    }

    const baseInvalid =
      !this.postId
      || !this.candidateName.trim()
      || !this.isCnicValid()
      || !this.phone.trim()
      || !this.email.trim()
      || this.experienceYears === null
      || this.experienceYears === undefined
      || this.experienceYears < 0;

    if (this.cvMode === 'existing') {
      return baseInvalid || !this.selectedCvId;
    }

    return baseInvalid || !this.cv;
  }

  submitApplication(): void {
    if (this.alreadyApplied) {
      return;
    }

    this.cnicTouched = true;
    this.onCnicInput();

    if (!this.isCnicValid()) {
      this.toastrService.error('Please enter a valid 13-digit CNIC');
      return;
    }

    if (this.isApplicationInvalid()) {
      this.toastrService.error('Please select or upload a CV');
      return;
    }

    const formData = new FormData();
    formData.append('candidateName', this.candidateName.trim());
    formData.append('candidateCode', this.candidateCode.trim());
    formData.append('phone', this.phone.trim());
    formData.append('email', this.email.trim());
    formData.append('experienceYears', String(this.experienceYears));

    if (this.cvMode === 'existing' && this.selectedCvId) {
      formData.append('selectedCvId', this.selectedCvId);
    } else if (this.cv) {
      formData.append('cv', this.cv);
    }

    this.sub$.sink = this.httpClient
      .post<{
        portalAccountCreated?: boolean;
        portalCredentialsEmailed?: boolean;
        applicationRepaired?: boolean;
      }>(`proposal-management/posts/${this.postId}/apply`, formData)
      .subscribe({
        next: (response) => {
          this.submitted = true;
          this.submittedAsUpdate = false;
          this.submittedKeptExistingCv = false;
          this.portalAccountCreated = !!response?.portalAccountCreated;
          this.portalCredentialsEmailed = !!response?.portalCredentialsEmailed;
          this.portalAccountRepaired = !!response?.applicationRepaired;
          this.toastrService.success(
            response?.applicationRepaired
              ? 'Portal account created for your existing application.'
              : 'Application submitted successfully'
          );
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

  formatDisplayDate = formatDisplayDate;

  goToApplicationForm(): void {
    this.applyStep = 'form';
  }

  backToJobDetails(): void {
    this.applyStep = 'details';
  }
}
