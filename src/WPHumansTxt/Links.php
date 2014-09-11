<?php
/**
 * Add links to humans.txt.
 *
 * @author   Johan Steen <artstorm at gmail dot com>
 * @link     http://johansteen.se/
 */
class WPHumansTxt_Links
{
    public function __construct()
    {
        add_action('wp_head', array(&$this, 'head'));
        add_action('wp_footer', array(&$this, 'footer'));
    }

    public function head()
    {
        $options = get_option(WPHumansTxt::OPTION_KEY);
        if ($options['author_link']) {
            printf(
                "<link type='text/plain' rel='author' href='%s' />\n",
                home_url('humans.txt')
            );
        }
    }

    public function footer()
    {
        $options = get_option(WPHumansTxt::OPTION_KEY);
        if ($options['button']) {
            printf(
                "<a href='%s'><img src='%s' /></a>",
                home_url('humans.txt'),
                plugins_url('assets/'.$options['button'], WPHumansTxt::FILE)
            );
        }
    }
}
