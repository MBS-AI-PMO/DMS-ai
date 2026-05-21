import { LicenseValidatorService } from '@mlglobtech/license-validator-docphp';
import { JwtHelperService } from '@auth0/angular-jwt';
import { Router } from '@angular/router';

/** Patches license validator so domain/purchase checks and the red banner are disabled. */
export function createLicenseValidatorBypass(
  document: Document,
  router: Router,
  jwtHelper: JwtHelperService
): LicenseValidatorService {
  const service = new LicenseValidatorService(document, router, jwtHelper);

  service.validateToken = () => true;
  service.verifyLicense = () => true;
  service.activateLicense = () => true;
  service.showBanner = () => {};

  service.setTokenUserValue = function (securityObject: {
    authorisation?: { token?: string };
    user?: unknown;
  }): void {
    if (securityObject?.authorisation?.token) {
      localStorage.setItem(this.keyValues.bearerToken, securityObject.authorisation.token);
    }
    if (securityObject?.user) {
      localStorage.setItem(this.keyValues.authObj, JSON.stringify(securityObject.user));
    }
  };

  service.setTokenValue = function (securityObject: {
    bearerToken?: string;
    user?: unknown;
  }): void {
    if (securityObject?.bearerToken) {
      localStorage.setItem(this.keyValues.bearerToken, securityObject.bearerToken);
    }
    if (securityObject?.user) {
      localStorage.setItem(this.keyValues.authObj, JSON.stringify(securityObject.user));
    }
  };

  service.onActivateLicense = () => {};
  service.onDeactiveLicense = () => {};

  return service;
}

export function removeLicenseBanner(document: Document): void {
  const links = document.querySelectorAll('a[href*="activate-license"]');
  links.forEach((link) => {
    const banner = link.closest('div');
    if (banner?.parentElement) {
      banner.parentElement.removeChild(banner);
    }
  });
}
