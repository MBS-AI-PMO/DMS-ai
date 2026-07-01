import { CommonModule } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit, inject } from '@angular/core';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { TranslateModule } from '@ngx-translate/core';
import { SecurityService } from '@core/security/security.service';
import { ToastrService } from 'ngx-toastr';
import { SharedModule } from '@shared/shared.module';
import { BaseComponent } from '../base.component';
import { PostDescriptionHtmlPipe } from './post-description-html.pipe';
import { PostBoardData, ProposalPost } from './post-management.types';
import { formatDisplayDate } from './post-management.utils';

@Component({
  selector: 'app-job-view',
  standalone: true,
  imports: [
    CommonModule,
    RouterLink,
    TranslateModule,
    MatButtonModule,
    MatCardModule,
    MatIconModule,
    SharedModule,
    PostDescriptionHtmlPipe,
  ],
  templateUrl: './job-view.component.html',
  styleUrl: './job-view.component.scss',
})
export class JobViewComponent extends BaseComponent implements OnInit {
  private readonly httpClient = inject(HttpClient);
  private readonly route = inject(ActivatedRoute);
  private readonly router = inject(Router);
  private readonly toastrService = inject(ToastrService);
  private readonly securityService = inject(SecurityService);
  private readonly applyBaseUrl = `${window.location.protocol}//${window.location.host}/post-apply/`;

  post: ProposalPost | null = null;
  loading = false;
  postId = '';

  ngOnInit(): void {
    this.postId = this.route.snapshot.paramMap.get('id') || '';
    this.loadPost();
  }

  loadPost(): void {
    if (!this.postId) {
      return;
    }

    this.loading = true;
    this.sub$.sink = this.httpClient.get<PostBoardData>('proposal-management/post-board').subscribe({
      next: (response) => {
        this.post = (response.posts || []).find((item) => item.id === this.postId) || null;
        this.loading = false;
      },
      error: () => {
        this.loading = false;
      },
    });
  }

  get canManageCandidates(): boolean {
    return this.securityService.hasClaim('POST_MANAGEMENT_VIEW');
  }

  getApplyLink(post: ProposalPost): string {
    return `${this.applyBaseUrl}${post.id}`;
  }

  copyApplyLink(post: ProposalPost): void {
    navigator.clipboard.writeText(this.getApplyLink(post));
    this.toastrService.success('Apply link copied');
  }

  openCandidates(post: ProposalPost): void {
    void this.router.navigate(['/post-management', post.id, 'candidates']);
  }

  formatDisplayDate = formatDisplayDate;
}
