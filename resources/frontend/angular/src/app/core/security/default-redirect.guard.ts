import { Injectable } from '@angular/core';
import { CanActivate, Router } from '@angular/router';
import { SecurityService } from './security.service';

@Injectable({ providedIn: 'root' })
export class DefaultRedirectGuard implements CanActivate {
  constructor(
    private readonly router: Router,
    private readonly securityService: SecurityService
  ) {}

  canActivate(): boolean {
    if (this.securityService.hasClaim('candidate_portal_view')) {
      void this.router.navigate(['/candidate-portal/dashboard']);
    } else if (this.securityService.hasClaim('dashboard_view_dashboard')) {
      void this.router.navigate(['/dashboard']);
    } else {
      void this.router.navigate(['/assigned-documents']);
    }
    return false;
  }
}
