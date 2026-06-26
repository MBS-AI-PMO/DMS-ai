import { Component, EventEmitter, Input, Output } from '@angular/core';
import { Action } from '@core/domain-classes/action';
import { Page } from '@core/domain-classes/page';
import { Role } from '@core/domain-classes/role';
import { RoleClaim } from '@core/domain-classes/role-claim';
import { BaseComponent } from 'src/app/base.component';
import { TranslationService } from '@core/services/translation.service';
import { MatCheckboxChange } from '@angular/material/checkbox';

@Component({
  selector: 'app-manage-role-presentation',
  templateUrl: './manage-role-presentation.component.html',
  styleUrls: ['./manage-role-presentation.component.scss'],
})
export class ManageRolePresentationComponent extends BaseComponent {
  @Input() pages: Page[];
  @Input() role: Role;
  @Output() onManageRoleAction: EventEmitter<Role> = new EventEmitter<Role>();

  constructor(public translationService: TranslationService) {
    super();
  }

  getTotalActionCount(): number {
    return (this.pages ?? []).reduce(
      (total, page) => total + this.getPageActions(page).length,
      0
    );
  }

  getSelectedCount(): number {
    return this.ensureRoleClaims().length;
  }

  getPageSelectedCount(page: Page): number {
    const actionIds = this.getPageActions(page).map((action) => action.id);
    return this.ensureRoleClaims().filter((claim) =>
      actionIds.includes(claim.actionId)
    ).length;
  }

  isPageFullySelected(page: Page): boolean {
    const actions = this.getPageActions(page);
    if (!actions.length) {
      return false;
    }
    return actions.every((action) => this.checkPermission(action.id));
  }

  isPagePartiallySelected(page: Page): boolean {
    const selected = this.getPageSelectedCount(page);
    const total = this.getPageActions(page).length;
    return selected > 0 && selected < total;
  }

  isAllSelected(): boolean {
    const total = this.getTotalActionCount();
    return total > 0 && this.getSelectedCount() === total;
  }

  isPartiallySelected(): boolean {
    const selected = this.getSelectedCount();
    const total = this.getTotalActionCount();
    return selected > 0 && selected < total;
  }

  toPermissionKey(name?: string): string {
    return (name ?? '').replaceAll(' ', '_').toUpperCase();
  }

  getPageActions(page: Page): Action[] {
    const raw = page as Page & { pageactions?: Action[] };
    return page?.pageActions ?? raw?.pageactions ?? [];
  }

  onPageSelect(event: MatCheckboxChange, page: Page) {
    const claims = this.ensureRoleClaims();
    if (event.checked) {
      this.getPageActions(page).forEach((action) => {
        if (!this.checkPermission(action.id)) {
          claims.push({
            roleId: this.role.id,
            claimType: action.code,
            claimValue: '',
            actionId: action.id,
          });
        }
      });
    } else {
      const actions = this.getPageActions(page).map((c) => c.id);
      this.role.roleClaims = claims.filter(
        (c) => actions.indexOf(c.actionId) < 0
      );
    }
  }

  selecetAll(event: MatCheckboxChange) {
    const claims = this.ensureRoleClaims();
    if (event.checked) {
      this.pages.forEach((page) => {
        this.getPageActions(page).forEach((action) => {
          if (!this.checkPermission(action.id)) {
            claims.push({
              roleId: this.role.id,
              claimType: action.code,
              claimValue: '',
              actionId: action.id,
            });
          }
        });
      });
    } else {
      this.role.roleClaims = [];
    }
  }

  private ensureRoleClaims(): RoleClaim[] {
    if (!this.role) {
      return [];
    }
    if (!this.role.roleClaims) {
      this.role.roleClaims = [];
    }
    return this.role.roleClaims;
  }

  checkPermission(actionId: string): boolean {
    return !!this.ensureRoleClaims().find((c) => c.actionId === actionId);
  }

  onPermissionChange(event: MatCheckboxChange, page: Page, action: Action) {
    const claims = this.ensureRoleClaims();
    if (event.checked) {
      claims.push({
        roleId: this.role.id,
        claimType: action.code,
        claimValue: '',
        actionId: action.id,
      });
    } else {
      const roleClaimToRemove = claims.find((c) => c.actionId === action.id);
      const index = claims.indexOf(roleClaimToRemove, 0);
      if (index > -1) {
        claims.splice(index, 1);
      }
    }
  }

  saveRole(): void {
    this.onManageRoleAction.emit(this.role);
  }
}
