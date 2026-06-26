import { NgModule } from '@angular/core';
import { CompanyProfileComponent } from './company-profile.component';
import { RouterModule, Routes } from '@angular/router';
import { AuthGuard } from '@core/security/auth.guard';

const routes: Routes = [
  {
    path: '',
    component: CompanyProfileComponent,
    data: {
      claimType: [
        'SETTING_MANAGE_PROFILE',
        'SETTINGS_STORAGE_SETTINGS',
        'SETTINGS_MANAGE_OPEN_AI_API_KEY',
        'SETTINGS_MANAGE_GEMINI_API_KEY',
        'SETTINGS_CHANGE_PDF_SETTINGS',
      ],
    },
    canActivate: [AuthGuard],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class CompanyProfileRoutingModule { }
