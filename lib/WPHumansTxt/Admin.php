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
            'WP humans.txt Options',
            'WP humans.txt',
            'administrator',
            plugin_basename(WPHumansTxt::FILE),
            array($this, 'renderpage')
        );
    }

    public function renderpage()
    {
        $data = array(
            // 'pageSlug'    => PayPalDonations_Admin::PAGE_SLUG,
            // 'optionDBKey' => PayPalDonations::OPTION_DB_KEY,
        );
        echo WPHumansTxt_View::render('admin', $data);
    }
}
