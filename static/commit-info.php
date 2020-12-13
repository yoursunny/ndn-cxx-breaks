<?php
require_once 'env.php';

$patchset = $_GET['patchset'];
list($changeNo, $revisionNo) = array_map('intval', explode(',', $patchset));
header('Content-Type: application/json');
header('Cache-Control: max-age=600');

function gerrit_json_get($url) {
  $context = stream_context_create(array(
    'http'=>array(
      'method'=>'GET',
      'header'=>[
        'Accept: application/json',
      ],
    )
  ));
  $json = @file_get_contents($_ENV['GERRIT_ROOT'].$url, false, $context);
  if ($json === FALSE) {
    return FALSE;
  }
  $json = substr($json, 5);
  return json_decode($json, TRUE);
}

$changes = gerrit_json_get('/changes/?q=change:'.$changeNo.'&o=ALL_REVISIONS');
if ($changes === FALSE || count($changes) < 1) {
  echo json_encode(array('error'=>'Change not found'));
  die;
}

$change = $changes[0];
$changeId = $change['id'];
$revisionId = FALSE;
foreach ($change['revisions'] as $revId => $revision) {
  if ($revision['_number'] == $revisionNo) {
    $revisionId = $revId;
  }
}
if ($revisionId === FALSE) {
  echo json_encode(array('error'=>'patchset not found'));
  die;
}

$commit = gerrit_json_get('/changes/'.$changeId.'/revisions/'.$revisionId.'/commit');
if ($commit === FALSE) {
  echo json_encode(array('error'=>'patchset not found'));
  die;
}

echo json_encode(array(
  'project'=>$change['project'],
  'author'=>$commit['author']['name'],
  'date'=>$commit['committer']['date'],
  'subject'=>$commit['subject']
));

?>
