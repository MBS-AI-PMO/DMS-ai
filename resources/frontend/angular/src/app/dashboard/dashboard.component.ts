import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { DocumentByCategory } from '@core/domain-classes/document-by-category';
import { SecurityService } from '@core/security/security.service';
import { forkJoin, of } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { BaseComponent } from '../base.component';
import { DocumentWorkflowService } from '../workflows/manage-workflow/document-workflow.service';
import { DashboradService } from './dashboard.service';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss'],
})
export class DashboardComponent extends BaseComponent implements OnInit {
  isLoading = true;
  categoryData: DocumentByCategory[] = [];
  stats = {
    totalDocuments: 0,
    totalCategories: 0,
    activeWorkflows: 0,
    topCategory: '-',
  };
  postStats = {
    totalPosts: 0,
    totalPostCategories: 0,
    totalDepartments: 0,
    totalApplications: 0,
    totalCandidates: 0,
    assignedInterviews: 0,
  };

  constructor(
    private dashboardService: DashboradService,
    private documentWorkflowService: DocumentWorkflowService,
    private securityService: SecurityService,
    private router: Router
  ) {
    super();
  }

  ngOnInit(): void {
    this.loadDashboardData();
  }

  get hasPostManagementSection(): boolean {
    return (
      this.securityService.hasClaim('POST_MANAGEMENT_VIEW') ||
      this.securityService.hasClaim('ALL_CANDIDATES_VIEW') ||
      this.securityService.hasClaim('INTERVIEWS_VIEW_ASSIGNED')
    );
  }

  loadDashboardData(): void {
    this.isLoading = true;

    const workflow$ = this.securityService.hasClaim('WORKFLOW_VIEW_MY_WORKFLOWS')
      ? this.documentWorkflowService.getMyWorkflow().pipe(catchError(() => of([])))
      : of([]);

    const postBoard$ = this.securityService.hasClaim('POST_MANAGEMENT_VIEW')
      ? this.dashboardService.getPostBoard()
      : of(null);

    const allCandidates$ = this.securityService.hasClaim('ALL_CANDIDATES_VIEW')
      ? this.dashboardService.getAllCandidates()
      : of(null);

    const assignedInterviews$ = this.securityService.hasClaim('INTERVIEWS_VIEW_ASSIGNED')
      ? this.dashboardService.getAssignedInterviews()
      : of(null);

    this.sub$.sink = forkJoin({
      categories: this.dashboardService
        .getDocumentByCategory()
        .pipe(catchError(() => of([]))),
      workflows: workflow$,
      postBoard: postBoard$,
      allCandidates: allCandidates$,
      assignedInterviews: assignedInterviews$,
    }).subscribe(({ categories, workflows, postBoard, allCandidates, assignedInterviews }) => {
      this.categoryData = categories ?? [];
      this.stats.totalDocuments = this.categoryData.reduce(
        (sum, item) => sum + (item.documentCount ?? 0),
        0
      );
      this.stats.totalCategories = this.categoryData.length;

      const topCategory = [...this.categoryData].sort(
        (a, b) => (b.documentCount ?? 0) - (a.documentCount ?? 0)
      )[0];
      this.stats.topCategory = topCategory?.categoryName ?? '-';
      this.stats.activeWorkflows = Array.isArray(workflows) ? workflows.length : 0;

      if (postBoard) {
        this.postStats.totalPosts = postBoard.posts?.length ?? 0;
        this.postStats.totalPostCategories = postBoard.categories?.length ?? 0;
        this.postStats.totalDepartments = postBoard.departments?.length ?? 0;
        this.postStats.totalApplications = (postBoard.posts ?? []).reduce(
          (sum, post) => sum + (post.candidates?.length ?? 0),
          0
        );
      } else {
        this.postStats.totalPosts = 0;
        this.postStats.totalPostCategories = 0;
        this.postStats.totalDepartments = 0;
        this.postStats.totalApplications = 0;
      }

      this.postStats.totalCandidates = allCandidates?.candidates?.length ?? 0;
      this.postStats.assignedInterviews = assignedInterviews?.candidates?.length ?? 0;
      this.isLoading = false;
    });
  }

  navigateTo(path: string): void {
    this.router.navigate([path]);
  }
}
