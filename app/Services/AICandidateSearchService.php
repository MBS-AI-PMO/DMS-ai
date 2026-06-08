<?php

namespace App\Services;

use Gemini\Laravel\Facades\Gemini;
use Illuminate\Support\Facades\Log;
use OpenAI;

class AICandidateSearchService
{
    private const DEFAULT_GEMINI_MODEL = 'gemini-2.5-flash-lite';

    private const DEFAULT_OPENAI_MODEL = 'gpt-4o-mini';

    public function __construct(private CandidateCvSearchService $cvSearchService)
    {
    }

    /**
     * @param  array<int, array<string, mixed>>  $candidates
     * @return array{
     *     candidates: array<int, array<string, mixed>>,
     *     interpretation: ?string,
     *     usedAi: bool,
     *     searchTerms: array<int, string>
     * }
     */
    public function search(string $query, array $candidates): array
    {
        $query = trim($query);
        if ($query === '') {
            return [
                'candidates' => $candidates,
                'interpretation' => null,
                'usedAi' => false,
                'searchTerms' => [],
            ];
        }

        $criteria = $this->parseQueryWithAi($query);
        if ($criteria === null) {
            return [
                'candidates' => $this->filterByText($query, $candidates),
                'interpretation' => null,
                'usedAi' => false,
                'searchTerms' => $this->cvSearchService->resolveSearchTerms($query),
            ];
        }

        $filtered = $this->applyCriteria($criteria, $candidates, $query);

        return [
            'candidates' => $filtered,
            'interpretation' => $criteria['interpretation'] ?? null,
            'usedAi' => true,
            'searchTerms' => $this->buildSearchTermsFromCriteria($query, $criteria),
        ];
    }

    /**
     * @param  array<string, mixed>  $criteria
     * @return array<int, string>
     */
    public function buildSearchTermsFromCriteria(string $query, array $criteria): array
    {
        $extraTerms = array_merge(
            $criteria['keywords'] ?? [],
            $criteria['nameKeywords'] ?? [],
            $criteria['postTitleKeywords'] ?? []
        );

        return $this->cvSearchService->resolveSearchTerms($query, $extraTerms);
    }

    /**
     * @param  array<int, array<string, mixed>>  $candidates
     * @return array<int, array<string, mixed>>
     */
    private function filterByText(string $query, array $candidates): array
    {
        return array_values(array_filter(
            $candidates,
            fn (array $group) => $this->matchesText($group, $query)
        ));
    }

    /**
     * @param  array<string, mixed>  $group
     */
    private function matchesText(array $group, string $query): bool
    {
        return $this->cvSearchService->matchesQuery($group, $query);
    }

    /**
     * @param  array<string, mixed>  $criteria
     * @param  array<int, array<string, mixed>>  $candidates
     * @return array<int, array<string, mixed>>
     */
    private function applyCriteria(array $criteria, array $candidates, string $originalQuery): array
    {
        $hasStructuredFilters = $this->hasStructuredFilters($criteria);

        if (!$hasStructuredFilters) {
            return $this->filterByText($originalQuery, $candidates);
        }

        return array_values(array_filter(
            $candidates,
            fn (array $group) => $this->candidateMatchesCriteria($group, $criteria, $originalQuery)
        ));
    }

    /**
     * @param  array<string, mixed>  $criteria
     */
    private function hasStructuredFilters(array $criteria): bool
    {
        if (!empty($criteria['rejectedOnly'])) {
            return true;
        }
        if (!empty($criteria['stages'])) {
            return true;
        }
        if (!empty($criteria['keywords'])) {
            return true;
        }
        if (!empty($criteria['nameKeywords'])) {
            return true;
        }
        if (!empty($criteria['postTitleKeywords'])) {
            return true;
        }
        if (isset($criteria['minExperienceYears']) && $criteria['minExperienceYears'] !== null) {
            return true;
        }
        if (isset($criteria['maxExperienceYears']) && $criteria['maxExperienceYears'] !== null) {
            return true;
        }
        if (isset($criteria['minApplicationCount']) && $criteria['minApplicationCount'] !== null) {
            return true;
        }

        return false;
    }

