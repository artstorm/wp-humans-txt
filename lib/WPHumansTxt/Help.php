<?php
/**
 * Handles the plugin help screen.
 *
 * @author  Johan Steen <artstorm at gmail dot com>
 * @link    http://johansteen.se/
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
            'title'   => __('Introduction', WPHumansTxt::TEXT_DOMAIN),
            'content' => $this->helpIntro()
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
     * The basic help tab.
     */
    public function helpIntro()
    {
        return WPHumansTxt_View::render('help_intro');
    }
}
