import { Injectable } from '@angular/core';
import {
  Router,
  ActivatedRouteSnapshot,
  RouterStateSnapshot,
  Resolve,
} from '@angular/router';
import { CompanyProfile } from '@core/domain-classes/company-profile';
import { Observable, of } from 'rxjs';
import { catchError, mergeMap, take } from 'rxjs/operators';
import { CompanyProfileService } from './company-profile.service';
import { environment } from '@environments/environment';
import { SecurityService } from '@core/security/security.service';

@Injectable({
  providedIn: 'root',
})
export class CompanyProfileResolver implements Resolve<CompanyProfile> {
  constructor(
    private companyProfileService: CompanyProfileService,
    private router: Router,
    private securityService: SecurityService
  ) { }
  resolve(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<CompanyProfile> {
    const isPublicApply = state.url.includes('/post-apply');

    return this.companyProfileService.getCompanyProfile().pipe(
      take(1),
      mergeMap((companyProfile: CompanyProfile) => {
        if (companyProfile) {
          if (companyProfile.logoUrl) {
            companyProfile.logoUrl = `${environment.apiUrl}${companyProfile.logoUrl}`;
          }
          if (companyProfile.bannerUrl) {
            companyProfile.bannerUrl = `${environment.apiUrl}${companyProfile.bannerUrl}`;
          }
          if (companyProfile.smallLogoUrl) {
            companyProfile.smallLogoUrl = `${environment.apiUrl}${companyProfile.smallLogoUrl}`;
          }
          this.securityService.updateProfile(companyProfile);
          if (companyProfile.languages) {
            companyProfile.languages.forEach((lan) => {
              lan.imageUrl = `${environment.apiUrl}${lan.imageUrl}`;
            });
          }
          return of(companyProfile);
        }

        if (!isPublicApply) {
          this.router.navigate(['/dashboard']);
        }
        return of(this.fallbackProfile());
      }),
      catchError(() => of(this.fallbackProfile()))
    );
  }

  private fallbackProfile(): CompanyProfile {
    return {
      title: 'Document Management',
      location: 'local',
      isS3Supported: false,
      allowPdfSignature: true,
      languages: [],
    };
  }
}
