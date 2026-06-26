import { Component, inject, Inject, Input, OnInit, ViewEncapsulation } from '@angular/core';
import {
  FormArray,
  FormGroup,
  UntypedFormBuilder,
  UntypedFormControl,
  UntypedFormGroup,
  Validators,
} from '@angular/forms';
import { MatCheckboxChange } from '@angular/material/checkbox';
import { MatDialogRef, MAT_DIALOG_DATA, MatDialog } from '@angular/material/dialog';
import { Category } from '@core/domain-classes/category';
import { DocumentAuditTrail } from '@core/domain-classes/document-audit-trail';
import { DocumentInfo } from '@core/domain-classes/document-info';
import { DocumentOperation } from '@core/domain-classes/document-operation';
import { DocumentMetaData } from '@core/domain-classes/documentMetaData';
import { DocumentPermission } from '@core/domain-classes/document-permission';
import { Role } from '@core/domain-classes/role';
import { User } from '@core/domain-classes/user';
import { CommonError } from '@core/error-handler/common-error';
import { SecurityService } from '@core/security/security.service';
import { CommonService } from '@core/services/common.service';
import { TranslationService } from '@core/services/translation.service';
import { ToastrService } from 'ngx-toastr';
import { forkJoin, Observable, of } from 'rxjs';
import { BaseComponent } from 'src/app/base.component';
import { ClientStore } from 'src/app/client/client-store';
import { CategoryStore } from 'src/app/category/store/category-store';
import { DocumentStatusStore } from 'src/app/document-status/store/document-status.store';
import { ManageCategoryComponent } from 'src/app/category/manage-category/manage-category.component';
import { DocumentPermissionService } from '../document-permission/document-permission.service';
import { DocumentService } from '../document.service';
import { Direction } from '@angular/cdk/bidi';
import { RetentionActionEnum } from '@core/domain-classes/retention-action-enum';

@Component({
  selector: 'app-document-edit',
  templateUrl: './document-edit.component.html',
  styleUrls: ['./document-edit.component.scss'],
  encapsulation: ViewEncapsulation.None,
})
export class DocumentEditComponent extends BaseComponent implements OnInit {
  document: DocumentInfo;
  documentForm: UntypedFormGroup;
  extension = '';
  @Input() categories: Category[];
  @Input() documentInfo: DocumentInfo;
  documentSource: string;
  direction: Direction;
  documentstatusStore = inject(DocumentStatusStore);
  categoryStore = inject(CategoryStore);
  retentionActions: { key: string; value: number }[] = [];
  users: User[] = [];
  roles: Role[] = [];
  minDate: Date;
  isS3Supported = false;
  private initialRoleIds = new Set<string>();
  private initialUserIds = new Set<string>();
  compareRole = (roleA: Role, roleB: Role): boolean =>
    !!roleA && !!roleB && roleA.id === roleB.id;
  compareUser = (userA: User, userB: User): boolean =>
    !!userA && !!userB && userA.id === userB.id;

  get documentMetaTagsArray(): FormArray {
    return <FormArray>this.documentForm.get('documentMetaTags');
  }

  public clientStore = inject(ClientStore);

  constructor(
    private fb: UntypedFormBuilder,
    public dialogRef: MatDialogRef<DocumentEditComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private toastrService: ToastrService,
    private documentService: DocumentService,
    private documentPermissionService: DocumentPermissionService,
    private commonService: CommonService,
    private translationService: TranslationService,
    private securityService: SecurityService,
    private mtDialog: MatDialog
  ) {
    super();
    this.minDate = new Date();
  }

  ngOnInit(): void {
    this.retentionActions = this.getEnumValues(RetentionActionEnum);
    this.createDocumentForm();
    this.pushValuesDocumentMetatagArray();
    this.patchDocumentForm();
    this.getLangDir();
    this.subscribeCompanyProfile();
    this.loadRolesUsersAndPermissions();
  }

  getLangDir() {
    this.sub$.sink = this.translationService.lanDir$.subscribe(
      (c: Direction) => (this.direction = c)
    );
  }

  patchDocumentForm() {
    const document = this.data.document ?? {};
    this.documentForm.patchValue({
      ...document,
      location: document.location ?? 'local',
    });
  }

  getEnumValues(enumObj: any): { key: string; value: number }[] {
    return Object.keys(enumObj)
      .filter((key) => isNaN(Number(key)))
      .map((key) => ({
        key: key,
        value: enumObj[key],
      }));
  }

  subscribeCompanyProfile() {
    this.sub$.sink = this.securityService.companyProfile.subscribe((profile) => {
      if (!profile) {
        return;
      }

      this.isS3Supported = !!profile.isS3Supported;
      if (!this.data.document?.location) {
        this.documentForm.get('location')?.setValue(profile.location ?? 'local');
      }
    });
  }

