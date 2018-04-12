<?php

session_start();
require_once '../vendor/autoload.php';
require_once '../lib/DB.php';
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
} else {
    echo "failed";
    die();
}