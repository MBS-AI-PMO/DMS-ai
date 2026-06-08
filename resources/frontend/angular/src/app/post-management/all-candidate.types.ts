export type CandidateStage = 'cv_received' | 'shortlisted' | 'interview_scheduled' | 'approved' | 'rejected' | 'selected';

export interface CandidateApplication {
  id: string;
  postId: string;
  postTitle: string;
  stage: CandidateStage;
  createdDate: string;
  interviewDate?: string;
  interviewer?: string | null;
  hasCv: boolean;
  cvOriginalName?: string;
  rejectionReason?: string | null;
}

export type CandidateSearchMatchType = 'profile' | 'post_title' | 'cv_filename' | 'cv_content';

export interface CandidateSearchMatch {
  applicationId?: string;
  postTitle?: string;
  cvOriginalName?: string;
  label?: string;
  matchType?: CandidateSearchMatchType;
  matchTypes?: CandidateSearchMatchType[];
  matchedTerms: string[];
  snippet?: string | null;
}

export interface GroupedCandidate {
  groupKey: string;
  candidateName: string;
  candidateCode?: string;
  phone?: string;
  email?: string;
  experienceYears?: number;
  applicationCount: number;
  latestApplicationId?: string;
  latestPostId?: string;
  latestPostTitle: string;
  latestStage: CandidateStage;
  latestAppliedDate?: string;
  latestRejectionReason?: string | null;
  hasCv: boolean;
  cvOriginalName?: string;
  applications: CandidateApplication[];
  searchMatches?: CandidateSearchMatch[];
}

export interface AllCandidatesResponse {
  candidates: GroupedCandidate[];
}

export interface AllCandidatesAiSearchResponse extends AllCandidatesResponse {
  interpretation?: string | null;
  usedAi?: boolean;
}

export const CANDIDATE_STAGE_LABELS: Record<CandidateStage, string> = {
  cv_received: 'CV Received',
  shortlisted: 'Shortlisted',
  interview_scheduled: 'Interview Scheduled',
  approved: 'Approved',
  rejected: 'Rejected',
  selected: 'Selected',
};
