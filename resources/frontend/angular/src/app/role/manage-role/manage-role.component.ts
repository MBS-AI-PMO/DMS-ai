import { Component, OnInit } from '@angular/core';
import { ActionService } from '@core/services/action.service';
import { PageService } from '@core/services/page.service';
import { forkJoin, Observable } from 'rxjs';
import { BaseComponent } from 'src/app/base.component';
import { RoleService } from '../role.service';
import { Role } from '@core/domain-classes/role';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { TranslationService } from '@core/services/translation.service';
import { Page } from '@core/domain-classes/page';
import { Action } from '@core/domain-classes/action';

@Component({
  selector: 'app-manage-role',
  templateUrl: './manage-role.component.html',
  styleUrls: ['./manage-role.component.css'],
})
export class ManageRoleComponent extends BaseComponent implements OnInit {
  pages: Page[] = [];
  role: Role;
  loading = true;

  constructor(
    private activeRoute: ActivatedRoute,
    private router: Router,
    private toastrService: ToastrService,
    private pageService: PageService,
    private actionService: ActionService,
    private roleService: RoleService,
    private translationService: TranslationService
  ) {
    super();
  }

  ngOnInit(): void {
    this.role = this.emptyRole();
    this.sub$.sink = this.activeRoute.data.subscribe((data: { role: Role }) => {
      if (data.role) {
        this.role = this.normalizeRole(data.role);
      }
    });
    const getActionRequest = this.actionService.getAll();
    const getPageRequest = this.pageService.getAll();
    this.sub$.sink = forkJoin({ getActionRequest, getPageRequest }).subscribe({
      next: (response) => {
        const actions = response.getActionRequest ?? [];
        const pages = response.getPageRequest ?? [];
        this.pages = pages.map((page) => {
          const pageActions = actions.filter(
            (action) => String(action.pageId ?? (action as Action & { page_id?: string }).page_id) === String(page.id)
          );
          return { ...page, pageActions };
        });
        this.loading = false;
      },
      error: () => {
        this.loading = false;
      },
    });
  }

  private emptyRole(): Role {
    return { roleClaims: [], userRoles: [] };
  }

  private normalizeRole(role: Role): Role {
    const raw = role as Role & {
      role_claims?: Role['roleClaims'];
      roleclaims?: Role['roleClaims'];
    };
    return {
      ...role,
      roleClaims: raw.roleClaims ?? raw.role_claims ?? raw.roleclaims ?? [],
      userRoles: role.userRoles ?? [],
    };
  }
  manageRole(role: Role): void {
    if (!role.name) {
      this.toastrService.error(
        this.translationService.getValue('PLEASE_ENTER_ROLE_NAME')
      );
      return;
    }
    if (role.roleClaims.length == 0) {
      this.toastrService.error(
        this.translationService.getValue('PLEASE_SELECT_AT_LEAT_ONE_PERMISSION')
      );
      return;
    }
    if (!role.id)
      this.sub$.sink = this.roleService.addRole(role).subscribe(() => {
        this.toastrService.success(
          this.translationService.getValue('ROLE_SAVED_SUCCESSFULLY')
        );
        this.router.navigate(['/roles']);
      });
    else
      this.sub$.sink = this.roleService.updateRole(role).subscribe(() => {
        this.toastrService.success(
          this.translationService.getValue('ROLE_UPDATED_SUCCESSFULLY')
        );
        this.router.navigate(['/roles']);
      });
  }
}

//   manageRole(role: Role): void {
//     if (!role.name) {
//       this.toastrService.error(this.translationService.getValue('PLEASE_ENTER_ROLE_NAME'));
//       return;
//     }

//     if (role.roleClaims.length == 0) {
//       this.toastrService.error(this.translationService.getValue('PLEASE_SELECT_AT_LEAT_ONE_PERMISSION'));
//       return;
//     }

//     if (!role.id)
//       this.sub$.sink = this.roleService.addRole(role).subscribe(() => {
//         this.toastrService.success(this.translationService.getValue('ROLE_SAVED_SUCCESSFULLY'));
//         this.router.navigate(['/roles']);
//       });
//     else
//       this.sub$.sink = this.roleService.updateRole(role).subscribe(() => {
//         this.toastrService.success(this.translationService.getValue('ROLE_UPDATED_SUCCESSFULLY'));
//         this.router.navigate(['/roles']);
//       });
//   }
// }
