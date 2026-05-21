import { CommonModule } from '@angular/common';
import { Component, Inject, OnInit, inject } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatNativeDateModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import {
  MAT_DIALOG_DATA,
  MatDialogModule,
  MatDialogRef,
} from '@angular/material/dialog';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatSelectModule } from '@angular/material/select';
import { User } from '@core/domain-classes/user';
import { CommonService } from '@core/services/common.service';
import { NgSelectModule } from '@ng-select/ng-select';
import { ToastrService } from 'ngx-toastr';
import { BaseComponent } from '../base.component';

export type InterviewLevel = 'basic' | 'intermediate' | 'advanced';
type InterviewPeriod = 'AM' | 'PM';

export interface PostCandidateScheduleDialogData {
  candidateName: string;
  defaultInterviewLevel: InterviewLevel;
  presetInterviewLevel?: InterviewLevel;
  existingInterviewDate?: string | null;
  existingInterviewerUserId?: string | null;
  isReschedule?: boolean;
}

export interface PostCandidateScheduleDialogResult {
  interviewIso: string;
  interviewLevel: InterviewLevel;
  interviewerUserId: string;
  interviewer: string;
}

@Component({
  selector: 'app-post-candidate-schedule-dialog',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    MatButtonModule,
    MatDialogModule,
    MatFormFieldModule,
    MatInputModule,
    MatSelectModule,
    MatDatepickerModule,
    MatNativeDateModule,
    NgSelectModule,
  ],
  template: `
    <h2 mat-dialog-title>{{ data.isReschedule ? 'Reschedule interview' : 'Approval form' }}</h2>
    <mat-dialog-content class="schedule-dialog-content">
      <p class="text-muted small mb-1">
        {{ data.isReschedule ? 'Update interview date/time and optionally notify the candidate.' : 'Schedule interview after approval.' }}
      </p>
      <p class="text-muted small mb-3">Candidate: <strong>{{ data.candidateName }}</strong></p>

      <mat-form-field appearance="outline" class="w-100">
        <mat-label>Interview date</mat-label>
        <input
          matInput
          [matDatepicker]="datePicker"
          [(ngModel)]="interviewDate"
          required
          readonly
          (click)="datePicker.open()" />
        <mat-datepicker-toggle matIconSuffix [for]="datePicker"></mat-datepicker-toggle>
        <mat-datepicker #datePicker></mat-datepicker>
      </mat-form-field>

      <label class="small text-muted d-block mb-1">Interview time</label>
      <div class="row g-2 mb-1">
        <div class="col-4">
          <mat-form-field appearance="outline" class="w-100">
            <mat-label>Hour</mat-label>
            <mat-select [(ngModel)]="interviewHour" required>
              <mat-option *ngFor="let h of hourOptions" [value]="h">{{ h }}</mat-option>
            </mat-select>
          </mat-form-field>
        </div>
        <div class="col-4">
          <mat-form-field appearance="outline" class="w-100">
            <mat-label>Minute</mat-label>
            <mat-select [(ngModel)]="interviewMinute" required>
              <mat-option *ngFor="let m of minuteOptions" [value]="m">{{ formatMinute(m) }}</mat-option>
            </mat-select>
          </mat-form-field>
        </div>
        <div class="col-4">
          <mat-form-field appearance="outline" class="w-100">
            <mat-label>AM/PM</mat-label>
            <mat-select [(ngModel)]="interviewPeriod" required>
              <mat-option value="AM">AM</mat-option>
              <mat-option value="PM">PM</mat-option>
            </mat-select>
          </mat-form-field>
        </div>
      </div>
      <p class="small text-muted mb-3">
        Selected time: <strong>{{ formatTimeDisplay() }}</strong>
      </p>

      <div class="mb-3">
        <label class="small text-muted d-block mb-1">Interviewer</label>
        <ng-select
          [(ngModel)]="interviewerUserId"
          [items]="users"
          bindLabel="displayName"
          bindValue="id"
          [searchable]="true"
          [clearable]="false"
          placeholder="Search and select user"
          notFoundText="No users found"
          appendTo="body">
        </ng-select>
      </div>

      <div class="mb-2">
        <div class="small text-muted mb-1">Interview kit level</div>
        <div class="d-flex flex-wrap gap-2">
          <button
            mat-stroked-button
            type="button"
            *ngFor="let level of levels"
            [color]="interviewLevel === level ? 'primary' : undefined"
            (click)="interviewLevel = level">
            {{ levelLabel(level) }}
          </button>
        </div>
      </div>
    </mat-dialog-content>
    <mat-dialog-actions align="end">
      <button mat-button type="button" (click)="cancel()">Cancel</button>
      <button mat-flat-button color="primary" type="button" (click)="submit()">
        {{ data.isReschedule ? 'Reschedule' : 'Schedule' }}
      </button>
    </mat-dialog-actions>
  `,
  styles: [
    `
      .schedule-dialog-content {
        min-width: min(420px, 92vw);
        padding-top: 8px;
        overflow: visible;
      }
    `,
  ],
})
export class PostCandidateScheduleDialogComponent extends BaseComponent implements OnInit {
  private readonly commonService = inject(CommonService);

