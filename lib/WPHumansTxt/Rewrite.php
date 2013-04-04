<?php
/**
 * Generate a virtual humans.txt.
 *
 * @author   Johan Steen <artstorm at gmail dot com>
 * @link     http://johansteen.se/
 */
class WPHumansTxt_Rewrite
{
    public function __construct() {
        add_action('template_redirect', array(&$this, 'redirect'), 1);
    }

    public function redirect()
    {
        $currentUrl = "$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
        $humanUrl = str_replace(
            array('http://', 'https://'),
            '',
            home_url('humans.txt')
        );
        if ($humanUrl == $currentUrl) {
            header('Content-Type: text/plain; charset=utf-8');
            echo WPHumansTxt_View::render('humanstxt');
            die;
        }
    }
}