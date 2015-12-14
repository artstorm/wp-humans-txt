<div class="error">
    <p>
    <?php
        _e('WP Humans.txt needs WordPress to be configured with a permalink
            structure other than the default to work properly.',
            'wp-humans-txt'
        );
    ?>
    <br/>
    <?php
        printf(
            __('Change the setting in the %s.', 'wp-humans-txt'),
            '<a href="'.admin_url('options-permalink.php').'">'.
            __('Permalink Options', 'wp-humans-txt').
            '</a>'
        );
    ?>
    </p>
</div>
