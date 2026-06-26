import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { DocumentByCategory } from '@core/domain-classes/document-by-category';
import { catchError } from 'rxjs/operators';
import { CommonError } from '@core/error-handler/common-error';
import { CommonHttpErrorService } from '@core/error-handler/common-http-error.service';
import { CalenderReminderDto } from '@core/domain-classes/calender-reminder';
import { PostBoardData } from '../post-management/post-management.types';

export interface AllCandidatesResponse {
  candidates: unknown[];
}

export interface AssignedInterviewsResponse {
  candidates: unknown[];
}

@Injectable({ providedIn: 'root' })
export class DashboradService {
  constructor(
    private httpClient: HttpClient,
    private commonHttpErrorService: CommonHttpErrorService
  ) {}

  getDocumentByCategory(): Observable<DocumentByCategory[]> {
    const url = `Dashboard/GetDocumentByCategory`;
    return this.httpClient.get<DocumentByCategory[]>(url);
  }

  getReminders(month, year): Observable<CalenderReminderDto[] | CommonError> {
    const url = `dashboard/reminders/${month}/${year}`;
    return this.httpClient
      .get<CalenderReminderDto[]>(url)
      .pipe(catchError(this.commonHttpErrorService.handleError));
  }

  getPostBoard(): Observable<PostBoardData | null> {
    return this.httpClient
      .get<PostBoardData>('proposal-management/post-board')
      .pipe(catchError(() => of(null)));
  }

  getAllCandidates(): Observable<AllCandidatesResponse | null> {
    return this.httpClient
      .get<AllCandidatesResponse>('proposal-management/all-candidates')
      .pipe(catchError(() => of(null)));
  }

  getAssignedInterviews(): Observable<AssignedInterviewsResponse | null> {
    return this.httpClient
      .get<AssignedInterviewsResponse>('proposal-management/assigned-interviews')
      .pipe(catchError(() => of(null)));
  }
}
