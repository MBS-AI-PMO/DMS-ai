<?php

namespace App\Services;

use Illuminate\Support\Facades\Storage;

class CandidateCvSearchService
{
    private const MAX_CV_TEXT_LENGTH = 50000;

    /** @var array<string, string> */
    private array $pathTextCache = [];

    public function __construct(private FileContentExtractor $extractor)
    {
    }

    /**
     * @param  array<int, array<string, mixed>>  $groups
     * @return array<int, array<string, mixed>>
     */
    public function enrichGroups(array $groups): array
    {
        foreach ($groups as $index => $group) {
            $groups[$index]['cvSearchText'] = $this->extractGroupCvText($group);
        }

        return $groups;
    }

    /**
     * @param  array<string, mixed>  $group
     */
    public function matchesQuery(array $group, string $query): bool
    {
        $haystack = $this->buildHaystack($group);
        $haystackDigits = preg_replace('/\D+/', '', $haystack) ?: '';
        $cnicDigits = preg_replace('/\D+/', '', (string) ($group['candidateCode'] ?? '')) ?: '';
        $terms = preg_split('/\s+/', strtolower(trim($query)), -1, PREG_SPLIT_NO_EMPTY);

        foreach ($terms as $term) {
            $termDigits = preg_replace('/\D+/', '', $term);
            $matched = $term !== '' && str_contains($haystack, strtolower($term));

            if (!$matched && strlen($termDigits) >= 3) {
                $matched = str_contains($haystackDigits, $termDigits)
                    || ($cnicDigits !== '' && str_contains($cnicDigits, $termDigits));
            }

            if (!$matched) {
                return false;
            }
        }

        return true;
    }

    /**
     * @param  array<int, array<string, mixed>>  $groups
     * @param  array<int, string>|null  $extraTerms
     * @return array<int, array<string, mixed>>
     */
    public function attachSearchMatches(array $groups, string $query, ?array $extraTerms = null): array
    {
        $terms = $this->resolveSearchTerms($query, $extraTerms);
        if ($terms === []) {
            return $groups;
        }

        foreach ($groups as $index => $group) {
            $groups[$index]['searchMatches'] = $this->findMatchSources($group, $terms);
        }

        return $groups;
    }

    /**
     * @param  array<int, string>|null  $extraTerms
     * @return array<int, string>
     */
    public function resolveSearchTerms(string $query, ?array $extraTerms = null): array
    {
        $terms = preg_split('/\s+/', strtolower(trim($query)), -1, PREG_SPLIT_NO_EMPTY) ?: [];

        foreach ($extraTerms ?? [] as $term) {
            $term = strtolower(trim((string) $term));
            if ($term !== '') {
                $terms[] = $term;
            }
        }

        $unique = [];
        foreach ($terms as $term) {
            if ($term !== '' && !in_array($term, $unique, true)) {
                $unique[] = $term;
            }
        }

        return $unique;
    }

    /**
     * @param  array<string, mixed>  $group
     * @param  array<int, string>  $terms
     * @return array<int, array<string, mixed>>
     */
    public function findMatchSources(array $group, array $terms): array
    {
        $matches = [];

        $profileFields = [
            'candidateName' => $group['candidateName'] ?? '',
            'candidateCode' => $group['candidateCode'] ?? '',
            'phone' => $group['phone'] ?? '',
            'email' => $group['email'] ?? '',
            'experienceYears' => (string) ($group['experienceYears'] ?? ''),
            'latestPostTitle' => $group['latestPostTitle'] ?? '',
            'latestRejectionReason' => $group['latestRejectionReason'] ?? '',
        ];

        $profileTerms = $this->matchingTerms($profileFields, $terms);
        if ($profileTerms !== []) {
            $matches[] = [
                'matchType' => 'profile',
                'label' => 'Candidate profile',
                'matchedTerms' => $profileTerms,
            ];
        }

        foreach ($group['applications'] ?? [] as $application) {
            if (empty($application['hasCv']) && empty($application['cvPath'])) {
                continue;
            }

            $applicationId = $application['id'] ?? null;
            $postTitle = (string) ($application['postTitle'] ?? 'Job application');
            $cvOriginalName = (string) ($application['cvOriginalName'] ?? 'Uploaded CV');
            $matchTypes = [];
            $matchedTerms = [];

            $postTerms = $this->matchingTerms(['postTitle' => $postTitle], $terms);
            if ($postTerms !== []) {
                $matchTypes[] = 'post_title';
                $matchedTerms = array_merge($matchedTerms, $postTerms);
            }

            $fileTerms = $this->matchingTerms(['cvOriginalName' => $cvOriginalName], $terms);
            if ($fileTerms !== []) {
                $matchTypes[] = 'cv_filename';
                $matchedTerms = array_merge($matchedTerms, $fileTerms);
            }

            $snippet = null;
            $cvPath = $application['cvPath'] ?? null;
            if (!empty($cvPath)) {
                $cvText = strtolower($this->getCvText($cvPath));
                $cvTerms = $this->matchingTerms(['cv' => $cvText], $terms);
                if ($cvTerms !== []) {
                    $matchTypes[] = 'cv_content';
                    $matchedTerms = array_merge($matchedTerms, $cvTerms);
                    $snippet = $this->extractSnippet($cvText, $cvTerms[0]);
                }
            }

            if ($matchTypes === []) {
                continue;
            }

            $matches[] = [
                'applicationId' => $applicationId,
                'postTitle' => $postTitle,
                'cvOriginalName' => $cvOriginalName,
                'matchTypes' => array_values(array_unique($matchTypes)),
                'matchedTerms' => array_values(array_unique($matchedTerms)),
                'snippet' => $snippet,
            ];
        }

        return $matches;
    }

