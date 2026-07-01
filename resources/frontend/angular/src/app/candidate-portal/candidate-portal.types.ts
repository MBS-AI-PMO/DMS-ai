export interface CandidatePortalSummary {
  totalApplications: number;
  cvReceived: number;
  shortlisted: number;
  interviewScheduled: number;
  approved: number;
  rejected: number;
  selected: number;
}

export interface CandidateApplication {
  id: string;
  postId: string;
  postTitle: string;
  department?: string | null;
  category?: string | null;
  stage: string;
  stageLabel: string;
  experienceYears?: number | null;
  workMode?: string | null;
  hasCv: boolean;
  cvOriginalName?: string | null;
  createdDate?: string | null;
  modifiedDate?: string | null;
  interviewDate?: string | null;
  interviewer?: string | null;
  postDescription?: string | null;
}

export interface CandidateDashboardResponse {
  summary: CandidatePortalSummary;
  recentApplications: CandidateApplication[];
}

export interface CandidateProfile {
  userId: string;
  candidateName: string;
  userName: string;
  candidateCode: string;
  email: string;
  phone?: string | null;
  experienceYears?: number | null;
  workMode?: string | null;
  address?: string | null;
  preferredCategory?: string | null;
}

export interface CandidateVaultCv {
  id: string;
  cvOriginalName?: string | null;
  createdDate?: string | null;
}

export interface CandidateVaultResponse {
  items: CandidateVaultCv[];
  maxCvs: number;
  cvRetentionDays: number;
}

export interface RecommendedJob {
  id: string;
  title: string;
  department?: string | null;
  category?: string | null;
  experienceYears?: number | null;
  workMode?: string | null;
  address?: string | null;
  createdDate?: string | null;
  applyUrl: string;
}

export interface CandidateHistoryResponse {
  candidateName: string;
  candidateCode: string;
  email: string;
  applications: CandidateApplication[];
}
