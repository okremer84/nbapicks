<?php

require_once 'vendor/autoload.php';
require_once 'lib/Twig.php';
require_once 'lib/DB.php';
require_once 'inc/config.php';

echo Twig::render_template('login.tpl');

// to get DB object
// $db = DB::get_db();
