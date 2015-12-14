<!-- Create a header in the default WordPress 'wrap' container -->
<div class="wrap">
    <div id="icon-wphumanstxt" style="background: url(<?php
        echo plugin_dir_url(WPHumansTxt::FILE);
        ?>assets/admin-icon-32.png) no-repeat;" class="icon32"></div>
    <h2>WP Humans.txt</h2>

    <form method="post" action="">
        <?php
        wp_nonce_field('wp_humans_txt', 'wp_humans_txt_nonce');
        ?>

        <h3>Humans.txt</h3>
        <p>
            <label for="humanstxt"><?php
            _e('Enter your humans.txt below. Use the help button above for further guidance.', 'wp-humans-txt');
            ?></label>
            <a href='<?php echo home_url('humans.txt'); ?>' class='button button-small'>
            <?php _e('View', 'wp-humans-txt'); ?> humans.txt</a>
        </p>
        <textarea name="humanstxt" id="humanstxt" class="code" cols="80"
            rows="20"><?php
            echo $options['humanstxt'];
        ?></textarea>
        <p>
        <a id="insert_base_template" class="button"><?php
            _e('Insert Base Template', 'wp-humans-txt');
        ?></a>
        </p>

        <h3><?php _e('Options', 'wp-humans-txt'); ?></h3>

        <table class="form-table">
            <tr valign="top">
                <th scope="row"><?php _e('Author link', 'wp-humans-txt'); ?></th>
                <td><label for="author_link">
                <input name="author_link" type="checkbox" id="author_link" value="1" <?php checked($options['author_link']); ?> />
                <?php _e('Place an author link to the file within the head of the site.', 'wp-humans-txt'); ?></label>
                </td>
            </tr>
        </table>

        <table class="form-table">
            <tr valign="top">
                <th scope="row"><label for="humanstxt_button"><?php _e('Humans.txt button', 'wp-humans-txt'); ?></label></th>
                <td>
                <select name="humanstxt_button" type="checkbox" id="humanstxt_button">
                    <?php
                    foreach ($buttons as $button) {
                        echo "<option value='{$button[0]}'";
                        echo ($button[0] == $options['button']) ? ' selected' : '';
                        echo ">{$button[1]}</option>";
                    }
                    ?>
                </select>
                <p class="description">
                <?php _e('Add a button to the footer, which links to the humans.txt file.', 'wp-humans-txt'); ?>
                </p>
                </td>
            </tr>
        </table>

        <?php submit_button(); ?>
    </form>
