import { Injectable } from '@angular/core';
import {
  ActivatedRouteSnapshot,
  RouterStateSnapshot,
  Resolve,
} from '@angular/router';
import { OpenAiApi } from '@core/domain-classes/company-profile';
import { Observable } from 'rxjs';
import { take, map } from 'rxjs/operators';
import { CompanyProfileService } from './company-profile.service';

@Injectable({
  providedIn: 'root',
})
export class OpenAiKeyResolver implements Resolve<OpenAiApi> {
  constructor(private companyProfileService: CompanyProfileService) {}
  resolve(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<OpenAiApi> {
    return this.companyProfileService.getOpenAiApiKey().pipe(
      take(1),
      map((openAiApiKey: OpenAiApi) => openAiApiKey ?? { openApiKey: '' })
    );
  }
}