  loadRolesUsersAndPermissions() {
    const documentId = this.data.document?.id;
    if (!documentId) {
      this.sub$.sink = forkJoin({
        users: this.commonService.getUsersForDropdown(),
        roles: this.commonService.getRolesForDropdown(),
      }).subscribe(({ users, roles }) => {
        this.users = (users as User[]) ?? [];
        this.roles = (roles as Role[]) ?? [];
      });
      return;
    }

    this.sub$.sink = forkJoin({
      users: this.commonService.getUsersForDropdown(),
      roles: this.commonService.getRolesForDropdown(),
      permissions: this.documentPermissionService.getDoucmentPermission(documentId),
    }).subscribe(({ users, roles, permissions }) => {
      this.users = (users as User[]) ?? [];
      this.roles = (roles as Role[]) ?? [];
      this.applyPermissionSelections((permissions as DocumentPermission[]) ?? []);
    });
  }

  applyPermissionSelections(permissions: DocumentPermission[]) {
    const rolePermissions = permissions.filter((p) => p.type === 'Role');
    const userPermissions = permissions.filter((p) => p.type === 'User');

    rolePermissions.forEach((p) => {
      if (p.roleId) {
        this.initialRoleIds.add(p.roleId);
      }
    });
    userPermissions.forEach((p) => {
      if (p.userId) {
        this.initialUserIds.add(p.userId);
      }
    });

    const selectedRoles = rolePermissions
      .map((p) => this.roles.find((role) => role.id === p.roleId) ?? p.role)
      .filter((role): role is Role => !!role?.id);
    const selectedUsers = userPermissions
      .map((p) => this.users.find((user) => user.id === p.userId) ?? p.user)
      .filter((user): user is User => !!user?.id);

    this.documentForm.patchValue({
      selectedRoles,
      selectedUsers,
    });
  }

  getUserDisplayName(user: User): string {
    if (!user) {
      return '';
    }

    const fullName = [user.firstName, user.lastName].filter(Boolean).join(' ').trim();
    return fullName || user.userName || user.email || '';
  }

  getRoleDisplayName(role: Role): string {
    return role?.name ?? '';
  }

  createDocumentForm() {
    this.documentForm = this.fb.group({
      name: ['', [Validators.required]],
      description: [''],
      categoryId: ['', [Validators.required]],
      location: ['local'],
      documentMetaTags: this.fb.array([]),
      retentionPeriod: [''],
      retentionAction: [''],
      clientId: [''],
      statusId: [''],
      selectedRoles: [],
      selectedUsers: [],
      rolePermissionForm: this.fb.group({
        isTimeBound: new UntypedFormControl(false),
        startDate: [''],
        endDate: [''],
        isAllowDownload: new UntypedFormControl(false),
      }),
      userPermissionForm: this.fb.group({
        isTimeBound: new UntypedFormControl(false),
        startDate: [''],
        endDate: [''],
        isAllowDownload: new UntypedFormControl(false),
      }),
    });
  }

  get rolePermissionFormGroup() {
    return this.documentForm.get('rolePermissionForm') as FormGroup;
  }

  get userPermissionFormGroup() {
    return this.documentForm.get('userPermissionForm') as FormGroup;
  }

  get currentDocumentFileName(): string {
    return this.data.document?.name || this.data.document?.url || '';
  }

  SaveDocument() {
    if (!this.documentForm.valid) {
      this.markFormGroupTouched(this.documentForm);
      return;
    }

    this.sub$.sink = this.documentService
      .updateDocument(this.buildDocumentObject())
      .subscribe({
        next: () => {
          this.sub$.sink = this.saveNewPermissions().subscribe({
            next: () => {
              this.toastrService.success(
                this.translationService.getValue('DOCUMENT_UPDATE_SUCCESSFULLY')
              );
              this.addDocumentTrail();
            },
            error: () => {
              this.toastrService.success(
                this.translationService.getValue('DOCUMENT_UPDATE_SUCCESSFULLY')
              );
              this.addDocumentTrail();
            },
          });
        },
        error: (err: CommonError) => {
          const message =
            err?.messages?.[0] ||
            (err?.error as { message?: string })?.message ||
            this.translationService.getValue('ERROR');
          this.toastrService.error(
            typeof message === 'string' ? message : 'Error in saving data.'
          );
        },
      });
  }

  private saveNewPermissions(): Observable<unknown> {
    const documentId = this.data.document.id;
    const selectedRoles: Role[] = this.documentForm.get('selectedRoles').value ?? [];
    const selectedUsers: User[] = this.documentForm.get('selectedUsers').value ?? [];
    const newRoles = selectedRoles.filter(
      (role) => role?.id && !this.initialRoleIds.has(role.id)
    );
    const newUsers = selectedUsers.filter(
      (user) => user?.id && !this.initialUserIds.has(user.id)
    );
    const calls: Observable<unknown>[] = [];

    if (newRoles.length > 0) {
      calls.push(
        this.documentPermissionService.addDocumentRolePermission(
          newRoles.map((role) =>
            Object.assign(
              {
                documentId,
                roleId: role.id,
              },
              this.rolePermissionFormGroup.value
            )
          )
        )
      );
    }

    if (newUsers.length > 0) {
      calls.push(
        this.documentPermissionService.addDocumentUserPermission(
          newUsers.map((user) =>
            Object.assign(
              {
                documentId,
                userId: user.id,
              },
              this.userPermissionFormGroup.value
            )
          )
        )
      );
    }

    return calls.length > 0 ? forkJoin(calls) : of(null);
  }