  readonly levels: InterviewLevel[] = ['basic', 'intermediate', 'advanced'];
  readonly hourOptions = Array.from({ length: 12 }, (_, i) => i + 1);
  readonly minuteOptions = Array.from({ length: 60 }, (_, i) => i);

  interviewDate: Date | null = null;
  interviewHour = 10;
  interviewMinute = 0;
  interviewPeriod: InterviewPeriod = 'AM';
  interviewerUserId: string | null = null;
  users: (User & { displayName: string })[] = [];
  interviewLevel: InterviewLevel;

  constructor(
    private readonly dialogRef: MatDialogRef<
      PostCandidateScheduleDialogComponent,
      PostCandidateScheduleDialogResult | undefined
    >,
    @Inject(MAT_DIALOG_DATA) readonly data: PostCandidateScheduleDialogData,
    private readonly toastr: ToastrService,
  ) {
    super();
    this.interviewLevel = data.presetInterviewLevel ?? data.defaultInterviewLevel;
    this.interviewerUserId = data.existingInterviewerUserId || null;

    const parsed = this.parseExistingIso(data.existingInterviewDate);
    if (parsed) {
      this.interviewDate = parsed.date;
      this.setTimeFrom24h(parsed.hour24, parsed.minute);
    } else {
      this.interviewDate = new Date();
      this.setTimeFrom24h(10, 0);
    }
  }

  ngOnInit(): void {
    this.sub$.sink = this.commonService.getUsersForDropdown().subscribe({
      next: (users) => {
        if (!Array.isArray(users)) {
          return;
        }
        this.users = users.map((user) => ({
          ...user,
          displayName: this.formatUserLabel(user),
        }));
      },
      error: () => {
        this.toastr.error('Could not load user list.');
      },
    });
  }

  formatMinute(value: number): string {
    return String(value).padStart(2, '0');
  }

  formatTimeDisplay(): string {
    return `${this.interviewHour}:${this.formatMinute(this.interviewMinute)} ${this.interviewPeriod}`;
  }

  private setTimeFrom24h(hour24: number, minute: number): void {
    this.interviewMinute = minute;
    this.interviewPeriod = hour24 >= 12 ? 'PM' : 'AM';
    const hour12 = hour24 % 12;
    this.interviewHour = hour12 === 0 ? 12 : hour12;
  }

  private to24Hour(hour12: number, period: InterviewPeriod): number {
    if (period === 'AM') {
      return hour12 === 12 ? 0 : hour12;
    }
    return hour12 === 12 ? 12 : hour12 + 12;
  }

  private formatUserLabel(user: User): string {
    const name = [user.firstName, user.lastName].filter(Boolean).join(' ').trim();
    if (name && user.userName) {
      return `${name} (${user.userName})`;
    }
    return name || user.userName || user.email || 'User';
  }

  private parseExistingIso(iso?: string | null): { date: Date; hour24: number; minute: number } | null {
    if (!iso) {
      return null;
    }
    const d = new Date(iso);
    if (isNaN(d.getTime())) {
      return null;
    }
    return {
      date: new Date(d.getFullYear(), d.getMonth(), d.getDate()),
      hour24: d.getHours(),
      minute: d.getMinutes(),
    };
  }

  private formatDateForIso(date: Date): string {
    const pad = (n: number) => String(n).padStart(2, '0');
    return `${date.getFullYear()}-${pad(date.getMonth() + 1)}-${pad(date.getDate())}`;
  }

  levelLabel(level: InterviewLevel): string {
    const labels: Record<InterviewLevel, string> = {
      basic: 'Beginner',
      intermediate: 'Intermediate',
      advanced: 'Advanced',
    };
    return labels[level];
  }

  cancel(): void {
    this.dialogRef.close(undefined);
  }

  submit(): void {
    if (!this.interviewDate || this.interviewHour == null || this.interviewMinute == null || !this.interviewerUserId) {
      this.toastr.warning('Please select interview date, time, and an interviewer.');
      return;
    }

    const hour24 = this.to24Hour(this.interviewHour, this.interviewPeriod);
    const pad = (n: number) => String(n).padStart(2, '0');
    const time = `${pad(hour24)}:${pad(this.interviewMinute)}`;
    const iso = new Date(`${this.formatDateForIso(this.interviewDate)}T${time}`).toISOString();

    if (isNaN(Date.parse(iso))) {
      this.toastr.error('Invalid date or time.');
      return;
    }

    const selected = this.users.find((u) => u.id === this.interviewerUserId);
    const interviewer = selected ? this.formatUserLabel(selected) : '';
    this.dialogRef.close({
      interviewIso: iso,
      interviewLevel: this.interviewLevel,
      interviewerUserId: this.interviewerUserId,
      interviewer,
    });
  }
}

