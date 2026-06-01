<?php

namespace App\Repositories\Implementation;

use App\Models\OpenAIDocuments;
use App\Repositories\Implementation\BaseRepository;
use App\Repositories\Contracts\OpenAIDocumentRepositoryInterface;
use Illuminate\Support\Facades\DB;

class OpenAIDocumentRepository extends BaseRepository implements OpenAIDocumentRepositoryInterface
{

    /**
     * @var Model
     */
    protected $model;

    public static function model()
    {
        return OpenAIDocuments::class;
    }

    public function getOpenAiDocuments($attributes)
    {


        $query = OpenAIDocuments::select([
            'openaidocuments.id',
            'openaidocuments.prompt',
            'openaidocuments.model',
            'openaidocuments.created_at',
            'openaidocuments.language',
            'openaidocuments.maximumLength',
            'openaidocuments.creativity',
            'openaidocuments.toneOfVoice'
        ]);

        $orderByArray =  explode(' ', $attributes->orderBy);
        $orderBy = $orderByArray[0];
        $direction = $orderByArray[1] ?? 'asc';

        if ($orderBy == 'prompt') {
            $query = $query->orderBy('openaidocuments.prompt', $direction);
        } else if ($orderBy == 'model') {
            $query = $query->orderBy('openaidocuments.model', $direction);
        } else if ($orderBy == 'language') {
            $query = $query->orderBy('openaidocuments.language', $direction);
        } else if ($orderBy == 'maximumLength') {
            $query = $query->orderBy('openaidocuments.maximumLength', $direction);
        } else if ($orderBy == 'creativity') {
            $query = $query->orderBy('openaidocuments.creativity', $direction);
        } else if ($orderBy == 'toneOfVoice') {
            $query = $query->orderBy('openaidocuments.toneOfVoice', $direction);
        } else {
            $query = $query->orderBy('openaidocuments.created_at', $direction);
        }

        if ($attributes->prompt) {
            $query = $query->where('prompt',  'like', '%' . $attributes->prompt . '%');
        }

        $results = $query->skip($attributes->skip)->take($attributes->pageSize)->get();

        return $results;
    }

    public function getOpenAiDocumentsCount($attributes)
    {
        $query = OpenAIDocuments::query();

        if ($attributes->prompt) {
            $query = $query->where('prompt',  'like', '%' . $attributes->prompt . '%');
        }

        $count = $query->count();
        return $count;
    }

    public function getOpenAiDocumentsResponse($id)
    {
        $model = $this->model->findOrFail($id);
        return $model;
    }
}
