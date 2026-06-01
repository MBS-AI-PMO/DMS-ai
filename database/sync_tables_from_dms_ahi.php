<?php

$root = dirname(__DIR__);
$map = require __DIR__ . '/dms_table_map.php';

// --- Models ---
$modelsDir = $root . '/app/Models';
foreach ($map as $class => $table) {
    $file = $modelsDir . '/' . $class . '.php';
    if (!is_file($file)) {
        echo "SKIP model: $class\n";
        continue;
    }
    $content = file_get_contents($file);
    if (preg_match('/protected\s+\$table\s*=\s*[\'"][^\'"]+[\'"]\s*;/', $content)) {
        $content = preg_replace(
            '/protected\s+\$table\s*=\s*[\'"][^\'"]+[\'"]\s*;/',
            "protected \$table = '$table';",
            $content,
            1
        );
    } elseif (preg_match('/public\s+\$table\s*=\s*[\'"][^\'"]+[\'"]\s*;/', $content)) {
        $content = preg_replace(
            '/public\s+\$table\s*=\s*[\'"][^\'"]+[\'"]\s*;/',
            "protected \$table = '$table';",
            $content,
            1
        );
    } else {
        $content = preg_replace(
            '/(class\s+' . preg_quote($class, '/') . '\s+extends\s+\w+\s*\{)/',
            "$1\n    protected \$table = '$table';",
            $content,
            1
        );
    }
    file_put_contents($file, $content);
    echo "OK model: $class => $table\n";
}

// --- Migrations: camelCase Schema::create -> lowercase from dump ---
$camelToLower = [
    'userRoles' => 'userroles',
    'userClaims' => 'userclaims',
    'roleClaims' => 'roleclaims',
    'loginAudits' => 'loginaudits',
    'allowFileExtensions' => 'allowfileextensions',
    'companyProfile' => 'companyprofile',
    'emailSMTPSettings' => 'emailsmtpsettings',
    'documentAuditTrails' => 'documentaudittrails',
    'documentMetaDatas' => 'documentmetadatas',
    'documentRolePermissions' => 'documentrolepermissions',
    'documentUserPermissions' => 'documentuserpermissions',
    'documentVersions' => 'documentversions',
    'documentComments' => 'documentcomments',
    'documentTokens' => 'documenttokens',
    'documentStatus' => 'documentstatus',
    'documentShareableLink' => 'documentshareablelink',
    'documentSignatures' => 'documentsignatures',
    'documentWorkflow' => 'documentworkflow',
    'fileRequests' => 'filerequests',
    'fileRequestDocuments' => 'filerequestdocuments',
    'reminderUsers' => 'reminderusers',
    'reminderNotifications' => 'remindernotifications',
    'reminderSchedulers' => 'reminderschedulers',
    'dailyReminders' => 'dailyreminders',
    'halfYearlyReminders' => 'halfyearlyreminders',
    'quarterlyReminders' => 'quarterlyreminders',
    'sendEmails' => 'sendemails',
    'emailLogs' => 'emaillogs',
    'emailLogAttachments' => 'emaillogattachments',
    'cronJobLogs' => 'cronjoblogs',
    'pageHelper' => 'pagehelper',
    'userNotifications' => 'usernotifications',
    'openaiDocuments' => 'openaidocuments',
    'aiPromptTemplates' => 'aiprompttemplates',
    'proposalFolders' => 'proposalfolders',
    'proposalFiles' => 'proposalfiles',
    'proposalFileRequests' => 'proposalfilerequests',
    'proposalPosts' => 'proposalposts',
    'proposalCandidates' => 'proposalcandidates',
    'workflowSteps' => 'workflowsteps',
    'workflowTransitions' => 'workflowtransitions',
    'workflowTransitionUsers' => 'workflowtransitionusers',
    'workflowTransitionRoles' => 'workflowtransitionroles',
    'workflowLogs' => 'workflowlogs',
];

$migrationsDir = $root . '/database/migrations';
foreach (glob($migrationsDir . '/*.php') as $file) {
    $content = file_get_contents($file);
    $orig = $content;
    foreach ($camelToLower as $from => $to) {
        $content = str_replace("Schema::create('$from'", "Schema::create('$to'", $content);
        $content = str_replace('Schema::create("' . $from . '"', 'Schema::create("' . $to . '"', $content);
        $content = str_replace("Schema::dropIfExists('$from'", "Schema::dropIfExists('$to'", $content);
        $content = str_replace("Schema::table('$from'", "Schema::table('$to'", $content);
        $content = str_replace("->on('$from')", "->on('$to')", $content);
        $content = str_replace('`' . $from . '`', '`' . $to . '`', $content);
    }
    if ($content !== $orig) {
        file_put_contents($file, $content);
        echo "OK migration: " . basename($file) . "\n";
    }
}

echo "Done.\n";
