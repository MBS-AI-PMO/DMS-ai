import { Component, Inject, OnInit, Renderer2 } from '@angular/core';
import {
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';
import { BaseComponent } from '../base.component';
import { Router } from '@angular/router';
import { UserAuth } from '@core/domain-classes/user-auth';
import { SecurityService } from '@core/security/security.service';
import { ToastrService } from 'ngx-toastr';
import { CommonError } from '@core/error-handler/common-error';
import { Direction } from '@angular/cdk/bidi';
import { TranslationService } from '@core/services/translation.service';
import { DOCUMENT } from '@angular/common';
import { MatDialog } from '@angular/material/dialog';
import { CommonService } from '@core/services/common.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss'],
})
export class LoginComponent extends BaseComponent implements OnInit {
  loginFormGroup: UntypedFormGroup;
  lat: number;
  lng: number;
  logoImage = '';
  bannerImage = '';
  direction: Direction;
  loginError = '';
  loginErrorField: 'email' | 'password' | null = null;
  isSubmitting = false;
  hidePassword = true;
  constructor(
    private fb: UntypedFormBuilder,
    private router: Router,
    private securityService: SecurityService,
    private toastr: ToastrService,
    private translationService: TranslationService,
    private commonService: CommonService,
    private renderer: Renderer2,
    @Inject(DOCUMENT) private document: Document,
    private matDialogRef: MatDialog
  ) {
    super();
    this.companyProfileSubscription();
    this.getLangDir();
  }

  ngOnInit(): void {
    this.matDialogRef.closeAll();
    this.createFormGroup();
    navigator.geolocation.getCurrentPosition((position) => {
      this.lat = position.coords.latitude;
      this.lng = position.coords.longitude;
    });
  }

  getLangDir() {
    this.sub$.sink = this.translationService.lanDir$.subscribe(
      (c: Direction) => {
        this.direction = c;
        if (this.direction == 'rtl') {
          this.renderer.addClass(this.document.body, 'rtl');
        } else {
          this.renderer.removeClass(this.document.body, 'rtl');
        }
      }
    );
  }

  companyProfileSubscription() {
    this.securityService.companyProfile.subscribe((profile) => {
      if (profile) {
        this.logoImage = profile.logoUrl;
        this.bannerImage = profile.bannerUrl;
      }
    });
  }

  onLoginSubmit() {
    this.clearLoginError();

    if (this.loginFormGroup.valid) {
      this.isSubmitting = true;
      const userObject = {
        email: this.loginFormGroup.get('userName').value,
        password: this.loginFormGroup.get('password').value,
      };
      this.sub$.sink = this.securityService.login(userObject).subscribe({
        next: (c: UserAuth) => {
          this.isSubmitting = false;
          if (c.isAuthenticated) {
            this.getAllAllowFileExtension();
            this.toastr.success(this.translationService.getValue('USER_LOGIN_SUCCESSFULLY'));
            if (this.securityService.hasClaim('dashboard_view_dashboard')) {
              this.router.navigate(['/dashboard']);
            } else {
              this.router.navigate(['/']);
            }
          }
        },
        error: (err: CommonError) => {
          this.isSubmitting = false;
          const resolved = this.resolveLoginError(err);
          this.loginError = resolved.message;
          this.loginErrorField = resolved.field;
        },
      });
    } else {
      this.loginFormGroup.markAllAsTouched();
    }
  }

  clearLoginError(): void {
    this.loginError = '';
    this.loginErrorField = null;
  }

  private resolveLoginError(err: CommonError): { message: string; field: 'email' | 'password' | null } {
    const body = (err?.error ?? {}) as {
      message?: string;
      errorCode?: string;
      field?: string;
    };

    const translationKeys: Record<string, string> = {
      USER_NOT_FOUND: 'LOGIN_EMAIL_NOT_FOUND',
      WRONG_PASSWORD: 'LOGIN_PASSWORD_INCORRECT',
      EMPTY_EMAIL: 'EMAIL_IS_REQUIRED',
      EMPTY_PASSWORD: 'PASSWORD_IS_REQUIRED',
      EMPTY_CREDENTIALS: 'LOGIN_CREDENTIALS_REQUIRED',
      USER_DELETED: 'LOGIN_ACCOUNT_DISABLED',
      USER_IS_SYSTEM: 'LOGIN_SYSTEM_USER',
      PASSWORD_EMPTY_IN_DB: 'LOGIN_PASSWORD_NOT_SET',
      LOGIN_SERVER_ERROR: 'LOGIN_SERVER_ERROR',
      LOGIN_EXCEPTION: 'LOGIN_SERVER_ERROR',
      LOGIN_FAILED: 'LOGIN_FAILED',
    };

    const code = body.errorCode ?? '';
    if (code && translationKeys[code]) {
      return {
        message: this.translationService.getValue(translationKeys[code]),
        field: body.field === 'email' || body.field === 'password' ? body.field : null,
      };
    }

    if (body.message) {
      return {
        message: body.message,
        field: body.field === 'email' || body.field === 'password' ? body.field : null,
      };
    }

    return {
      message: this.translationService.getValue('LOGIN_FAILED'),
      field: null,
    };
  }

  createFormGroup(): void {
    this.loginFormGroup = this.fb.group({
      userName: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required]],
    });

    this.sub$.sink = this.loginFormGroup.valueChanges.subscribe(() => {
      if (this.loginError) {
        this.clearLoginError();
      }
    });
  }

  getAllAllowFileExtension() {
    this.commonService
      .getAllowFileExtensions()
      .subscribe();
  }

  togglePasswordVisibility(): void {
    this.hidePassword = !this.hidePassword;
  }
}