    /**
     * @param  array<int, array<string, mixed>>  $groups
     * @return array<int, array<string, mixed>>
     */
    public function stripInternalFields(array $groups): array
    {
        return array_map(function (array $group) {
            unset($group['cvSearchText']);

            if (!empty($group['applications']) && is_array($group['applications'])) {
                $group['applications'] = array_map(function (array $application) {
                    unset($application['cvPath']);

                    return $application;
                }, $group['applications']);
            }

            return $group;
        }, $groups);
    }

    /**
     * @param  array<string, string>  $fields
     * @param  array<int, string>  $terms
     * @return array<int, string>
     */
    private function matchingTerms(array $fields, array $terms): array
    {
        $haystack = strtolower(implode(' ', array_filter($fields)));
        $haystackDigits = preg_replace('/\D+/', '', $haystack) ?: '';
        $matched = [];

        foreach ($terms as $term) {
            $termDigits = preg_replace('/\D+/', '', $term);
            $isMatch = $term !== '' && str_contains($haystack, $term);

            if (!$isMatch && strlen($termDigits) >= 3) {
                $isMatch = str_contains($haystackDigits, $termDigits);
            }

            if ($isMatch) {
                $matched[] = $term;
            }
        }

        return array_values(array_unique($matched));
    }

    private function extractSnippet(string $cvText, string $term, int $radius = 60): ?string
    {
        $position = strpos($cvText, strtolower($term));
        if ($position === false) {
            return null;
        }

        $start = max(0, $position - $radius);
        $length = strlen($term) + ($radius * 2);
        $snippet = substr($cvText, $start, $length);
        $snippet = trim(preg_replace('/\s+/u', ' ', $snippet) ?? '');

        if ($start > 0) {
            $snippet = '…' . $snippet;
        }
        if ($start + $length < strlen($cvText)) {
            $snippet .= '…';
        }

        return $snippet;
    }

    /**
     * @param  array<string, mixed>  $group
     */
    public function buildHaystack(array $group): string
    {
        $stageLabels = [
            'cv_received' => 'CV Received',
            'shortlisted' => 'Shortlisted',
            'interview_scheduled' => 'Interview Scheduled',
            'approved' => 'Approved',
            'rejected' => 'Rejected',
            'selected' => 'Selected',
        ];

        $parts = [
            $group['candidateName'] ?? '',
            $group['candidateCode'] ?? '',
            $group['phone'] ?? '',
            $group['email'] ?? '',
            $group['latestPostTitle'] ?? '',
            $group['cvOriginalName'] ?? '',
            $group['latestRejectionReason'] ?? '',
            (string) ($group['experienceYears'] ?? ''),
            $stageLabels[$group['latestStage'] ?? ''] ?? ($group['latestStage'] ?? ''),
            $group['latestStage'] ?? '',
            $group['cvSearchText'] ?? '',
        ];

        $cnicDigits = preg_replace('/\D+/', '', $group['candidateCode'] ?? '');
        if ($cnicDigits !== '') {
            $parts[] = $cnicDigits;
        }

        foreach ($group['applications'] ?? [] as $application) {
            $parts[] = $application['postTitle'] ?? '';
            $parts[] = $application['stage'] ?? '';
            $parts[] = $application['interviewer'] ?? '';
            $parts[] = $application['cvOriginalName'] ?? '';
            $parts[] = $application['rejectionReason'] ?? '';
            $parts[] = $stageLabels[$application['stage'] ?? ''] ?? ($application['stage'] ?? '');
        }

        if (empty($group['cvSearchText'])) {
            $parts[] = $this->extractGroupCvText($group);
        }

        return strtolower(implode(' ', array_filter($parts, fn ($part) => $part !== '' && $part !== null)));
    }

    /**
     * @param  array<string, mixed>  $group
     */
    private function extractGroupCvText(array $group): string
    {
        $chunks = [];

        foreach ($this->collectCvPaths($group) as $path) {
            $text = $this->getCvText($path);
            if ($text !== '') {
                $chunks[] = $text;
            }
        }

        return implode(' ', $chunks);
    }

    /**
     * @param  array<string, mixed>  $group
     * @return array<int, string>
     */
    private function collectCvPaths(array $group): array
    {
        $paths = [];

        foreach ($group['applications'] ?? [] as $application) {
            $path = $application['cvPath'] ?? null;
            if (!empty($path)) {
                $paths[$path] = true;
            }
        }

        return array_keys($paths);
    }

    private function getCvText(string $path): string
    {
        if (array_key_exists($path, $this->pathTextCache)) {
            return $this->pathTextCache[$path];
        }

        if (!Storage::disk('local')->exists($path)) {
            $this->pathTextCache[$path] = '';

            return '';
        }

        $extension = strtolower(pathinfo($path, PATHINFO_EXTENSION));
        if (!in_array($extension, ['txt', 'pdf', 'doc', 'docx', 'xls', 'xlsx'], true)) {
            $this->pathTextCache[$path] = '';

            return '';
        }

        $text = $this->extractor->extractContent($path, 'local');
        $text = preg_replace('/\s+/u', ' ', trim((string) $text)) ?? '';

        if (strlen($text) > self::MAX_CV_TEXT_LENGTH) {
            $text = substr($text, 0, self::MAX_CV_TEXT_LENGTH);
        }

        $this->pathTextCache[$path] = $text;

        return $text;
    }
}
