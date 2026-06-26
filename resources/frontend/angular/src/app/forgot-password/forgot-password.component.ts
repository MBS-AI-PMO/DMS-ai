import { Component, Inject, OnInit, Renderer2 } from '@angular/core';
import {
  UntypedFormBuilder,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { UserService } from '../user/user.service';
import { TranslationService } from '@core/services/translation.service';
import { SecurityService } from '@core/security/security.service';
import { CommonError } from '@core/error-handler/common-error';
import { BaseComponent } from '../base.component';
import { Router } from '@angular/router';
import { Direction } from '@angular/cdk/bidi';
import { DOCUMENT } from '@angular/common';

@Component({
  selector: 'app-forgot-password',
  templateUrl: './forgot-password.component.html',
  styleUrls: ['./forgot-password.component.scss'],
})
export class ForgotPasswordComponent extends BaseComponent implements OnInit {
  loginFormGroup: UntypedFormGroup;
  logoImage = '';
  direction: Direction;
  isSubmitting = false;

  constructor(
    private fb: UntypedFormBuilder,
    private translationService: TranslationService,
    private userService: UserService,
    private securityService: SecurityService,
    private toastr: ToastrService,
    private router: Router,
    private renderer: Renderer2,
    @Inject(DOCUMENT) private document: Document
  ) {
    super();
    this.companyProfileSubscription();
    this.getLangDir();
  }

  ngOnInit(): void {
    this.createFormGroup();
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

  createFormGroup(): void {
    this.loginFormGroup = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
    });
  }

  onLoginSubmit() {
    if (this.loginFormGroup.valid) {
      this.isSubmitting = true;
      const url = `${window.location.protocol}//${window.location.host}`;
      const userObject = Object.assign(this.loginFormGroup.value);
      userObject.userName = userObject.email;
      userObject.hostUrl = url;
      this.userService.sendResetPasswordLink(userObject).subscribe({
        next: () => {
          this.isSubmitting = false;
          this.toastr.success(
            this.translationService.getValue('RESET_PASSWORD_LINK_SENT_TO_YOUR_EMAIL')
          );
          this.router.navigate(['/login']);
        },
        error: (err: CommonError) => {
          this.isSubmitting = false;
          const body = (err?.error ?? {}) as { Message?: string; message?: string; error?: string };
          const msg = body.Message || body.message || body.error || 'Unable to send reset email.';
          this.toastr.error(msg);
        },
      });
    } else {
      this.loginFormGroup.markAllAsTouched();
    }
  }

  companyProfileSubscription() {
    this.securityService.companyProfile.subscribe((profile) => {
      if (profile) {
        this.logoImage = profile.logoUrl;
      }
    });
  }
}
