import { SecurityService } from './security.service';
import { LicenseInitializerService } from '@mlglobtech/license-validator-docphp';
import { ToastrService } from 'ngx-toastr';

export function initializeApp(licenseService: LicenseInitializerService, toastrService: ToastrService, securityService: SecurityService): () => Promise<void> {
  return () => new Promise<void>((resolve, reject) => {
    return licenseService.initialize().then((result) => {
      if (result == "success") {
        return resolve();
      }
      if (result == "tokenremoved") {
        securityService.resetSecurityObject();
        return resolve();
      }
      else if (result == "tokenadded") {
        securityService.resetSecurityObject();
        return resolve();
      }
      else if (result == "notupdated" || result == "error") {
        return resolve();
      }
      else if (result == "error_msg") {
        return resolve();
      }
      return resolve();
    }).catch((error) => {
      console.error("License initialization failed", error);
      return resolve();
    }
    );
  });
}