    /**
     * @param  array<string, mixed>  $group
     * @param  array<string, mixed>  $criteria
     */
    private function candidateMatchesCriteria(array $group, array $criteria, string $originalQuery): bool
    {
        if (!empty($criteria['rejectedOnly']) && !$this->candidateHasStage($group, 'rejected')) {
            return false;
        }

        if (!empty($criteria['stages']) && !$this->candidateMatchesAnyStage($group, $criteria['stages'])) {
            return false;
        }

        if (isset($criteria['minExperienceYears']) && $criteria['minExperienceYears'] !== null) {
            $experience = $group['experienceYears'] ?? null;
            if ($experience === null || (int) $experience < (int) $criteria['minExperienceYears']) {
                return false;
            }
        }

        if (isset($criteria['maxExperienceYears']) && $criteria['maxExperienceYears'] !== null) {
            $experience = $group['experienceYears'] ?? null;
            if ($experience === null || (int) $experience > (int) $criteria['maxExperienceYears']) {
                return false;
            }
        }

        if (isset($criteria['minApplicationCount']) && $criteria['minApplicationCount'] !== null) {
            if ((int) ($group['applicationCount'] ?? 0) < (int) $criteria['minApplicationCount']) {
                return false;
            }
        }

        foreach ($criteria['nameKeywords'] ?? [] as $keyword) {
            if (!$this->containsKeyword($group['candidateName'] ?? '', $keyword)) {
                return false;
            }
        }

        foreach ($criteria['postTitleKeywords'] ?? [] as $keyword) {
            if (!$this->groupPostTitlesContain($group, $keyword)) {
                return false;
            }
        }

        foreach ($criteria['keywords'] ?? [] as $keyword) {
            if (!$this->matchesText($group, (string) $keyword)) {
                return false;
            }
        }

        if (
            empty($criteria['keywords'])
            && empty($criteria['nameKeywords'])
            && empty($criteria['postTitleKeywords'])
            && empty($criteria['stages'])
            && empty($criteria['rejectedOnly'])
        ) {
            return $this->matchesText($group, $originalQuery);
        }

        return true;
    }

    /**
     * @param  array<string, mixed>  $group
     * @param  array<int, string>  $stages
     */
    private function candidateMatchesAnyStage(array $group, array $stages): bool
    {
        $normalizedStages = array_map('strtolower', array_filter($stages));
        if (!$normalizedStages) {
            return true;
        }

        if (in_array(strtolower((string) ($group['latestStage'] ?? '')), $normalizedStages, true)) {
            return true;
        }

        foreach ($group['applications'] ?? [] as $application) {
            if (in_array(strtolower((string) ($application['stage'] ?? '')), $normalizedStages, true)) {
                return true;
            }
        }

        return false;
    }

    /**
     * @param  array<string, mixed>  $group
     */
    private function candidateHasStage(array $group, string $stage): bool
    {
        return $this->candidateMatchesAnyStage($group, [$stage]);
    }

    /**
     * @param  array<string, mixed>  $group
     */
    private function groupPostTitlesContain(array $group, string $keyword): bool
    {
        $keyword = strtolower(trim($keyword));
        if ($keyword === '') {
            return true;
        }

        if ($this->containsKeyword($group['latestPostTitle'] ?? '', $keyword)) {
            return true;
        }

        foreach ($group['applications'] ?? [] as $application) {
            if ($this->containsKeyword($application['postTitle'] ?? '', $keyword)) {
                return true;
            }
        }

        return false;
    }

    private function containsKeyword(string $value, string $keyword): bool
    {
        $keyword = strtolower(trim($keyword));
        if ($keyword === '') {
            return true;
        }

        return str_contains(strtolower($value), $keyword);
    }

