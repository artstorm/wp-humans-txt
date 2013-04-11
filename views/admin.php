<!-- Create a header in the default WordPress 'wrap' container -->
<div class="wrap">
    <div id="icon-wphumanstxt" style="background: url(<?php
        echo '';
        ?>images/shuriken-32.png) no-repeat;" class="icon32"></div>
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

        <?php submit_button(); ?>
    </form>
