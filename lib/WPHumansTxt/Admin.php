<?php
/**
 * Handle the plugin backend.
 *
 * @author  Johan Steen <artstorm at gmail dot com>
 * @link    http://johansteen.se/
 */
class WPHumansTxt_Admin
{
    public function __construct()
    {
        add_action('admin_menu', array($this, 'menu'));
        add_action('admin_enqueue_scripts', array($this, 'scripts'));
    }

    /**
     * Register the Menu.
     */
    public function menu()
    {
        $page = add_options_page(
            'WP humans.txt '.__('Options', WPHumansTxt::TEXT_DOMAIN),
            'WP humans.txt',
            'administrator',
            plugin_basename(WPHumansTxt::FILE),
            array($this, 'renderpage')
        );

        new WPHumansTxt_Help($page);
    }

    public function renderpage()
    {
        if (isset($_POST['submit']) &&
            isset($_POST['wp_humans_txt_nonce']) &&
            wp_verify_nonce($_POST['wp_humans_txt_nonce'], 'wp_humans_txt')
        ) {
            $this->update();
        }

        $data = array(
            'options' => get_option(WPHumansTxt::OPTION_KEY),
            'buttons' => array(
                array('',
                    __('None', WPHumansTxt::TEXT_DOMAIN)),
                array('humanstxt-isolated-blank.gif',
                    __('Humans.txt blank isolated', WPHumansTxt::TEXT_DOMAIN)),
                array('humanstxt-isolated-orange.gif',
                    __('Humans.txt orange isolated', WPHumansTxt::TEXT_DOMAIN)),
                array('humanstxt-transparent-1ink.png',
                    __('Humans.txt transparent', WPHumansTxt::TEXT_DOMAIN)),
                array('humanstxt-transparent-color.png',
                    __('Humans.txt b/n transparent', WPHumansTxt::TEXT_DOMAIN)),
            )
        );
        echo WPHumansTxt_View::render('admin', $data);
    }

    /**
     * Display Flashing Message.
     */
    private function updateFlash()
    {
        printf(
            "<div class='updated'><p><strong>%s</strong></p></div>",
            __('Plugin settings updated.', WPHumansTxt::TEXT_DOMAIN)
        );
    }

    /**
     * Load CSS and JS on the settings page.
     */
    public function scripts($hook)
    {
        if ($hook != 'settings_page_wp-humans-txt/wp-humans-txt') {
            return;
        }
        $plugin = get_plugin_data(WPHumansTxt::FILE, false, false);
        $version = $plugin['Version'];

        wp_enqueue_script(
            'wp-humans-txt',
            plugins_url('assets/tab-handler.js', WPHumansTxt::FILE),
            array('jquery'),
            $version,
            false
        );
    }


    private function update()
    {
        $options = array(
            'humanstxt'   => $_POST['humanstxt'],
            'author_link' => isset($_POST['author_link']) ? true : false,
        );

        update_option(WPHumansTxt::OPTION_KEY, $options);
        $this->updateFlash();
    }
}
