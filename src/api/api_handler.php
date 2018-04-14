<?php

session_start();
require_once '../vendor/autoload.php';
require_once '../lib/DB.php';
require_once '../lib/Twig.php';
require_once '../inc/config.php';

$action = $_POST['action'];

if ($action == "save_login") {
    if (empty($_POST['token']) || empty($_POST['login_type'])) {
        echo "failed";
    }

    $token = $_POST['token'];
    $login_type = $_POST['login_type'];

    if ($login_type == 'fb') {
        if (empty($_POST['fb_id'])) {
            echo "failed";
            die();
        }

        $ch = curl_init();
        $url = "https://graph.facebook.com/me?fields=email&access_token=" . $token;
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
        curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
        $result = curl_exec($ch);
        curl_close($ch);
        $fb_profile = json_decode($result, true);
        if (isset($fb_profile['error'])) {
            echo "failed";
            die();
        } elseif (isset($fb_profile['id']) && $fb_profile['id'] != $_POST['fb_id']) {
            echo "failed";
            die();
        }

        if (!empty($fb_profile['email'])) {
            $_SESSION['email'] = $fb_profile['email'];
            echo "Success";
            die();
        } else {
            echo "failed";
            die();
        }

    } elseif ($login_type == 'google') {
        $client = new Google_Client(['client_id' => GOOGLE_CLIENT_ID]);  // Specify the CLIENT_ID of the app that accesses the backend
        $payload = $client->verifyIdToken($token);
        if ($payload) {
            $_SESSION['email'] = $payload['email'];
            echo "Success";
            die();
        } else {
            echo "failed";
            die();
        }
    } else {
        echo "failed";
        die();
    }
} elseif ($_POST['action'] == 'save_pick') {
    echo "times up";
    die();
    if (empty($_SESSION['user_id']) || empty($_SESSION['email'])) {
        echo "logged_out";
        die();
    }
    if (empty($_POST['team']) || empty($_POST['spot']) || empty($_POST['email'])) {
        echo "failed";
        die();
    }

    if ($_POST['email'] != $_SESSION['email']) {
        echo "unauthorized";
        die();
    }

    $team = $_POST['team'];

    $column_name_whitelist = [
        '16' => 'spot_16',
        '17' => 'spot_17',
        '18' => 'spot_18',
        '19' => 'spot_19',
        '20' => 'spot_20',
        '21' => 'spot_21',
        '22' => 'spot_22',
        '23' => 'spot_23',
        '24' => 'spot_24',
        '25' => 'spot_25',
        '26' => 'spot_26',
        '27' => 'spot_27',
        '28' => 'spot_28',
        '29' => 'spot_29',
        '30' => 'spot_30',
        '31' => 'spot_31',
    ];

    if (!isset($column_name_whitelist[$_POST['spot']])) {
        echo "failed";
        die();
    }

    $db = DB::get_db();
    $stmt = $db->prepare('UPDATE pick SET ' . $column_name_whitelist[$_POST['spot']] . ' = :team WHERE user_id = :user_id');
    try {
        $stmt->execute([
            ':team' => $team,
            ':user_id' => $_SESSION['user_id'],
        ]);
    } catch (PDOException $e) {
        trigger_error($e->getMessage(), E_USER_WARNING);
        echo "failed";
        die();
    }
    echo "Success";
    die();
} elseif ($_POST['action'] == 'get_picks') {
    if (empty($_SESSION['user_id'])) {
        echo "logged_out";
        die();
    }

    $user_id = $_SESSION['user_id'];
    if (!empty($_POST['user_id'])) {
        $user_id = $_POST['user_id'];
    }

    $db = DB::get_db();

    // Yeah I know, I used *
    $stmt = $db->prepare('SELECT * FROM pick p join user u ON p.user_id = u.id WHERE user_id = :user_id');
    try {
        $stmt->execute([
            ':user_id' => $user_id,
        ]);
    } catch (PDOException $e) {
        trigger_error($e->getMessage(), E_USER_WARNING);
        echo "failed";
        die();
    }

    $picks = $stmt->fetchAll();
    echo json_encode($picks);
} elseif ($_POST['action'] == 'get_players_for_team') {
    if (empty($_SESSION['user_id'])) {
        echo "logged_out";
        die();
    }

    if (empty($_POST['team'])) {
        echo "failed";
        die();
    }

    $db = DB::get_db();

    $stmt = $db->prepare('SELECT player.name, player.id FROM player JOIN team ON player.team_id = team.id AND team.abbreviation = :abbreviation');
    try {
        $stmt->execute([
            ':abbreviation' => $_POST['team'],
        ]);
    } catch (PDOException $e) {
        trigger_error($e->getMessage(), E_USER_WARNING);
        echo "failed";
        die();
    }

    $picks = $stmt->fetchAll();
    echo json_encode($picks);
} elseif ($_POST['action'] == 'get_global') {
    $db = DB::get_db();
    $stmt = $db->prepare('
                SELECT 
                    team_name, score, id
                FROM
                    user
                LIMIT 10');
    try {
        $stmt->execute();
    } catch (PDOException $e) {
        trigger_error($e->getMessage(), E_USER_WARNING);
        die();
    }

    $args['group_data'] = $stmt->fetchAll();
    echo Twig::render_template('global.tpl', $args);
} elseif ($_POST['action'] == 'get_sidebar') {
    if (empty($_SESSION['user_id'])) {
        echo "failed";
        die();
    }
    $db = DB::get_db();
    $stmt = $db->prepare('
                SELECT 
                    g.id, g.name 
                FROM
                    fan_group_user gu
                        JOIN
                    fan_group g ON g.id = gu.fan_group_id
                        JOIN
                    user u ON u.id = gu.user_id
                    WHERE user_id = :user_id');
    try {
        $stmt->execute([':user_id' => $_SESSION['user_id']]);
    } catch (PDOException $e) {
        trigger_error($e->getMessage(), E_USER_WARNING);
        die();
    }

    $args['group_data'] = $stmt->fetchAll();
    echo Twig::render_template('sidebar_content.tpl', $args);
} elseif ($_POST['action'] == 'get_group_data') {
    if (empty($_SESSION['user_id']) || empty($_POST['group_id'])) {
        echo "failed";
        die();
    }
    $db = DB::get_db();
    $stmt = $db->prepare("SELECT 1 FROM fan_group_user WHERE user_id = :user_id AND fan_group_id = :group_id");
    $stmt->execute([
        ':user_id' => $_SESSION['user_id'],
        ':group_id' => $_POST['group_id'],
    ]);

    if (empty($stmt->fetchColumn())) {
        echo "unauthorized";
        die();
    }
    $stmt = $db->prepare('
                SELECT 
                    u.id, u.team_name, g.name group_name, u.score
                FROM
                    fan_group_user gu
                        JOIN
                    fan_group g ON g.id = gu.fan_group_id
                        JOIN
                    user u ON u.id = gu.user_id
                    WHERE g.id = :group_id
                    ORDER BY score DESC');
    try {
        $stmt->execute([':group_id' => $_POST['group_id']]);
    } catch (PDOException $e) {
        trigger_error($e->getMessage(), E_USER_WARNING);
        die();
    }

    $args['group_data'] = $stmt->fetchAll();
    echo Twig::render_template('group_view.tpl', $args);
} else {
    echo "failed";
    die();
}