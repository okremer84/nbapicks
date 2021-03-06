<?php

class Twig
{
    private static $twig_environment = null;

    private static function connect_twig()
    {

        $root_dir = realpath(__DIR__ . '..' . DIRECTORY_SEPARATOR);
        if(!is_null(self::$twig_environment)) {
            return self::$twig_environment;
        }

        try {
            $loader = new Twig_Loader_Filesystem($root_dir . "tpl");
        } catch (Twig_Error_Loader $e) {
            $loader = new Twig_Loader_Filesystem($root_dir . "../tpl");
        }
        $twig = new Twig_Environment($loader, array(
            'cache' => $root_dir . "tmp",
            'auto_reload' => true,
            'autoescape' => 'html',
            'debug' => false
        ));

        self::$twig_environment = $twig;
        return $twig;
    }

    public static function render_template($template, array $args = []) {
        $twig = self::connect_twig();

        $args['config']['fb_app_id'] = FB_APP_ID;
        $args['config']['google_client_id'] = GOOGLE_CLIENT_ID;
        $rendered_tpl = $twig->render($template, $args);
        return $rendered_tpl;
    }
}
