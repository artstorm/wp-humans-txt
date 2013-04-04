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
    }

    /**
     * Register the Menu.
     */
    public function menu()
    {
        add_options_page(
            'WP humans.txt '.__('Options', WPHumansTxt::TEXT_DOMAIN),
            'WP humans.txt',
            'administrator',
            plugin_basename(WPHumansTxt::FILE),
            array($this, 'renderpage')
        );
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
        );
        echo WPHumansTxt_View::render('admin', $data);
    }

    private function update()
    {
        $options = array(
            'humanstxt' => $_POST['humanstxt']
        );

        update_option(WPHumansTxt::OPTION_KEY, $options);
    }
}