  addDocumentTrail() {
    const objDocumentAuditTrail: DocumentAuditTrail = {
      documentId: this.data.document.id,
      operationName: DocumentOperation.Modified.toString(),
    };
    this.sub$.sink = this.commonService
      .addDocumentAuditTrail(objDocumentAuditTrail)
      .subscribe({
        next: () => {
          this.dialogRef.close('loaded');
        },
        error: () => {
          this.dialogRef.close('loaded');
        },
      });
  }

  closeDialog() {
    this.dialogRef.close();
  }

  private markFormGroupTouched(formGroup: UntypedFormGroup) {
    (<any>Object).values(formGroup.controls).forEach((control) => {
      control.markAsTouched();
      if (control.controls) {
        this.markFormGroupTouched(control);
      }
    });
  }

  buildDocumentObject(): DocumentInfo {
    const documentMetaTags = this.documentMetaTagsArray.value;
    const clientId = this.documentForm.get('clientId').value;
    const statusId = this.documentForm.get('statusId').value;
    const retentionPeriod = this.documentForm.get('retentionPeriod').value;
    const retentionAction = this.documentForm.get('retentionAction').value;
    const document: DocumentInfo = {
      id: this.data.document.id,
      categoryId: this.documentForm.get('categoryId').value,
      clientId: clientId || null,
      statusId: statusId || null,
      retentionPeriod: retentionPeriod || null,
      retentionAction: retentionAction ?? null,
      location: this.documentForm.get('location').value ?? 'local',
      description: this.documentForm.get('description').value,
      name: this.documentForm.get('name').value,
      documentMetaDatas: [...documentMetaTags],
    };
    return document;
  }

  onDocumentCancel() {
    this.dialogRef.close('canceled');
  }

  onAddAnotherMetaTag() {
    const documentMetaTag: DocumentMetaData = {
      id: '',
      documentId: this.document && this.document.id ? this.document.id : '',
      metatag: '',
    };
    this.documentMetaTagsArray.insert(
      0,
      this.editDocmentMetaData(documentMetaTag)
    );
  }

  onDeleteMetaTag(index: number) {
    this.documentMetaTagsArray.removeAt(index);
  }

  buildDocumentMetaTag(): FormGroup {
    return this.fb.group({
      id: [''],
      documentId: [''],
      metatag: [''],
    });
  }

  pushValuesDocumentMetatagArray() {
    this.sub$.sink = this.documentService
      .getdocumentMetadataById(this.data.document.id)
      .subscribe((result: DocumentMetaData[]) => {
        if (result.length > 0) {
          result.map((documentMetatag) => {
            this.documentMetaTagsArray.push(
              this.editDocmentMetaData(documentMetatag)
            );
          });
        } else {
          this.documentMetaTagsArray.push(this.buildDocumentMetaTag());
        }
      });
  }

  onMetatagChange(event: any, index: number) {
    const email = this.documentMetaTagsArray.at(index).get('metatag').value;
    if (!email) {
      return;
    }
    const emailControl = this.documentMetaTagsArray.at(index).get('metatag');
    emailControl.setValidators([Validators.required]);
    emailControl.updateValueAndValidity();
  }

  editDocmentMetaData(documentMetatag: DocumentMetaData): FormGroup {
    return this.fb.group({
      id: [documentMetatag.id],
      documentId: [documentMetatag.documentId],
      metatag: [documentMetatag.metatag],
    });
  }

  roleTimeBoundChange(event: MatCheckboxChange) {
    if (event.checked) {
      this.rolePermissionFormGroup
        .get('startDate')
        .setValidators([Validators.required]);
      this.rolePermissionFormGroup
        .get('endDate')
        .setValidators([Validators.required]);
    } else {
      this.rolePermissionFormGroup.get('startDate').clearValidators();
      this.rolePermissionFormGroup.get('startDate').updateValueAndValidity();
      this.rolePermissionFormGroup.get('endDate').clearValidators();
      this.rolePermissionFormGroup.get('endDate').updateValueAndValidity();
    }
  }

  userTimeBoundChange(event: MatCheckboxChange) {
    if (event.checked) {
      this.userPermissionFormGroup
        .get('startDate')
        .setValidators([Validators.required]);
      this.userPermissionFormGroup
        .get('endDate')
        .setValidators([Validators.required]);
    } else {
      this.userPermissionFormGroup.get('startDate').clearValidators();
      this.userPermissionFormGroup.get('startDate').updateValueAndValidity();
      this.userPermissionFormGroup.get('endDate').clearValidators();
      this.userPermissionFormGroup.get('endDate').updateValueAndValidity();
    }
  }

  onAddCategory() {
    const dialogRef = this.mtDialog.open(ManageCategoryComponent, {
      width: '400px',
    });
    dialogRef.afterClosed().subscribe((result) => {
      if (result) {
        setTimeout(() => {
          this.documentForm
            .get('categoryId')
            .setValue(this.categoryStore.currentCategoryId());
        }, 1000);
      }
    });
  }
}
