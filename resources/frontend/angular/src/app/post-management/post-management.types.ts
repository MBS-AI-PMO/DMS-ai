export type WorkMode = 'remote' | 'physical';
export type QuestionLevel = 'basic' | 'intermediate' | 'expert';

export interface ProposalCandidate {
  id: string;
}

export interface ProposalCategory {
  id: string;
  name: string;
}

export interface ProposalDepartment {
  id: string;
  categoryId: string;
  categoryName?: string;
  name: string;
  basicQuestions?: string;
  intermediateQuestions?: string;
  expertQuestions?: string;
}

export interface ProposalPost {
  id: string;
  title: string;
  departmentId?: string;
  department?: string;
  category?: string;
  experienceYears?: number;
  workMode?: WorkMode;
  address?: string;
  description?: string;
  createdDate: string;
  candidates: ProposalCandidate[];
}

export interface PostBoardData {
  categories: ProposalCategory[];
  departments: ProposalDepartment[];
  posts: ProposalPost[];
}
