import { Directive, Input, TemplateRef, ViewContainerRef } from '@angular/core';
import { SecurityService } from '../core/security/security.service';

@Directive({
  selector: '[hasRole]',
})
export class HasRoleDirective {
  @Input() set hasRole(roleNames: string | string[]) {
    this.viewContainer.clear();

    if (this.securityService.hasRole(roleNames)) {
      this.viewContainer.createEmbeddedView(this.templateRef);
    }
  }

  constructor(
    private templateRef: TemplateRef<unknown>,
    private viewContainer: ViewContainerRef,
    private securityService: SecurityService
  ) {}
}