    private function parseQueryWithAi(string $query): ?array
    {
        $prompt = $this->buildParserPrompt($query);

        try {
            if (env('GEMINI_API_KEY')) {
                $response = Gemini::generativeModel(model: self::DEFAULT_GEMINI_MODEL)
                    ->generateContent($prompt);

                return $this->normalizeCriteria($this->extractJson($response->text() ?? ''));
            }

            if (env('OPENAI_API_KEY')) {
                $openai = OpenAI::factory()
                    ->withApiKey(env('OPENAI_API_KEY'))
                    ->withHttpClient(new \GuzzleHttp\Client(['verify' => false]))
                    ->make();

                $response = $openai->chat()->create([
                    'model' => self::DEFAULT_OPENAI_MODEL,
                    'response_format' => ['type' => 'json_object'],
                    'messages' => [
                        [
                            'role' => 'system',
                            'content' => 'You convert recruiter search requests into JSON filters. Return JSON only.',
                        ],
                        [
                            'role' => 'user',
                            'content' => $prompt,
                        ],
                    ],
                ]);

                return $this->normalizeCriteria(
                    $this->extractJson($response->choices[0]->message->content ?? '')
                );
            }
        } catch (\Throwable $th) {
            Log::warning('AI candidate search parse failed: ' . $th->getMessage());
        }

        return null;
    }

    private function buildParserPrompt(string $query): string
    {
        return <<<PROMPT
You help recruiters search job candidates using natural language (English, Urdu, Roman Urdu).
Return ONLY valid JSON. No markdown.

User query: "{$query}"

JSON schema:
{
  "keywords": ["general words to match anywhere"],
  "nameKeywords": ["candidate name fragments"],
  "postTitleKeywords": ["job/post title fragments"],
  "stages": ["cv_received|shortlisted|interview_scheduled|approved|rejected|selected"],
  "minExperienceYears": number|null,
  "maxExperienceYears": number|null,
  "minApplicationCount": number|null,
  "rejectedOnly": boolean,
  "interpretation": "short explanation of what you searched for"
}

Rules:
- Understand Urdu/Roman Urdu like "3 saal experience", "reject hue", "developer post", "shortlisted candidates".
- Map status words to stages: rejected/reject/nakala -> rejected, shortlisted/select -> shortlisted, interview -> interview_scheduled.
- If user asks for a post/job role, put it in postTitleKeywords.
- If user asks for a person name, put it in nameKeywords.
- Skills, tools, degrees, certifications, or phrases likely inside a CV/resume (e.g. Laravel, React, MBA, PMP) go in keywords — search also scans PDF/Word CV content.
- Use keywords only for extra terms not covered by other fields.
- If query is very broad, still extract the best filters you can.
PROMPT;
    }

    private function extractJson(?string $text): ?array
    {
        if ($text === null || trim($text) === '') {
            return null;
        }

        $text = trim($text);
        if (preg_match('/```(?:json)?\s*(.*?)\s*```/s', $text, $matches)) {
            $text = trim($matches[1]);
        }

        $decoded = json_decode($text, true);

        return is_array($decoded) ? $decoded : null;
    }

    /**
     * @param  array<string, mixed>|null  $criteria
     * @return array<string, mixed>|null
     */
    private function normalizeCriteria(?array $criteria): ?array
    {
        if ($criteria === null) {
            return null;
        }

        $listFields = ['keywords', 'nameKeywords', 'postTitleKeywords', 'stages'];
        foreach ($listFields as $field) {
            $values = $criteria[$field] ?? [];
            if (!is_array($values)) {
                $values = $values !== null && $values !== '' ? [(string) $values] : [];
            }
            $criteria[$field] = array_values(array_filter(array_map(
                fn ($value) => trim((string) $value),
                $values
            )));
        }

        foreach (['minExperienceYears', 'maxExperienceYears', 'minApplicationCount'] as $field) {
            if (!array_key_exists($field, $criteria) || $criteria[$field] === '' || $criteria[$field] === null) {
                $criteria[$field] = null;
                continue;
            }
            $criteria[$field] = is_numeric($criteria[$field]) ? (int) $criteria[$field] : null;
        }

        $criteria['rejectedOnly'] = !empty($criteria['rejectedOnly']);
        $criteria['interpretation'] = isset($criteria['interpretation'])
            ? trim((string) $criteria['interpretation'])
            : null;

        return $criteria;
    }
}
