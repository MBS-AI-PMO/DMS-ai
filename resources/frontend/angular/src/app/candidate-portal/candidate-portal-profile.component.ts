import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, inject } from '@angular/core';
import { FormBuilder, ReactiveFormsModule, Validators } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatInputModule } from '@angular/material/input';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatSelectModule } from '@angular/material/select';
import { MatTooltipModule } from '@angular/material/tooltip';
import { TranslateModule } from '@ngx-translate/core';
import { ToastrService } from 'ngx-toastr';
import { BaseComponent } from '../base.component';
import { CandidateProfile, CandidateVaultCv, CandidateVaultResponse } from './candidate-portal.types';
import { formatPortalDate } from './candidate-portal.utils';

@Component({
  selector: 'app-candidate-portal-profile',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    TranslateModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatButtonModule,
    MatIconModule,
    MatProgressSpinnerModule,
    MatTooltipModule,
  ],
  templateUrl: './candidate-portal-profile.component.html',
  styleUrl: './candidate-portal-profile.component.scss',
})
export class CandidatePortalProfileComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly fb = inject(FormBuilder);
  private readonly toastr = inject(ToastrService);

  loading = false;
  saving = false;
  cvLoading = false;
  cvUploading = false;
  applyingCvId = '';
  profile: CandidateProfile | null = null;
  cvs: CandidateVaultCv[] = [];
  maxCvs = 5;
  cvRetentionDays = 365;
  selectedCvFile: File | null = null;

  form = this.fb.group({
    candidateName: ['', [Validators.required, Validators.maxLength(255)]],
    email: ['', [Validators.required, Validators.email, Validators.maxLength(255)]],
    phone: [''],
    experienceYears: [0, [Validators.min(0), Validators.max(60)]],
    workMode: [''],
    address: [''],
    preferredCategory: [''],
  });

  ngOnInit(): void {
    this.load();
  }

  load(): void {
    this.loading = true;
    this.sub$.sink = this.httpClient.get<CandidateProfile>('candidate-portal/profile').subscribe({
      next: (profile) => {
        this.profile = profile;
        this.form.patchValue({
          candidateName: profile.candidateName || '',
          email: profile.email || '',
          phone: profile.phone || '',
          experienceYears: profile.experienceYears ?? 0,
          workMode: profile.workMode || '',
          address: profile.address || '',
          preferredCategory: profile.preferredCategory || '',
        });
        this.loading = false;
        this.loadCvs();
      },
      error: () => {
        this.loading = false;
      },
    });
  }

  loadCvs(): void {
    this.cvLoading = true;
    this.sub$.sink = this.httpClient.get<CandidateVaultResponse>('candidate-portal/cvs').subscribe({
      next: (response) => {
        this.cvs = response.items || [];
        this.maxCvs = response.maxCvs ?? 5;
        this.cvRetentionDays = response.cvRetentionDays ?? 365;
        this.cvLoading = false;
      },
      error: () => {
        this.cvLoading = false;
      },
    });
  }

  save(): void {
    if (this.form.invalid) {
      this.form.markAllAsTouched();
      return;
    }

    this.saving = true;
    const value = this.form.getRawValue();
    this.sub$.sink = this.httpClient
      .put<CandidateProfile>('candidate-portal/profile', {
        candidateName: value.candidateName,
        email: value.email,
        phone: value.phone,
        experienceYears: value.experienceYears,
        workMode: value.workMode || null,
        address: value.address,
        preferredCategory: value.preferredCategory,
      })
      .subscribe({
        next: (profile) => {
          this.profile = profile;
          this.saving = false;
          this.toastr.success('Profile updated');
        },
        error: (err) => {
          this.saving = false;
          this.toastr.error(err?.error?.message || 'Could not update profile');
        },
      });
  }

  onCvFileSelected(file: File | null): void {
    this.selectedCvFile = file;
  }

  uploadCv(): void {
    if (!this.selectedCvFile) {
      this.toastr.error('Please choose a CV file first');
      return;
    }

    const formData = new FormData();
    formData.append('cv', this.selectedCvFile);
    this.cvUploading = true;

    this.sub$.sink = this.httpClient
      .post<{ cvs?: CandidateVaultCv[] }>('candidate-portal/cvs', formData)
      .subscribe({
        next: (response) => {
          this.cvs = response.cvs || [];
          this.selectedCvFile = null;
          this.cvUploading = false;
          this.toastr.success('CV uploaded');
        },
        error: (err) => {
          this.cvUploading = false;
          this.toastr.error(err?.error?.message || 'Could not upload CV');
        },
      });
  }

  applyCvToApplications(cv: CandidateVaultCv): void {
    this.applyingCvId = cv.id;
    this.sub$.sink = this.httpClient
      .post<{ updatedApplications?: number }>('candidate-portal/cvs/apply', { cvId: cv.id })
      .subscribe({
        next: (response) => {
          this.applyingCvId = '';
          const count = response.updatedApplications ?? 0;
          this.toastr.success(
            count > 0
              ? `CV updated on ${count} application(s)`
              : 'CV saved. No open applications were updated.'
          );
        },
        error: (err) => {
          this.applyingCvId = '';
          this.toastr.error(err?.error?.message || 'Could not update applications');
        },
      });
  }

  downloadCv(cv: CandidateVaultCv): void {
    this.sub$.sink = this.httpClient
      .get(`candidate-portal/cvs/${cv.id}/download`, { responseType: 'blob' })
      .subscribe({
        next: (blob) => {
          const url = URL.createObjectURL(blob);
          const anchor = document.createElement('a');
          anchor.href = url;
          anchor.download = cv.cvOriginalName || 'cv.pdf';
          anchor.click();
          URL.revokeObjectURL(url);
        },
        error: () => {
          this.toastr.error('Could not download CV');
        },
      });
  }

  formatPortalDate = formatPortalDate;
}
