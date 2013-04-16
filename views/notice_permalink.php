<div class="error">
    <p>
    <?php
        _e('WP Humans.txt needs WordPress to be configured with a permalink
            structure other than the default to work properly.',
            WPHumansTxt::TEXT_DOMAIN
        );
    ?>
    <br/>
    <?php
        printf(
            __('Change the setting in the %s.', WPHumansTxt::TEXT_DOMAIN),
            '<a href="'.admin_url('options-permalink.php').'">'.
            __('Permalink Options', WPHumansTxt::TEXT_DOMAIN).
            '</a>'
        );
    ?>
    </p>
</div>
