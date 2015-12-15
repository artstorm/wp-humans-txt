<div class="error">
    <p>
    <?php
        _e('WP Humans.txt needs WordPress to be configured with a permalink
            structure other than the default to work properly.',
            'wp-humanstxt'
        );
    ?>
    <br/>
    <?php
        printf(
            __('Change the setting in the %s.', 'wp-humanstxt'),
            '<a href="'.admin_url('options-permalink.php').'">'.
            __('Permalink Options', 'wp-humanstxt').
            '</a>'
        );
    ?>
    </p>
</div>
