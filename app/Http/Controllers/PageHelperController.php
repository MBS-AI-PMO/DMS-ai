<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Repositories\Contracts\PageHelperRepositoryInterface;

class PageHelperController extends Controller
{
    private $pagehelperRepository;

    public function __construct(PageHelperRepositoryInterface $pagehelperRepository)
    {
        $this->pagehelperRepository = $pagehelperRepository;
    }

    public function getAll()
    {
        return  response($this->pagehelperRepository->all(), 200);
    }

    public function getByCode($code)
    {
        return response($this->pagehelperRepository->getByCode($code), 200);
    }

    public function update(Request $request, $id)
    {
        return  response()->json($this->pagehelperRepository->update($request->all(), $id), 200);
    }

    public function getById($id)
    {
        return response($this->pagehelperRepository->find($id), 200);
    }
}
