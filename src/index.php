<?php

require_once 'vendor/autoload.php';
require_once 'lib/Twig.php';
require_once 'inc/config.php';

// TODO: check login
// if logged out
echo Twig::render_template('login.tpl');