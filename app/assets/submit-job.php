<?php
$projects = json_decode(file_get_contents('projects.json'), TRUE);
$input = json_decode(file_get_contents('php://input'), TRUE);
$job = date('YmdHis');
$patchsets = $input['patchsets'];
$email = $job.'@mailinator.com';
include 'travis.php';
?>
