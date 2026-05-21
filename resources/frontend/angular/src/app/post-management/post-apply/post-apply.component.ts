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
import { ActivatedRoute } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { BaseComponent } from '../../base.component';

type WorkMode = 'remote' | 'physical';

interface PublicPost {
  id: string;
  title: string;
  department?: string;
  experienceYears?: number;
  workMode?: WorkMode;
  address?: string;
  description?: string;
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
    MatSelectModule,
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
  workMode: WorkMode = 'physical';
  address = '';
  cv: File | null = null;
  submitted = false;
  loading = false;
  cnicTouched = false;

  ngOnInit(): void {
    this.postId = this.route.snapshot.paramMap.get('id') || '';
    this.loadPost();
  }

  loadPost(): void {
    if (!this.postId) {
      return;
    }

    this.loading = true;
    this.sub$.sink = this.httpClient
      .get<PublicPost>(`proposal-management/posts/${this.postId}/apply`)
      .subscribe({
        next: (post) => {
          this.post = post;
          this.loading = false;
        },
        error: () => {
          this.loading = false;
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
    formData.append('workMode', this.workMode);
    formData.append('address', this.workMode === 'physical' ? this.address.trim() : '');
    formData.append('cv', this.cv as File);

    this.sub$.sink = this.httpClient
      .post(`proposal-management/posts/${this.postId}/apply`, formData)
      .subscribe({
        next: () => {
          this.submitted = true;
          this.toastrService.success('Application submitted successfully');
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
    return (
      !this.postId
      || !this.candidateName.trim()
      || !this.isCnicValid()
      || !this.phone.trim()
      || !this.email.trim()
      || this.experienceYears === null
      || this.experienceYears === undefined
      || this.experienceYears < 0
      || !this.workMode
      || (this.workMode === 'physical' && !this.address.trim())
      || !this.cv
    );
  }
}
