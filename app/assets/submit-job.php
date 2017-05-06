<?php
$dryrun = false;
$projects = json_decode(file_get_contents('projects.json'), TRUE);
$input = json_decode(file_get_contents('php://input'), TRUE);
$job = date('YmdHis');
$patchsets = $input['patchsets'];
$email = $input['email'];
include 'travis.php';
echo json_encode(array('job'=>$job));
?>
