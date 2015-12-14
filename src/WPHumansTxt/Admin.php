<?php
/**
 * Handle the plugin backend.
 *
 * @author  Johan Steen <artstorm at gmail dot com>
 * @link    https://johansteen.se/
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
            'WP Humans.txt '.__('Options', 'wp-humans-txt'),
            'WP Humans.txt',
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
                    __('None', 'wp-humans-txt')),
                array('humanstxt-isolated-blank.gif',
                    __('Humans.txt blank isolated', 'wp-humans-txt')),
                array('humanstxt-isolated-orange.gif',
                    __('Humans.txt orange isolated', 'wp-humans-txt')),
                array('humanstxt-transparent-1ink.png',
                    __('Humans.txt transparent', 'wp-humans-txt')),
                array('humanstxt-transparent-color.png',
                    __('Humans.txt b/n transparent', 'wp-humans-txt')),
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
            __('Plugin settings updated.', 'wp-humans-txt')
        );
    }

    /**
     * Load CSS and JS on the settings page.
     */
    public function scripts($hook)
    {
        // Trim the hook to account for folder name differences
        $hook = split('/', $hook);
        $hook = end($hook);
        if ($hook != 'wp-humans-txt') {
            return;
        }

        $plugin = get_plugin_data(WPHumansTxt::FILE, false, false);
        $version = $plugin['Version'];

        wp_enqueue_script(
            'wp-humans-txt-tab-handler',
            plugins_url('assets/tab-handler.js', WPHumansTxt::FILE),
            array('jquery'),
            $version,
            false
        );

        wp_enqueue_script(
            'wp-humans-txt-insert-text',
            plugins_url('assets/insert-text.js', WPHumansTxt::FILE),
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
            'button'      => $_POST['humanstxt_button'],
        );

        update_option(WPHumansTxt::OPTION_KEY, $options);
        $this->updateFlash();
    }
}
