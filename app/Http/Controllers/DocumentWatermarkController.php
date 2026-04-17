<?php

namespace App\Http\Controllers;

use App\Models\DocumentAuditTrails;
use App\Models\DocumentOperationEnum;
use Illuminate\Http\Request;
use App\Models\Documents;
use App\Models\DocumentVersions;
use Illuminate\Support\Facades\Storage;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use App\Services\PdfWatermarkService;

class DocumentWatermarkController extends Controller
{

    public function watermarkDocument(Request $request)
    {
        try {
            $request->validate([
                'documentId' => 'required|uuid',
                'watermarkText' => 'required|string'
            ]);

            $document = Documents::findOrFail($request->documentId);
            $extension = pathinfo($document->url, PATHINFO_EXTENSION);

            if (strtolower($extension) != 'pdf') {
                return response()->json([
                    'message' => 'Watermarking is only supported for PDF documents.',
                ], 409);
            }

            if ($document->location == 's3') {
                $s3Key = config('filesystems.disks.s3.key');
                $s3Secret = config('filesystems.disks.s3.secret');
                $s3Region = config('filesystems.disks.s3.region');
                $s3Bucket = config('filesystems.disks.s3.bucket');

                if (empty($s3Key) || empty($s3Secret) || empty($s3Region) || empty($s3Bucket)) {
                    return response()->json([
                        'message' => 'Error: S3 configuration is missing',
                    ], 409);
                }
            }

            $userId = Auth::parseToken()->getPayload()->get('userId');

            // Get the PDF file content from the correct storage
            if ($document->location == 's3') {
                $pdfContent = Storage::disk('s3')->get($document->url);
                // Store temporarily for FPDI
                $tmpPdfPath = storage_path('app' . DIRECTORY_SEPARATOR . 'temp' . DIRECTORY_SEPARATOR . 'tmp_' . uniqid() . '.pdf');
                file_put_contents($tmpPdfPath, $pdfContent);
                $pdfPath = $tmpPdfPath;
            } else {
                $pdfPath = Storage::disk($document->location)->path($document->url);
            }

            $newFileName = Str::uuid() . '.pdf';
            $newFileRelativePath = 'documents' . DIRECTORY_SEPARATOR . $newFileName;

            $pdfService = new PdfWatermarkService();
            if ($document->location == 's3') {
                // Save to temp file, then upload to S3
                $tmpWatermarkPdfPath = storage_path('app' . DIRECTORY_SEPARATOR . 'temp' . DIRECTORY_SEPARATOR . $newFileRelativePath);
                $pdfService->addWatermark($pdfPath, $tmpWatermarkPdfPath, $request->watermarkText);
                $WatermarkPdfContent = file_get_contents($tmpWatermarkPdfPath);
                Storage::disk('s3')->put(str_replace(DIRECTORY_SEPARATOR, '/', $newFileRelativePath), $WatermarkPdfContent);
                // Clean up temp files
                @unlink($tmpWatermarkPdfPath);
                @unlink($tmpPdfPath); // remove the temp original
            } else {
                $outputPath = storage_path('app' . DIRECTORY_SEPARATOR . $newFileRelativePath);;
                $pdfService->addWatermark($pdfPath, $outputPath, $request->watermarkText);
            }

            // Save document version
            $model = DocumentVersions::create([
                'url' => $document->url,
                'documentId' => $document->id,
                'createdBy' => $document->createdBy,
                'modifiedBy' => $document->modifiedBy,
                'location' => $document->location,
                'signById' => $document->signById,
                'signDate' => $document->signDate
            ]);

            $model->createdDate = $document->createdDate;
            $model->modifiedDate = $document->modifiedDate;
            $model->save();

            $document->url = $newFileRelativePath;
            $document->createdDate = Carbon::now()->addSeconds(2);
            $document->modifiedDate = Carbon::now()->addSeconds(2);
            $document->createdBy = $userId;
            $document->save();

            DocumentAuditTrails::create([
                'documentId' => $document->id,
                'createdDate' =>  Carbon::now(),
                'operationName' => DocumentOperationEnum::Added_Watermark->value,
            ]);

            return response()->json([], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Signing failed: ' . $e->getMessage(),
            ], 500);
        }
    }
}
