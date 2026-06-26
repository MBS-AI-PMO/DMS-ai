import { MatDialogConfig } from '@angular/material/dialog';

export const DMS_FORM_DIALOG_PANEL = {
  panelClass: 'dms-form-dialog',
  backdropClass: 'dms-confirm-dialog-backdrop',
  autoFocus: false,
};

export const DMS_DOCUMENT_EDIT_DIALOG_CONFIG: MatDialogConfig = {
  ...DMS_FORM_DIALOG_PANEL,
  width: '920px',
  maxWidth: '96vw',
  maxHeight: '92vh',
};

export const DMS_DOCUMENT_COMMENT_DIALOG_CONFIG: MatDialogConfig = {
  ...DMS_FORM_DIALOG_PANEL,
  width: '640px',
  maxWidth: '94vw',
  maxHeight: '85vh',
};

export const DMS_FORM_DIALOG_CONFIG: MatDialogConfig = {
  ...DMS_FORM_DIALOG_PANEL,
  width: '560px',
  maxWidth: '94vw',
  maxHeight: '90vh',
};

export const DMS_FORM_DIALOG_WIDE_CONFIG: MatDialogConfig = {
  ...DMS_FORM_DIALOG_PANEL,
  width: '720px',
  maxWidth: '96vw',
  maxHeight: '92vh',
};

export const DMS_FORM_DIALOG_LARGE_CONFIG: MatDialogConfig = {
  ...DMS_FORM_DIALOG_PANEL,
  width: '860px',
  maxWidth: '96vw',
  maxHeight: '92vh',
};
