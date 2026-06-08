import { MatDialog } from '@angular/material/dialog';
import {
  CandidateRejectionReasonDialogComponent,
  CandidateRejectionReasonDialogData,
} from './candidate-rejection-reason-dialog.component';

export function openRejectionReasonDialog(
  dialog: MatDialog,
  data: CandidateRejectionReasonDialogData
): void {
  dialog.open(CandidateRejectionReasonDialogComponent, {
    width: '480px',
    data,
  });
}
