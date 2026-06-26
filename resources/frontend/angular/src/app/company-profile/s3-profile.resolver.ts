import { Injectable } from '@angular/core';
import {
  ActivatedRouteSnapshot,
  RouterStateSnapshot,
  Resolve,
} from '@angular/router';
import { S3Config } from '@core/domain-classes/company-profile';
import { Observable } from 'rxjs';
import { take, map } from 'rxjs/operators';
import { CompanyProfileService } from './company-profile.service';

const defaultS3Config: S3Config = {
  location: 'local',
  amazonS3key: '',
  amazonS3secret: '',
  amazonS3region: '',
  amazonS3bucket: '',
};

@Injectable({
  providedIn: 'root',
})
export class S3Resolver implements Resolve<S3Config> {
  constructor(private companyProfileService: CompanyProfileService) {}
  resolve(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<S3Config> {
    return this.companyProfileService.getS3Config().pipe(
      take(1),
      map((s3Profile: S3Config) => {
        if (s3Profile && !Array.isArray(s3Profile) && s3Profile.location) {
          return s3Profile;
        }

        return defaultS3Config;
      })
    );
  }
}
