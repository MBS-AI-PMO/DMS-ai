<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Repositories\Contracts\DocumentWorkflowRepositoryInterface;


class DocumentWorkflowController extends Controller
{
    private $documentworkflowRepository;

    public function __construct(DocumentWorkflowRepositoryInterface $documentworkflowRepositoryInterface)
    {
        $this->documentworkflowRepository = $documentworkflowRepositoryInterface;
    }

    public function saveDocumentWorkFlow(Request $request)
    {
        return $this->documentworkflowRepository->saveDocumentWorkflow($request);
    }

    public function performNextTransition(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'documentId' => 'required|uuid',
            'documentworkflowId' => 'required|uuid',
            'transitionId' => 'required|uuid',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->messages(), 409);
        }

        return $this->documentworkflowRepository->performNextTransition($request);
    }

    public function cancelWorkflow(Request $request, $id)
    {
        return $this->documentworkflowRepository->cancelWorkflow($request, $id);
    }

    public function visualWorkflow($id)
    {
        return $this->documentworkflowRepository->visualWorkflow($id);
    }

    public function getDocumentWorkFlows(Request $request)
    {
        $queryString = (object) $request->all();

        $count = $this->documentworkflowRepository->getDocumentWorkflowCount($queryString);
        return response()->json($this->documentworkflowRepository->getDocumentWorkFlows($queryString))
            ->withHeaders(['totalCount' => $count, 'pageSize' => $queryString->pageSize, 'skip' => $queryString->skip]);
    }
}
