<!-- Create a header in the default WordPress 'wrap' container -->
<div class="wrap">
    <div id="icon-wphumanstxt" style="background: url(<?php
        echo plugin_dir_url(WPHumansTxt::FILE);
        ?>assets/admin-icon-32.png) no-repeat;" class="icon32"></div>
    <h2>WP humans.txt</h2>

    <form method="post" action="">
        <?php
        wp_nonce_field('wp_humans_txt', 'wp_humans_txt_nonce');
        ?>

        <h3>humans.txt</h3>
        <p><label for="humanstxt"><?php
            _e('Enter your humans.txt below.', WPHumansTxt::TEXT_DOMAIN);
        ?></label></p>
        <textarea name="humanstxt" id="humanstxt" class="code" cols="80"
            rows="20"><?php
            echo $options['humanstxt'];
        ?></textarea>

        <h3><?php _e('Options', WPHumansTxt::TEXT_DOMAIN); ?></h3>

        <table class="form-table">
            <tr valign="top">
                <th scope="row"><?php _e('Author link', WPHumansTxt::TEXT_DOMAIN); ?></th>
                <td><label for="author_link">
                <input name="author_link" type="checkbox" id="author_link" value="1" <?php checked($options['author_link']); ?> />
                <?php _e('Place an author link to the file within the head of the site.', WPHumansTxt::TEXT_DOMAIN); ?></label>
                </td>
            </tr>
        </table>

        <?php submit_button(); ?>
    </form>
