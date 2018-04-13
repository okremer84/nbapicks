<?php

session_start();
require_once 'vendor/autoload.php';
require_once 'lib/Twig.php';
require_once 'lib/DB.php';
require_once 'inc/config.php';

$db = DB::get_db();
if (!empty($_GET['group'])) {
    if (empty($_SESSION['user_id'])) {
        $_SESSION['group_to_add'] = $_GET['group'];
        header('Location: /index.php');
    }

    $stmt = $db->prepare("INSERT INTO fan_group_user (user_id, fan_group_id) VALUES (:user_id, (SELECT id FROM fan_group WHERE name = :group_name))");
    try {
        $stmt->execute([
            ':user_id' => $_SESSION['user_id'],
            ':group_name' => $_GET['group'],
        ]);
    } catch (PDOException $e) {
        trigger_error($e->getMessage(), E_USER_WARNING);
        $args['errors']['add_to_group_error'] = true;
        echo Twig::render_template('start_new_group.tpl', $args);
        return;
    }

    $args['added_to_group'] = true;
    echo Twig::render_template('start_new_group.tpl', $args);
    return;
}
if (empty($_POST['group_name'])) {
    echo Twig::render_template('start_new_group.tpl');
} else {
    $stmt = $db->prepare("INSERT INTO fan_group (name) VALUES (:name)");
    try {
        $stmt->execute([
            ':name' => $_POST['group_name'],
        ]);
    } catch (PDOException $e) {
        trigger_error($e->getMessage(), E_USER_WARNING);
        $args['errors']['taken'] = true;
        echo Twig::render_template('start_new_group.tpl', $args);
    }
    $group_id = $db->lastInsertId();

    $stmt = $db->prepare("INSERT INTO fan_group_user (user_id, fan_group_id) VALUES (:user_id, :group_id)");
    try {
        $stmt->execute([
            ':user_id' => $_SESSION['user_id'],
            ':group_id' => $group_id,
        ]);
    } catch (PDOException $e) {
        trigger_error($e->getMessage(), E_USER_WARNING);
        $args['errors']['try_again'] = true;
        echo Twig::render_template('start_new_group.tpl', $args);
    }

    if (empty($args['errors'])) {
        $args['new_group_url'] = "https://www.nbaplayoffpicks.com/new_group.php?group={$_POST['group_name']}";
        $args['group_name'] = $_POST['group_name'];
        echo Twig::render_template('start_new_group.tpl', $args);

    }
}

