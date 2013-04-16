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
        add_action('wp_head', array(&$this, 'wpHead'));
    }

    public function wpHead()
    {
        $options = get_option(WPHumansTxt::OPTION_KEY);
        if ($options['author_link']) {
            printf("<link rel='author' href='%s' />\n", home_url('humans.txt'));
        }
    }
}
