<?php
require __DIR__.'/../vendor/autoload.php';
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__.'/..');
$dotenv->load();

ini_set('user_agent', 'ndn-cxx-breaks/20201213');
?>
