/* eslint-disable @typescript-eslint/no-unused-vars */

import { Router, NavigationEnd } from '@angular/router';

import { DOCUMENT } from '@angular/common';

import {
  ChangeDetectorRef,
  Component,
  Inject,
  ElementRef,
  OnInit,
  Renderer2,
  HostListener,
  OnDestroy,
} from '@angular/core';

import { ROUTES } from './sidebar-items';

import { RouteInfo } from './sidebar.metadata';



@Component({

  selector: 'app-sidebar',

  templateUrl: './sidebar.component.html',

  styleUrls: ['./sidebar.component.scss'],

})

export class SidebarComponent implements OnInit, OnDestroy {

  public sidebarItems!: RouteInfo[];

  public innerHeight?: number;

  public bodyTag!: HTMLElement;

  listMaxHeight?: number;

  headerHeight = 60;

  routerObj;

  activeUrl = '';

  private expandedMenuTitles = new Set<string>();

  constructor(
    @Inject(DOCUMENT) private document: Document,
    private renderer: Renderer2,
    public elementRef: ElementRef,
    private router: Router,
    private cdr: ChangeDetectorRef
  ) {
    this.activeUrl = this.normalizeUrl(this.router.url);

    this.routerObj = this.router.events.subscribe((event) => {
      if (event instanceof NavigationEnd) {
        this.activeUrl = this.normalizeUrl(event.urlAfterRedirects);
        this.syncExpandedMenus();
        this.renderer.removeClass(this.document.body, 'overlay-open');
        this.cdr.markForCheck();
      }
    });
  }

  @HostListener('window:resize', ['$event'])

  windowResizecall() {

    this.setMenuHeight();

    this.checkStatuForResize(false);

  }

  @HostListener('document:mousedown', ['$event'])

  onGlobalClick(event: Event): void {

    if (!this.elementRef.nativeElement.contains(event.target)) {

      this.renderer.removeClass(this.document.body, 'overlay-open');

    }

  }



  ngOnInit() {
    this.sidebarItems = ROUTES;
    this.syncExpandedMenus();
    this.initLeftSidebar();
    this.bodyTag = this.document.body;
  }

  ngOnDestroy() {

    this.routerObj.unsubscribe();

  }

  initLeftSidebar() {

    // eslint-disable-next-line @typescript-eslint/no-this-alias

    const _this = this;

    _this.setMenuHeight();

    _this.checkStatuForResize(true);

  }

  setMenuHeight() {

    this.innerHeight = window.innerHeight;

    this.listMaxHeight = this.innerHeight - this.headerHeight;

  }

  isOpen() {

    return this.bodyTag.classList.contains('overlay-open');

  }

  checkStatuForResize(firstTime: boolean) {

    if (window.innerWidth < 1170) {

      this.renderer.addClass(this.document.body, 'ls-closed');

    } else {

      this.renderer.removeClass(this.document.body, 'ls-closed');

    }

  }

  mouseHover() {

    const body = this.elementRef.nativeElement.closest('body');

    if (body.classList.contains('submenu-closed')) {

      this.renderer.addClass(this.document.body, 'side-closed-hover');

      this.renderer.removeClass(this.document.body, 'submenu-closed');

    }

  }

  mouseOut() {

    const body = this.elementRef.nativeElement.closest('body');

    if (body.classList.contains('side-closed-hover')) {

      this.renderer.removeClass(this.document.body, 'side-closed-hover');

      this.renderer.addClass(this.document.body, 'submenu-closed');

    }

  }



  onMenuToggle(event: Event, sidebarItem: RouteInfo): void {
    if (sidebarItem.submenu.length > 0) {
      event.preventDefault();
      if (this.expandedMenuTitles.has(sidebarItem.title)) {
        this.expandedMenuTitles.delete(sidebarItem.title);
      } else {
        this.expandedMenuTitles.add(sidebarItem.title);
      }
    }
  }

  isParentMenuExpanded(sidebarItem: RouteInfo): boolean {
    return (
      this.expandedMenuTitles.has(sidebarItem.title) ||
      this.isParentMenuActive(sidebarItem)
    );
  }

  isParentMenuActive(sidebarItem: RouteInfo): boolean {
    if (!sidebarItem.submenu.length) {
      return this.isLinkActive(sidebarItem.path);
    }
    return sidebarItem.submenu.some((sub) => this.isLinkActive(sub.path));
  }

  isLinkActive(path: string): boolean {
    if (!path) {
      return false;
    }

    const link = this.toUrlPath(path);
    if (this.isExactRoute(path)) {
      return this.activeUrl === link;
    }

    return this.activeUrl === link || this.activeUrl.startsWith(`${link}/`);
  }

  private syncExpandedMenus(): void {
    const activeParents = new Set<string>();
    for (const item of this.sidebarItems) {
      if (item.submenu.length && this.isParentMenuActive(item)) {
        activeParents.add(item.title);
      }
    }

    for (const title of [...this.expandedMenuTitles]) {
      if (!activeParents.has(title)) {
        this.expandedMenuTitles.delete(title);
      }
    }

    for (const title of activeParents) {
      this.expandedMenuTitles.add(title);
    }
  }

  private normalizeUrl(url: string): string {
    return url.split('?')[0].split('#')[0];
  }

  private toUrlPath(path: string): string {
    return `/${path.split('/').filter(Boolean).join('/')}`;
  }



  getRouterLink(path: string): string[] {

    if (!path) {

      return ['/assigned-documents'];

    }



    return ['/', ...path.split('/').filter(Boolean)];

  }



  isExactRoute(path: string): boolean {
    if (!path) {
      return false;
    }

    const paths = ROUTES.map((item) => item.path).filter(Boolean);
    const hasChildPath = paths.some(
      (itemPath) => itemPath !== path && itemPath.startsWith(`${path}/`)
    );

    return (
      path === 'assigned-documents' ||
      path === 'dashboard' ||
      hasChildPath ||
      path.includes('/')
    );
  }

}

