<?php
require __DIR__.'/../vendor/autoload.php';

$repo = sys_get_temp_dir().'/ndn-cxx-breaks_'.$job;

$git = new PHPGit\Git();
$git->setBin(__DIR__.'/../git.sh');
$git->clone('git@github.com:yoursunny/ndn-cxx-breaks.git', $repo);
$git->setRepository($repo);
$git->config->set('user.email', 'ndn-cxx-breaks@yoursunny.invalid');
$git->config->set('user.name', 'ndn-cxx-breaks webapp');
$git->checkout->create($job);

$y = Spyc::YAMLLoad($repo.'/.travis.yml');

$globals = [];
$exclude = [];
foreach ($projects as $proj) {
  $name = $proj['name'];
  if (isset($proj['patchset_varname']) && $patchsets[$name] != 'master' && $patchsets[$name] != 'none') {
    $globals[] = $proj['patchset_varname'].'='.$patchsets[$name];
  }
  if ($patchsets[$name] == 'none' || @$proj['skip_job'] === true) {
    $exclude[] = ['env' => 'PROJECT='.$name];
  }
}
$y['env']['global'] = $globals;
$y['jobs']['exclude'] = $exclude;

$y['notifications'] = [
  'email' => [
    'recipients' => [$email],
    'on_success' => 'always',
    'on_failure' => 'always',
  ]
];

file_put_contents($repo.'/.travis.yml', Spyc::YAMLDump($y));

$git->add('.travis.yml');
$git->commit('job '.$job);

if (!$dryrun) {
  $git->push('origin', $job);
  rmrdir($repo);
}
?>
