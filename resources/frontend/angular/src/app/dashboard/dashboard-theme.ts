import { ScaleType } from '@swimlane/ngx-charts';

export const DASHBOARD_COLOR_SCHEME = {
  name: 'dmsTheme',
  selectable: true,
  group: ScaleType.Ordinal,
  domain: [
    '#6777ef',
    '#7b8af0',
    '#8f9bf3',
    '#a3acf6',
    '#5f6ed8',
    '#5363c4',
    '#4758b0',
    '#3b4d9c',
    '#2c303b',
    '#96a3f8',
  ],
};

export const DASHBOARD_THEME = {
  primary: '#6777ef',
  primaryLight: '#eef0fd',
  primaryDark: '#5363c4',
  dark: '#2c303b',
  surface: '#ffffff',
  border: '#e8eaef',
  muted: '#6c757d',
};
