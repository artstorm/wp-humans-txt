<?php
/**
 * Handles the plugin help screen.
 *
 * @author  Johan Steen <artstorm at gmail dot com>
 * @link    https://johansteen.se/
 */
class WPHumansTxt_Help
{
    public function __construct($optionPage)
    {
        add_action('load-'.$optionPage, array(&$this,'addHelpTabs'));
    }

    /**
     * Setup the help tabs and sidebar.
     */
    public function addHelpTabs()
    {
        $screen = get_current_screen();
        $screen->set_help_sidebar($this->helpSidebar());
        $screen->add_help_tab(
            array(
            'id'      => 'intro-plugin-help',
            'title'   => __('Introduction', 'wp-humanstxt'),
            'content' => $this->helpIntro()
            )
        );
        $screen->add_help_tab(
            array(
            'id'      => 'usage-plugin-help',
            'title'   => __('Usage', 'wp-humanstxt'),
            'content' => $this->helpUsage()
            )
        );
        $screen->add_help_tab(
            array(
            'id'      => 'examples-plugin-help',
            'title'   => __('Examples', 'wp-humanstxt'),
            'content' => $this->helpExamples()
            )
        );
    }

    /**
     * The right sidebar help text.
     */
    public function helpSidebar()
    {
        return WPHumansTxt_View::render('help_sidebar');
    }

    /**
     * The introduction help tab.
     */
    public function helpIntro()
    {
        return WPHumansTxt_View::render('help_intro');
    }

    /**
     * The usage help tab.
     */
    public function helpUsage()
    {
        return WPHumansTxt_View::render('help_usage');
    }

    /**
     * The usage help tab.
     */
    public function helpExamples()
    {
        return WPHumansTxt_View::render('help_examples');
    }
}
