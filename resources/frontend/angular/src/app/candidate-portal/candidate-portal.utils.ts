export function formatPortalDate(value?: string | null): string {
  if (!value || value === 'null') {
    return '—';
  }
  const parsed = new Date(value);
  if (isNaN(parsed.getTime())) {
    return '—';
  }
  return parsed.toLocaleString(undefined, {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  });
}

export function stageBadgeClass(stage: string): string {
  const map: Record<string, string> = {
    cv_received: 'cp-badge--muted',
    shortlisted: 'cp-badge--info',
    interview_scheduled: 'cp-badge--primary',
    approved: 'cp-badge--success',
    rejected: 'cp-badge--danger',
    selected: 'cp-badge--success',
  };
  return map[stage] ?? 'cp-badge--muted';
}
