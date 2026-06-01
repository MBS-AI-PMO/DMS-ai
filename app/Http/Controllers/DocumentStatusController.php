<?php

namespace App\Http\Controllers;

use App\Models\DocumentStatus;
use Illuminate\Http\Request;
use App\Repositories\Contracts\DocumentStatusRepositoryInterface;

class DocumentStatusController extends Controller
{
    private $documentstatusRepository;

    public function __construct(DocumentStatusRepositoryInterface $documentstatusRepository)
    {
        $this->documentstatusRepository = $documentstatusRepository;
    }

    public function index()
    {
        return response($this->documentstatusRepository->orderBy('createdDate')->all(), 200);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'required|string'
        ]);

        $existingStatus = DocumentStatus::where('name', $request->name)
            ->where('id', '!=', $id)
            ->first();

        if ($existingStatus) {
            return response()->json([
                'messages' => ['Status name already exists.']
            ], 409);
        }
        return  $this->documentstatusRepository->updateStatus($request->all(), $id);
    }

    public function create(Request $request)
    {
        $request->validate([
            'name' => 'required|string'
        ]);

        $existingStatus = DocumentStatus::where('name', $request->name)->first();

        if ($existingStatus) {
            return response()->json([
                'messages' => ['Status name already exists.']
            ], 409);
        }

        return  response($this->documentstatusRepository->create($request->all()), 201);
    }

    public function get($id)
    {
        $fileRequest = $this->documentstatusRepository->find($id);
        return response($fileRequest, 201);
    }

    public function delete($id)
    {
        $isDeleted = $this->documentstatusRepository->deleteStatus($id);
        if ($isDeleted == true) {
            return response()->json([], 200);
        } else {
            return response()->json([
                'message' => 'Status can not be deleted. Document is assign to this status.',
            ], 404);
        }
    }
}
