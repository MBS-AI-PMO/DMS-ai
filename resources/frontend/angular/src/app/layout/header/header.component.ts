import { DOCUMENT } from '@angular/common';
import {
  Component,
  Inject,
  ElementRef,
  OnInit,
  Renderer2,
  HostListener,
  ChangeDetectorRef,
} from '@angular/core';
import { Router } from '@angular/router';
import { WINDOW } from '@core/services/window.service';
import { SecurityService } from '@core/security/security.service';
import { TranslationService } from '@core/services/translation.service';
import { NotificationService } from 'src/app/notification/notification.service';
import { UserNotification } from '@core/domain-classes/notification';
import { Direction } from '@angular/cdk/bidi';
import { User } from '@core/domain-classes/user';
import { NotificationType } from '@core/domain-classes/notification-enum';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss'],
})
export class HeaderComponent implements OnInit {
  isNavbarCollapsed = true;
  isNavbarShow = true;
  isOpenSidebar = false;
  docElement: HTMLElement | undefined;
  isFullScreen = false;
  appUser: User = null;
  newNotificationCount = 0;
  notifications: UserNotification[] = [];
  refereshReminderTimeInMinute = 10;
  logoImage = '';
  smallLogoImage = '';
  isUnReadNotification = false;
  direction: Direction;

  constructor(
    @Inject(DOCUMENT) private document: Document,
    @Inject(WINDOW) private window: Window,
    private renderer: Renderer2,
    public elementRef: ElementRef,
    private router: Router,
    private securityService: SecurityService,
    private translationService: TranslationService,
    private cd: ChangeDetectorRef,
    private notificationService: NotificationService
  ) { }

  @HostListener('window:scroll', [])
  onWindowScroll() {
    this.window.pageYOffset ||
      this.document.documentElement.scrollTop ||
      this.document.body.scrollTop ||
      0;
    // if (offset > 50) {
    //   this.isNavbarShow = true;
    // } else {
    //   this.isNavbarShow = false;
    // }
  }
  ngOnInit() {
    this.setTopLogAndName();
    this.getNotification();
    this.companyProfileSubscription();
    this.getLangDir();
    this.sidebarMenuStatus();
  }

  getLangDir() {
    this.translationService.lanDir$.subscribe((c: Direction) => {
      this.direction = c;
    });
  }
  sidebarMenuStatus() {
    this.notificationService.sideMenuStatus$.subscribe((status) => {
      this.isOpenSidebar = status;
    });
  }
  companyProfileSubscription() {
    this.securityService.companyProfile.subscribe((profile) => {
      if (profile) {
        this.logoImage = profile.logoUrl;
        this.smallLogoImage = profile.smallLogoUrl;
      }
    });
  }

  setTopLogAndName() {
    this.securityService.SecurityObject.subscribe((c) => {
      if (c) {
        this.appUser = c;
      } else {
        this.appUser = this.securityService.getUserDetail();
      }
    });
  }

  getNotification() {
    if (!this.securityService.isLogin()) {
      return;
    }

    this.notificationService
      .getNotification()
      .subscribe((notifications: UserNotification[]) => {
        this.newNotificationCount = notifications.filter(
          (c) => !c.isRead
        ).length;
        this.notifications = notifications;
        this.isUnReadNotification = this.notifications.some((n) => !n.isRead);
        this.cd.detectChanges();

        setTimeout(() => {
          this.getNotification();
        }, this.refereshReminderTimeInMinute * 60 * 1000);
      });
  }

  markAllAsReadNotification() {
    this.notificationService.markAllAsRead().subscribe(() => {
      this.getNotification();
    });
  }

  mobileMenuSidebarOpen(event: Event, className: string) {
    const hasClass = (event.target as HTMLInputElement).classList.contains(
      className
    );
    if (hasClass) {
      this.renderer.removeClass(this.document.body, className);
    } else {
      this.renderer.addClass(this.document.body, className);
    }
  }

  callSidemenuCollapse() {
    const hasClass = this.document.body.classList.contains('side-closed');
    if (hasClass) {
      this.notificationService.setSideMenuStatus(false);
      this.renderer.removeClass(this.document.body, 'side-closed');
      this.renderer.removeClass(this.document.body, 'submenu-closed');
      localStorage.setItem('collapsed_menu', 'false');
    } else {
      this.renderer.addClass(this.document.body, 'side-closed');
      this.renderer.addClass(this.document.body, 'submenu-closed');
      localStorage.setItem('collapsed_menu', 'true');
      this.notificationService.setSideMenuStatus(true);
    }
  }

  viewNotification(notification: UserNotification) {
    if (!notification.isRead) {
      this.notificationService
        .markAsRead(notification.id)
        .subscribe();
    }

    notification.isRead = true;
    if (notification.notificationType == NotificationType.DOCUMENT_SHARE) {
      this.router.navigate(['/']);
    } else if (notification.notificationType == NotificationType.FILE_REQUEST) {
      this.router.navigate(['/file-request']);
    } else if (notification.notificationType == NotificationType.WORKFLOW) {
      this.router.navigate(['/current-workflow']);
    } else if (notification.notificationType == NotificationType.REMINDER) {
      this.router.navigate(['/reminders']);
    }
  }

  markAsReadNotification(id) {
    this.notificationService.markAsRead(id).subscribe(() => {
      this.getNotification();
    });
  }

  onProfileClick() {
    this.router.navigate(['my-profile']);
  }

  logout() {
    this.securityService.logout();
  }
}
