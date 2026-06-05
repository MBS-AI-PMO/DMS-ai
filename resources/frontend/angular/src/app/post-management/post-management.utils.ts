import { QuestionLevel } from './post-management.types';

export function filterBySearch<T>(items: T[], query: string, getText: (item: T) => string): T[] {
  const term = query.trim().toLowerCase();
  if (!term) {
    return items;
  }
  return items.filter((item) => getText(item).toLowerCase().includes(term));
}

export function slicePage<T>(items: T[], pageIndex: number, pageSize: number): T[] {
  const start = pageIndex * pageSize;
  return items.slice(start, start + pageSize);
}

export function clampPageIndex(total: number, pageIndex: number, pageSize: number): number {
  if (total === 0) {
    return 0;
  }
  const maxPage = Math.max(0, Math.ceil(total / pageSize) - 1);
  return Math.min(pageIndex, maxPage);
}

export function formatDisplayDate(value?: string | null): string {
  if (value == null || value === '' || value === 'null') {
    return '—';
  }
  const parsed = new Date(value);
  if (isNaN(parsed.getTime())) {
    return '—';
  }
  return parsed.toLocaleDateString(undefined, { year: 'numeric', month: 'short', day: 'numeric' });
}

export function getDefaultQuestions(level: QuestionLevel): string[] {
  const defaults: Record<QuestionLevel, string[]> = {
    basic: ['Tell us about yourself.', 'Why this role?', 'Relevant skills?', 'Describe a task you completed.'],
    intermediate: ['Challenging project?', 'Prioritize tasks?', 'Problem you solved?', 'Communication style?'],
    expert: ['Complex problem end-to-end?', 'Mentoring experience?', 'Trade-offs decision?', 'Improve workflow?'],
  };
  return [...defaults[level]];
}

export function parseQuestions(value: string | undefined, level: QuestionLevel): string[] {
  const questions = (value || '')
    .split(/\r?\n/)
    .map((q) => q.trim())
    .filter((q) => q.length > 0);
  return questions.length ? questions : getDefaultQuestions(level);
}

export function serializeQuestions(questions: string[]): string {
  return questions.map((q) => q.trim()).filter((q) => q.length > 0).join('\n');
}
