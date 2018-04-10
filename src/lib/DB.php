<?php

class DB
{
    public static function get_db() {
        try
        {
            $db = new PDO(MYSQL_DSN, MYSQL_USERNAME, MYSQL_PASSWORD, array(
                PDO::ATTR_TIMEOUT => 15,
                PDO::ATTR_PERSISTENT => false,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::MYSQL_ATTR_USE_BUFFERED_QUERY => true,
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
            ));
            return $db;
        }
        catch (PDOException $e)
        {
            trigger_error($e->getMessage(), E_USER_ERROR);
            return false;
        }
    }
}