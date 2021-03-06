<?php

session_start();
require_once 'vendor/autoload.php';
require_once 'lib/Twig.php';
require_once 'lib/DB.php';
require_once 'inc/config.php';

$tpl = 'error.tpl';
$args = [];
if (empty($_SESSION['email'])) {
    $tpl = 'login.tpl';
} elseif (empty($_SESSION['team_name'])) {
    $args['user']['email'] = $_SESSION['email'];
    $db = DB::get_db();
    $stmt = $db->prepare('SELECT team_name FROM user WHERE email = :email');
    try {
        $stmt->execute([':email' => $_SESSION['email']]);
    } catch (PDOException $e) {
        trigger_error($e->getMessage(), E_USER_WARNING);
        $tpl = 'error.tpl';
    }
    $team_name = $stmt->fetchColumn();
    if (empty($team_name)) {
        $tpl = 'submit_team_name.tpl';
    } else {
        $tpl = 'bracket.tpl';
        $_SESSION['team_name'] = $team_name;
        $args['user']['team_name'] = $team_name;
        if (empty($_SESSION['user_id'])) {
            $db = DB::get_db();
            $stmt = $db->prepare('SELECT id FROM user WHERE email = :email');
            try {
                $stmt->execute([':email' => $_SESSION['email']]);
            } catch (PDOException $e) {
                trigger_error($e->getMessage(), E_USER_WARNING);
                $tpl = 'error.tpl';
            }
            $_SESSION['user_id'] = $stmt->fetchColumn();
            if (!empty($_SESSION['group_to_add'])) {
                $stmt = $db->prepare("INSERT INTO fan_group_user (user_id, fan_group_id) VALUES (:user_id, :group_id)");
                try {
                    $stmt->execute([
                        ':user_id' => $_SESSION['user_id'],
                        ':group_id' => $_GET['group'],
                    ]);
                } catch (PDOException $e) {
                    trigger_error($e->getMessage(), E_USER_WARNING);
                    $args['errors']['add_to_group_error'] = true;
                    $_SESSION['group_to_add'] = '';
                    echo Twig::render_template('start_new_group.tpl', $args);
                    return;
                }

                $args['added_to_group'] = true;
                $_SESSION['group_to_add'] = '';
                echo Twig::render_template('start_new_group.tpl', $args);
                return;
            }
        }
    }
} elseif (!empty($_SESSION['team_name'])) {
    if (empty($_SESSION['user_id'])) {
        $db = DB::get_db();
        $stmt = $db->prepare('SELECT id FROM user WHERE email = :email');
        try {
            $stmt->execute([':email' => $_SESSION['email']]);
        } catch (PDOException $e) {
            trigger_error($e->getMessage(), E_USER_WARNING);
            $tpl = 'error.tpl';
        }
        $_SESSION['user_id'] = $stmt->fetchColumn();
    }
    if (!empty($_SESSION['group_to_add'])) {
        $db = DB::get_db();
        $stmt = $db->prepare("INSERT INTO fan_group_user (user_id, fan_group_id) VALUES (:user_id, :group_id)");
        try {
            $stmt->execute([
                ':user_id' => $_SESSION['user_id'],
                ':group_id' => $_GET['group'],
            ]);
        } catch (PDOException $e) {
            trigger_error($e->getMessage(), E_USER_WARNING);
            $args['errors']['add_to_group_error'] = true;
            $_SESSION['group_to_add'] = '';
            echo Twig::render_template('start_new_group.tpl', $args);
            return;
        }

        $args['added_to_group'] = true;
        $_SESSION['group_to_add'] = '';
        echo Twig::render_template('start_new_group.tpl', $args);
        return;
    }
    $args['user']['email'] = $_SESSION['email'];
    $args['user']['team_name'] = $_SESSION['team_name'];
    $tpl = 'bracket.tpl';
}

if ($tpl == 'bracket.tpl') {
    $db = DB::get_db();
    $stmt = $db->prepare("SELECT score FROM series_score");
    $stmt->execute();
    $series_score = $stmt->fetchAll(PDO::FETCH_COLUMN);
    $args['series_score'] = $series_score;
}
echo Twig::render_template($tpl, $args);
