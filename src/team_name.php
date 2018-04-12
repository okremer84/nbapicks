<?php

session_start();
require_once 'vendor/autoload.php';
require_once 'lib/Twig.php';
require_once 'lib/DB.php';
require_once 'inc/config.php';

$db = DB::get_db();
if (empty($_POST['team_name'])) {
    $args['errors']['team_name_missing'] = true;
    echo Twig::render_template('submit_team_name.tpl', $args);
} else {
    $stmt = $db->prepare("INSERT INTO user (email, team_name) VALUES (:email, :team_name) ON DUPLICATE KEY UPDATE team_name = :team_name");
    try {
        $stmt->execute([
            ':email' => $_SESSION['email'],
            ':team_name' => $_POST['team_name'],
        ]);
    } catch (PDOException $e) {
        trigger_error($e->getMessage(), E_USER_WARNING);
        header('Location: /index.php');
    }

    $stmt = $db->prepare("INSERT INTO pick (user_id) VALUES ((SELECT id FROM user WHERE email = :email))");
    try {
        $stmt->execute([
            ':email' => $_SESSION['email'],
            ':team_name' => $_POST['team_name'],
        ]);
    } catch (PDOException $e) {
        trigger_error($e->getMessage(), E_USER_WARNING);
        header('Location: /index.php');
    }

    $_SESSION['team_name'] = $_POST['team_name'];
    header('Location: /index.php');
}

