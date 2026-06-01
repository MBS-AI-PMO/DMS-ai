<?php

/** One-time: align all PHP table references with dms-ahi.sql (lowercase). */
$root = dirname(__DIR__);

$map = [
    'documentRolePermissions' => 'documentrolepermissions',
    'documentUserPermissions' => 'documentuserpermissions',
    'documentAuditTrails' => 'documentaudittrails',
    'documentShareableLink' => 'documentshareablelink',
    'documentMetaDatas' => 'documentmetadatas',
    'documentSignatures' => 'documentsignatures',
    'documentWorkflow' => 'documentworkflow',
    'documentComments' => 'documentcomments',
    'documentVersions' => 'documentversions',
    'documentStatus' => 'documentstatus',
    'documentTokens' => 'documenttokens',
    'workflowTransitionUsers' => 'workflowtransitionusers',
    'workflowTransitionRoles' => 'workflowtransitionroles',
    'workflowTransitions' => 'workflowtransitions',
    'halfYearlyReminders' => 'halfyearlyreminders',
    'quarterlyReminders' => 'quarterlyreminders',
    'reminderNotifications' => 'remindernotifications',
    'reminderSchedulers' => 'reminderschedulers',
    'fileRequestDocuments' => 'filerequestdocuments',
    'emailLogAttachments' => 'emaillogattachments',
    'allowFileExtensions' => 'allowfileextensions',
    'aiPromptTemplates' => 'aiprompttemplates',
    'openaiDocuments' => 'openaidocuments',
    'userNotifications' => 'usernotifications',
    'emailSMTPSettings' => 'emailsmtpsettings',
    'proposalFileRequests' => 'proposalfilerequests',
    'proposalCandidates' => 'proposalcandidates',
    'proposalFolders' => 'proposalfolders',
    'dailyReminders' => 'dailyreminders',
    'reminderUsers' => 'reminderusers',
    'workflowSteps' => 'workflowsteps',
    'workflowLogs' => 'workflowlogs',
    'companyProfile' => 'companyprofile',
    'cronJobLogs' => 'cronjoblogs',
    'pageHelper' => 'pagehelper',
    'sendEmails' => 'sendemails',
    'emailLogs' => 'emaillogs',
    'fileRequests' => 'filerequests',
    'proposalFiles' => 'proposalfiles',
    'proposalPosts' => 'proposalposts',
    'loginAudits' => 'loginaudits',
    'userRoles' => 'userroles',
    'userClaims' => 'userclaims',
    'roleClaims' => 'roleclaims',
];

uksort($map, fn ($a, $b) => strlen($b) - strlen($a));

$dirs = [$root . '/app', $root . '/database/migrations', $root . '/routes'];
$count = 0;

foreach ($dirs as $dir) {
    if (!is_dir($dir)) {
        continue;
    }
    $it = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($dir));
    foreach ($it as $file) {
        if (!$file->isFile() || $file->getExtension() !== 'php') {
            continue;
        }
        $path = $file->getPathname();
        if (strpos($path, 'fix_all_table_names') !== false || strpos($path, 'sync_tables') !== false) {
            continue;
        }
        $content = file_get_contents($path);
        $orig = $content;
        foreach ($map as $from => $to) {
            $content = str_replace($from, $to, $content);
        }
        if ($content !== $orig) {
            file_put_contents($path, $content);
            $count++;
            echo basename($path) . "\n";
        }
    }
}

echo "Updated $count files.\n";
