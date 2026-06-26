import { Component, OnInit } from '@angular/core';
import {
  FormGroup,
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';
import { Router } from '@angular/router';
import { CompanyProfile, GoogleGeminiApi, OpenAiApi, S3Config } from '@core/domain-classes/company-profile';
import { SecurityService } from '@core/security/security.service';
import { TranslationService } from '@core/services/translation.service';
import { environment } from '@environments/environment';
import { ToastrService } from 'ngx-toastr';
import { forkJoin, of } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { BaseComponent } from '../base.component';
import { CompanyProfileService } from './company-profile.service';
import { CommonDialogService } from '@core/common-dialog/common-dialog.service';

@Component({
  selector: 'app-company-profile',
  templateUrl: './company-profile.component.html',
  styleUrls: ['./company-profile.component.css'],
})
export class CompanyProfileComponent extends BaseComponent implements OnInit {
  companyProfileForm: UntypedFormGroup;
  localStorageForm: UntypedFormGroup;
  openAiApiKeyForm: UntypedFormGroup;
  googleGeminiApiKeyForm: UntypedFormGroup;
  imgSrc: string | ArrayBuffer = '';
  smallLogoSrc: string | ArrayBuffer = '';
  bannerSrc: string | ArrayBuffer = '';
  canManageProfile = false;
  canManageStorage = false;
  canManageOpenAiKey = false;
  canManageGeminiKey = false;
  canChangePdfSettings = false;
  activeTab: 'general' | 'storage' | 'openai' | 'gemini' | 'pdf' = 'general';
  private oldS3Profile: S3Config;
  private oldCompanyProfile: CompanyProfile;
  pdfSignatureForm: FormGroup = this.fb.group({
    allowPdfSignature: [true],
  });
  constructor(
    private fb: UntypedFormBuilder,
    private companyProfileService: CompanyProfileService,
    private router: Router,
    private toastrService: ToastrService,
    private securityService: SecurityService,
    public translationService: TranslationService,
    private commonDialogService: CommonDialogService
  ) {
    super();
  }

  ngOnInit(): void {
    this.canManageProfile = this.securityService.hasClaim('SETTING_MANAGE_PROFILE');
    this.canManageStorage = this.securityService.hasClaim('SETTINGS_STORAGE_SETTINGS');
    this.canManageOpenAiKey = this.securityService.hasClaim('SETTINGS_MANAGE_OPEN_AI_API_KEY');
    this.canManageGeminiKey = this.securityService.hasClaim('SETTINGS_MANAGE_GEMINI_API_KEY');
    this.canChangePdfSettings = this.securityService.hasClaim('SETTINGS_CHANGE_PDF_SETTINGS');
    this.activeTab = this.getDefaultTab();

    this.createform();
    this.createLocalStorageform();
    this.createOpenAiApiKeyform();
    this.createGoogleGeminiApiKeyform();
    this.loadPageData();
  }

  private loadPageData(): void {
    const profile = this.securityService.getCompanyProfileSnapshot();
    if (profile) {
      this.patchCompanyProfile(profile);
    }

    this.sub$.sink = forkJoin({
      s3Profile: this.companyProfileService.getS3Config().pipe(
        catchError(() => of({
          location: profile?.location ?? 'local',
          amazonS3key: '',
          amazonS3secret: '',
          amazonS3region: '',
          amazonS3bucket: '',
        } as S3Config))
      ),
      openAikey: this.companyProfileService.getOpenAiApiKey().pipe(
        catchError(() => of({ openApiKey: '' } as OpenAiApi))
      ),
      googleGeminiApiKey: this.companyProfileService.getGoogleGeminiApiKey().pipe(
        catchError(() => of({ googleGeminiApiKey: '' } as GoogleGeminiApi))
      ),
    }).subscribe(({ s3Profile, openAikey, googleGeminiApiKey }) => {
      const storageConfig = this.asS3Config(s3Profile, profile?.location);
      this.oldS3Profile = storageConfig;
      this.localStorageForm.patchValue(storageConfig);
      if (profile?.location) {
        this.localStorageForm.patchValue(
          { location: profile.location },
          { emitEvent: false }
        );
      }
      this.openAiApiKeyForm.patchValue(openAikey);
      this.googleGeminiApiKeyForm.patchValue(googleGeminiApiKey);
      this.pdfSignatureForm.patchValue({
        allowPdfSignature: profile?.allowPdfSignature ?? true,
      });
    });
  }

  private patchCompanyProfile(profile: CompanyProfile) {
    this.oldCompanyProfile = profile;
    this.companyProfileForm.patchValue(profile);

    if (profile.logoUrl) {
      this.imgSrc = profile.logoUrl;
    }

    if (profile.bannerUrl) {
      this.bannerSrc = profile.bannerUrl;
    }

    if (profile.smallLogoUrl) {
      this.smallLogoSrc = profile.smallLogoUrl;
    }
  }

  private asS3Config(value: unknown, fallbackLocation = 'local'): S3Config {
    if (value && typeof value === 'object' && 'location' in value) {
      return value as S3Config;
    }

    return {
      location: fallbackLocation,
      amazonS3key: '',
      amazonS3secret: '',
      amazonS3region: '',
      amazonS3bucket: '',
    };
  }

  removeRequired() {
    this.localStorageForm.get('amazonS3key').clearValidators();
    this.localStorageForm.get('amazonS3secret').clearValidators();
    this.localStorageForm.get('amazonS3region').clearValidators();
    this.localStorageForm.get('amazonS3bucket').clearValidators();

    this.localStorageForm.get('amazonS3key').updateValueAndValidity();
    this.localStorageForm.get('amazonS3secret').updateValueAndValidity();
    this.localStorageForm.get('amazonS3region').updateValueAndValidity();
    this.localStorageForm.get('amazonS3bucket').updateValueAndValidity();
  }

  setActiveTab(tab: 'general' | 'storage' | 'openai' | 'gemini' | 'pdf'): void {
    this.activeTab = tab;
  }

  private getDefaultTab(): 'general' | 'storage' | 'openai' | 'gemini' | 'pdf' {
    if (this.canManageProfile) {
      return 'general';
    }
    if (this.canManageStorage) {
      return 'storage';
    }
    if (this.canManageOpenAiKey) {
      return 'openai';
    }
    if (this.canManageGeminiKey) {
      return 'gemini';
    }
    if (this.canChangePdfSettings) {
      return 'pdf';
    }
    return 'general';
  }

  createform() {
    this.companyProfileForm = this.fb.group({
      id: [''],
      title: ['', [Validators.required]],
      logoUrl: [''],
      imageData: [],
      bannerUrl: [''],
      bannerData: [''],
      smallLogoData: [''],
    });
  }

  createLocalStorageform() {
    this.localStorageForm = this.fb.group({
      id: [''],
      amazonS3key: ['', [Validators.required]],
      amazonS3secret: ['', [Validators.required]],
      amazonS3region: ['', [Validators.required]],
      amazonS3bucket: ['', [Validators.required]],
      location: ['local'],
    });

    this.localStorageForm.get('location').valueChanges.subscribe((value) => {
      if (value === 'local') {
        this.removeRequired();
      } else {
        this.localStorageForm
          .get('amazonS3key')
          .setValidators([Validators.required]);
        this.localStorageForm
          .get('amazonS3secret')
          .setValidators([Validators.required]);
        this.localStorageForm
          .get('amazonS3region')
          .setValidators([Validators.required]);
        this.localStorageForm
          .get('amazonS3bucket')
          .setValidators([Validators.required]);

        this.localStorageForm.get('amazonS3key').updateValueAndValidity();
        this.localStorageForm.get('amazonS3secret').updateValueAndValidity();
        this.localStorageForm.get('amazonS3region').updateValueAndValidity();
        this.localStorageForm.get('amazonS3bucket').updateValueAndValidity();
      }
    });
  }

  createOpenAiApiKeyform() {
    this.openAiApiKeyForm = this.fb.group({
      id: [''],
      openApiKey: [''],
    });
  }

  createGoogleGeminiApiKeyform() {
    this.googleGeminiApiKeyForm = this.fb.group({
      googleGeminiApiKey: [''],
    });
  }


  saveCompanyProfile() {
    if (this.companyProfileForm.invalid) {
      this.companyProfileForm.markAllAsTouched();
      return;
    }
    const companyProfile: CompanyProfile =
      this.companyProfileForm.getRawValue();
    this.companyProfileService.updateCompanyProfile(companyProfile).subscribe({
      next: (savedProfile: CompanyProfile) => {
        const assetPath = (path?: string) =>
          path ? `${environment.apiUrl}${path.replace(/\\/g, '/')}` : path;
        if (savedProfile.languages) {
          savedProfile.languages.forEach((lan) => {
            lan.imageUrl = assetPath(lan.imageUrl);
          });
        }
        savedProfile.logoUrl = assetPath(savedProfile.logoUrl);
        savedProfile.bannerUrl = assetPath(savedProfile.bannerUrl);
        savedProfile.smallLogoUrl = assetPath(savedProfile.smallLogoUrl);
        this.securityService.updateProfile(savedProfile);
        this.toastrService.success(
          this.translationService.getValue(
            'COMPANY_PROFILE_UPDATED_SUCCESSFULLY'
          )
        );
        this.router.navigate(['dashboard']);
      },
      error: () => {
        this.toastrService.error('Error while saving company profile.');
      },
    });
  }

  saveLocalStorage() {
    if (this.localStorageForm.invalid) {
      this.localStorageForm.markAllAsTouched();
      return;
    }
    const companyProfile: S3Config = this.localStorageForm.getRawValue();
    if (
      this.oldCompanyProfile.location === 's3' &&
      companyProfile.location === 's3' &&
      this.oldS3Profile !== companyProfile
    ) {
      this.commonDialogService
        .deleteConformationDialog(
          this.translationService.getValue('CHANGE_S3_SETTING_MESSAGE')
        )
        .subscribe((isTrue: boolean) => {
          if (isTrue) {
            this.updateStorage(companyProfile);
          }
        });
    } else {
      this.updateStorage(companyProfile);
    }
  }

  saveOpenAiApiKey() {
    const openAiApi: OpenAiApi = this.openAiApiKeyForm.getRawValue();

    this.companyProfileService.saveOpenAiKey(openAiApi).subscribe(
      () => {
        this.toastrService.success(
          this.translationService.getValue(
            'COMPANY_PROFILE_UPDATED_SUCCESSFULLY'
          )
        );
      });
  }

  saveGoogleGeminiApiKey() {
    const googleGeminiApiKey = this.googleGeminiApiKeyForm.getRawValue();

    this.companyProfileService.saveGoogleGeminiApiKey(googleGeminiApiKey).subscribe(
      () => {
        this.toastrService.success(
          this.translationService.getValue(
            'COMPANY_PROFILE_UPDATED_SUCCESSFULLY'
          )
        );
      });
  }

  savePdfSignatureSetting() {
    const allowPdfSignature: boolean = this.pdfSignatureForm.get('allowPdfSignature').value;
    this.companyProfileService.updatePdfSignatureSetting(allowPdfSignature).subscribe(
      () => {
        this.toastrService.success(
          this.translationService.getValue(
            'PDF_SIGNATURE_SETTING_UPDATED_SUCCESSFULLY'
          )
        );
        this.router.navigate(['dashboard']);
      });
  }

  updateStorage(companyProfile) {
    this.companyProfileService.updateLocalStorage(companyProfile).subscribe(
      () => {
        this.oldCompanyProfile.location = companyProfile.location;
        this.securityService.updateProfile(this.oldCompanyProfile);
        this.toastrService.success(
          this.translationService.getValue(
            'OPEN_AI_API_KEY_VALUE_SAVE_SUCCESSFULLY'
          )
        );
        this.router.navigate(['dashboard']);
      });
  }

  onFileSelect($event) {
    const fileSelected: File = $event.target.files[0];
    if (!fileSelected) {
      return;
    }
    const mimeType = fileSelected.type;
    if (mimeType.match(/image\/*/) == null) {
      return;
    }
    const reader = new FileReader();
    reader.readAsDataURL(fileSelected);
    reader.onload = (_event) => {
      this.imgSrc = reader.result;
      this.companyProfileForm.patchValue({
        imageData: reader.result.toString(),
        logoUrl: fileSelected.name,
      });
      $event.target.value = '';
    };
  }

  triggerLogoIconUpload(fileInput: HTMLInputElement) {
    fileInput.click();
  }

  onLogoIconUpload($event): void {
    const fileSelected: File = $event.target.files[0];
    if (!fileSelected) {
      return;
    }
    const mimeType = fileSelected.type;
    if (mimeType.match(/image\/*/) == null) {
      return;
    }
    const reader = new FileReader();
    reader.readAsDataURL(fileSelected);
    reader.onload = (_event) => {
      this.smallLogoSrc = reader.result;
      this.companyProfileForm.patchValue({
        smallLogoData: reader.result.toString()
      });
      $event.target.value = '';
    };
  }

  onBannerChange($event) {
    const fileSelected: File = $event.target.files[0];
    if (!fileSelected) {
      return;
    }
    const mimeType = fileSelected.type;
    if (mimeType.match(/image\/*/) == null) {
      return;
    }
    const reader = new FileReader();
    reader.readAsDataURL(fileSelected);
    reader.onload = (_event) => {
      this.bannerSrc = reader.result;
      this.companyProfileForm.patchValue({
        bannerData: reader.result.toString(),
        bannerUrl: fileSelected.name,
      });
      $event.target.value = '';
    };
  }
}
