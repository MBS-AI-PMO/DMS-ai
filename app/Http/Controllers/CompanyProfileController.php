<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Repositories\Contracts\CompanyProfileRepositoryInterface;

class CompanyProfileController extends Controller
{
    private $companyprofileRepository;

    public function __construct(CompanyProfileRepositoryInterface $companyprofileRepository)
    {
        $this->companyprofileRepository = $companyprofileRepository;
    }

    public function getCompanyProfile()
    {
        try {
            return response()->json($this->companyprofileRepository->getCompanyProfile());
        } catch (\Throwable $th) {
            return response()->json(['Message' => "Error fetching company profile: Please make sure installation has been finished successfully."], 500);
        }
    }

    public function updateCompanyProfile(Request $request)
    {
        return response()->json($this->companyprofileRepository->updateCompanyProfile($request->all()));
    }

    public function updateStorage(Request $request)
    {
        return $this->companyprofileRepository->updateStorage($request->all());
    }

    public function getStorage()
    {
        return $this->companyprofileRepository->getStorage();
    }

    public function getOpenAiKey()
    {
        return $this->companyprofileRepository->getOpenAiKey();
    }


    public function saveOpenAiKey(Request $request)
    {
        return $this->companyprofileRepository->saveOpenAiKey($request);
    }

    public function getGoogleGeminiApiKey()
    {
        return $this->companyprofileRepository->getGoogleGeminiApiKey();
    }

    public function saveGoogleGeminiApiKey(Request $request)
    {
        return $this->companyprofileRepository->saveGoogleGeminiApiKey($request);
    }

    public function updateLicense(Request $request)
    {
        return response()->json($this->companyprofileRepository->updateLicense($request));
    }

    public function updateArchiveDocumentRetension(Request $request)
    {
        return response()->json($this->companyprofileRepository->updateArchiveDocumentRetension($request));
    }

    public function updateAllowPdfSignature(Request $request)
    {
        return $this->companyprofileRepository->updateAllowPdfSignature($request->all());
    }

    public function updateEmailLogRetentionPeriod(Request $request)
    {
        return $this->companyprofileRepository->updateEmailLogRetentionPeriod($request->all());
    }

    public function updateCronJobLogRetentionPeriod(Request $request)
    {
        return $this->companyprofileRepository->updateCronJobLogRetentionPeriod($request->all());
    }

    public function updateLoginAuditRetentionPeriod(Request $request)
    {
        return $this->companyprofileRepository->updateLoginAuditRetentionPeriod($request->all());
    }
}
