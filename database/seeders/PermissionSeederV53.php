<?php

namespace Database\Seeders;

use App\Models\Actions;
use App\Models\PageHelper;
use App\Models\RoleClaims;
use Illuminate\Support\Str;
use App\Models\Users;

class PermissionSeederV53 extends BaseSeeder
{
    public function run()
    {
        $this->runOnce(function () {
            $systemUser = Users::withoutGlobalScope('isSystemUser')->where('isSystemUser', true)->first();

            $actionsToAdd = [
                ['id' => '78d881d1-1da5-42d9-a97b-a6ad71e27ebc', 'createdBy' => $systemUser->id, 'modifiedBy' => $systemUser->id, 'name' => 'Add Watermark', 'order' => 15, 'pageId' => 'eddf9e8e-0c70-4cde-b5f9-117a879747d6', 'code' =>  'ALL_DOC_WATERMARK'],
                ['id' => 'ef979f76-027c-4b20-9330-5c81a3dc5869', 'createdBy' => $systemUser->id, 'modifiedBy' => $systemUser->id, 'name' => 'Add Watermark', 'order' => 15, 'pageId' => 'fc97dc8f-b4da-46b1-a179-ab206d8b7efd', 'code' =>  'ASSIGNED_DOC_WATERMARK'],
            ];

            $roleClaims = [
                ['id' => Str::uuid(36), 'actionId' => '78d881d1-1da5-42d9-a97b-a6ad71e27ebc', 'roleId' => 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'claimType' => 'ALL_DOC_WATERMARK', 'claimValue' => ''],
                ['id' => Str::uuid(36), 'actionId' => 'ef979f76-027c-4b20-9330-5c81a3dc5869', 'roleId' => 'f8b6ace9-a625-4397-bdf8-f34060dbd8e4', 'claimType' => 'ASSIGNED_DOC_WATERMARK', 'claimValue' => ''],
            ];

            Actions::insert($actionsToAdd);
            RoleClaims::insert($roleClaims);

            PageHelper::create([
                'id' => '177be1a1-6718-4407-8997-0bcee3196ffe',
                'code' => 'WATERMARK_DOCUMENT',
                'name' =>
                'Add Watermark',
                'description' => '<h2><strong>Document Watermark</strong></h2><p>The Document Watermark feature allows users to protect and brand their documents by automatically applying text-based watermarks to PDF files. This ensures content security, prevents unauthorized use, and maintains a clear document history with versioning and audit tracking.</p><h2><strong>How It Works</strong></h2><h3><strong>1. Adding a Watermark</strong></h3><p>Users can open any document and click on the <strong>"Add Watermark"</strong> option.</p><p>A popup window appears, allowing the user to:</p><ul><li>Enter the desired watermark text (e.g., <i>“Confidential”</i>, <i>“Draft”</i>, <i>“Approved by John Doe”</i>, etc.).</li></ul><h3><strong>2. Automatic PDF Processing</strong></h3><p>Once the user confirms:</p><ul><li>The system automatically applies the watermark to the PDF file.</li><li>The watermark appears diagonally or in the chosen position across all pages.</li><li>A <strong>new version</strong> of the document is generated with the applied watermark.</li></ul><h3><strong>3. Audit &amp; Version Control</strong></h3><p>Every watermark action is logged in the system:</p><ul><li>Who added the watermark</li><li>The watermark text used</li><li>Date and time of the action</li><li>Version created after watermarking</li></ul><p>This ensures full traceability and compliance for document workflows.</p><h2><strong>Key Features</strong></h2><h3><strong>Easy and Intuitive</strong></h3><p>The popup interface makes it simple for users to enter watermark text and preview watermark options.</p><h3><strong>Automatic Placement</strong></h3><p>The system positions the watermark professionally across the PDF without requiring manual alignment.</p><h3><strong>Versioning Support</strong></h3><p>Each watermarked PDF is stored as a new version of the document, preserving the original and maintaining a history of all updates.</p><h3><strong>Audit Trail</strong></h3><p>Detailed logs capture all watermark activities for transparency and compliance.</p><h3><strong>Branding &amp; Security</strong></h3><p>Watermarks help prevent unauthorized distribution and clearly identify a document’s status or ownership.</p><h2><strong>Benefits</strong></h2><h3><strong>Improved Document Security</strong></h3><p>Watermarks discourage misuse, copying, and sharing of sensitive documents.</p><h3><strong>Professional Output</strong></h3><p>Automatically formatted watermarks make documents look clean, consistent, and ready for internal or external use.</p><h3><strong>Clear Document History</strong></h3><p>Versioning and audit logs ensure teams always know <strong>what was changed</strong>, <strong>when</strong>, and <strong>by whom</strong>.</p>'
            ]);
        });
    }
}
