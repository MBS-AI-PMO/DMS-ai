// Sidebar route metadata
export interface RouteInfo {
  path: string;
  title: string;
  icon: string;
  class: string;
  groupTitle: boolean;
  claims: string[];
  /** Role names from `roles` table, e.g. `Super Admin`, `Employee` */
  roles?: string[];
  submenu: RouteInfo[];
}
