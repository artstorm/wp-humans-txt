<h2><?php _e('Template Tags', 'wp-humanstxt'); ?></h2>
<?php _e(
    "
The plugin provide template tags that can be used to dynamically insert content
into your humans.txt.
",
    'wp-humanstxt'
); ?>

<h4><?php _e('The following template tags are available', 'wp-humanstxt'); ?></h4>

<ul>
    <li><code>[wordpress]</code>: <?php _e('Outputs WordPress with current version number.', 'wp-humanstxt'); ?></li>
    <li><code>[lastpostdate]</code>: <?php _e('Outputs the date the last post was made.', 'wp-humanstxt'); ?></li>
</ul>
