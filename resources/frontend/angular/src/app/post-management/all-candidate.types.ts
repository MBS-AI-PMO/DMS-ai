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
  hasCv: boolean;
  cvOriginalName?: string;
  applications: CandidateApplication[];
}

export interface AllCandidatesResponse {
  candidates: GroupedCandidate[];
}

export const CANDIDATE_STAGE_LABELS: Record<CandidateStage, string> = {
  cv_received: 'CV Received',
  shortlisted: 'Shortlisted',
  interview_scheduled: 'Interview Scheduled',
  approved: 'Approved',
  rejected: 'Rejected',
  selected: 'Selected',
};
