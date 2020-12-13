<?php
require_once 'env.php';

$projects = json_decode(file_get_contents('projects.json'), TRUE);
$inputs = json_decode(file_get_contents('php://input'), TRUE);

$dispatch = array(
  'ref'=>$_ENV['GH_BRANCH'],
  'inputs'=>array(
    'email'=>$inputs['email'],
    'patchsets'=>json_encode($inputs['patchsets']),
  ),
);
$body = json_encode($dispatch);

$auth = base64_encode('PersonalAccessToken:'.$_ENV['GH_TOKEN']);
$context = stream_context_create(array(
  'http'=>array(
    'method'=>'POST',
    'header'=>[
      'Content-Type: application/json',
      "Authorization: Basic $auth",
      'Accept: application/vnd.github.v3+json',
    ],
    'content'=>$body,
    'ignore_errors'=>TRUE,
  ),
));

$url = $_ENV['GITHUB_API'].'/repos/'.$_ENV['GH_REPOSITORY'].'/actions/workflows/'.$_ENV['GH_WORKFLOW'].'/dispatches';
$response = file_get_contents($url, false, $context);
header($http_response_header[0]);
echo $response;
?>
