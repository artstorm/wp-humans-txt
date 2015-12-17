<?php
/**
 * Generate a virtual humans.txt.
 *
 * @author   Johan Steen <artstorm at gmail dot com>
 * @link     https://johansteen.se/
 */
class WPHumansTxt_Rewrite
{
    /**
     * Initialize humans.txt output
     */
    public function __construct()
    {
        add_action('template_redirect', array(&$this, 'redirect'), 1);
    }

    /**
     * Handle the redirect to use custom output.
     *
     * @return void
     */
    public function redirect()
    {
        $currentUrl = "$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
        $humanUrl = str_replace(
            array('http://', 'https://'),
            '',
            home_url('humans.txt')
        );

        if ($humanUrl == $currentUrl) {
            $options = get_option(WPHumansTxt::OPTION_KEY);

            header('Content-Type: text/plain; charset=utf-8');

            echo $this->replaceTags($options['humanstxt']);
            die;
        }
    }

    /**
     * Find and replace tags in the text.
     *
     * @param  string $text
     *
     * @return string
     */
    protected function replaceTags($text)
    {
        $text = preg_replace_callback(
            '|\[(.*?)\]|',
            function ($matches)
            {
                $method = 'replace'.ucfirst($matches[1]);
                if (method_exists($this, $method)) {
                    return $this->$method();
                }

                return $matches[0];
            },
            $text
        );

        return $text;
    }

    /**
     * Get WordPress with version number.
     *
     * @return string
     */
    protected function replaceWordpress()
    {
        return 'WordPress '.get_bloginfo('version');
    }
}
