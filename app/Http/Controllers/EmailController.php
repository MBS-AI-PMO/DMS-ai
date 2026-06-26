<?php

namespace App\Http\Controllers;

use App\Models\Documents;
use App\Models\EmailSMTPSettings;
use App\Models\SendEmails;
use App\Repositories\Contracts\EmailRepositoryInterface;
use App\Repositories\Contracts\SendEmailRepositoryInterface;
use App\Repositories\Exceptions\RepositoryException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class EmailController extends Controller
{
    private $sendEmailRepository;
    private $emailRepository;

    public function __construct(
        SendEmailRepositoryInterface $sendEmailRepository,
        EmailRepositoryInterface $emailRepository
    ) {
        $this->sendEmailRepository = $sendEmailRepository;
        $this->emailRepository = $emailRepository;
    }

    public function sendEmail(Request $request)
    {
        $defaultSMTP = EmailSMTPSettings::where('isDefault', 1)->first();
        if ($defaultSMTP == null) {
            return response()->json([
                'status' => 'Error',
                'message' => 'Default SMTP configuration does not exist.',
            ], 422);
        }

        $email = Auth::parseToken()->getPayload()->get('email');

        if ($email == null) {
            throw new RepositoryException('Email does not exist.');
        }

        $request['fromEmail'] = $defaultSMTP->userName;
        $request['isSend'] = false;

        /** @var SendEmails $sendEmailRecord */
        $sendEmailRecord = $this->sendEmailRepository->create($request->all());

        try {
            $this->emailRepository->sendEmail(
                $this->buildSendEmailPayload($sendEmailRecord)
            );

            $sendEmailRecord->isSend = true;
            $sendEmailRecord->save();

            return response($sendEmailRecord, 201);
        } catch (\Throwable $e) {
            return response()->json([
                'message' => $e->getMessage() ?: 'Failed to send email. Please check SMTP settings.',
            ], 409);
        }
    }

    private function buildSendEmailPayload(SendEmails $sendEmail): array
    {
        $payload = [
            'to_address' => $sendEmail->email,
            'subject' => $sendEmail->subject,
            'message' => $sendEmail->message,
            'path' => null,
            'location' => null,
            'doc_url' => null,
            'file_name' => null,
        ];

        if (empty($sendEmail->documentId)) {
            return $payload;
        }

        $document = Documents::where('id', $sendEmail->documentId)->first();
        if (!$document || empty($document->url)) {
            return $payload;
        }

        $fileupload = $document->url;
        $location = $document->location ?? 'local';

        if (!Storage::disk($location)->exists($fileupload)) {
            return $payload;
        }

        $filename = pathinfo($document->name, PATHINFO_FILENAME);
        $ext = pathinfo($document->url, PATHINFO_EXTENSION);

        $payload['path'] = Storage::path($fileupload);
        $payload['mime_type'] = Storage::mimeType($fileupload);
        $payload['file_name'] = $filename . '.' . $ext;
        $payload['location'] = $location;
        $payload['doc_url'] = $document->url;

        return $payload;
    }
}
