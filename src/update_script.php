<?php

require_once('inc/config.php');
require_once('lib/DB.php');


function update_winner($team_name, $spot) {
    $db = DB::get_db();
    // Update winning team

    $stmt = $db->prepare("SELECT user_id FROM pick WHERE spot_$spot = :team_name");
    $stmt->execute([
        ':team_name' => $team_name,
    ]);
    $user_ids = $stmt->fetchAll(PDO::FETCH_COLUMN);

    foreach ($user_ids as $id) {
        $update_stmt = $db->prepare("UPDATE pick_results SET spot_{$spot}_correct = '1' WHERE user_id = :user_id");
        $update_stmt->execute([
            ':user_id' => $id,
        ]);

        $update_stmt = $db->prepare("UPDATE user SET score = score + 10 WHERE id = :user_id");
        $update_stmt->execute([
            ':user_id' => $id,
        ]);
    }
}

function update_loser($team_name, $spot) {
    $db = DB::get_db();

    $stmt = $db->prepare("SELECT user_id FROM pick WHERE spot_$spot = :team_name");
    $stmt->execute([
        ':team_name' => $team_name,
    ]);
    $user_ids = $stmt->fetchAll(PDO::FETCH_COLUMN);

    foreach ($user_ids as $id) {
        $update_stmt = $db->prepare("UPDATE pick_results SET spot_{$spot}_correct = '0' WHERE user_id = :user_id");
        $update_stmt->execute([
            ':user_id' => $id,
        ]);
    }
}

function update_score($team_name, $series, $score) {
    $db = DB::get_db();

    $update_stmt = $db->prepare("UPDATE series_score SET score = :score WHERE team_playing = :team AND series = :series");
    $update_stmt->execute([
        ':score' => $score,
        ':team' => $team_name,
        ':series' => $series,
    ]);
}

function get_series_table() {
    $db = DB::get_db();

    $scores_table = $db->query("SELECT * FROM series_score");
    var_dump($scores_table->fetchAll());
}

//update_score("GSW", "GSW - SAS", '3');

echo "Done";