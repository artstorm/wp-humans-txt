<h2>Humans.txt</h2>
<?php _e(
    "
Use this textarea to enter the humans.txt information. See the examples help
section for what to include. You can also use the insert base template button
to get a default humans.txt inserted, that you can use as a starting point and
change into your own.

The view humans.txt button let's you quickly see what your current live 
humans.txt file looks like.
",
    WPHumansTxt::TEXT_DOMAIN
); ?>

<h2><?php _e('Options', WPHumansTxt::TEXT_DOMAIN); ?></h2>
<h3><?php _e('Author Link', WPHumansTxt::TEXT_DOMAIN); ?></h3>
<?php _e(
    "
Enabling this option, inserts a meta tag within the HTML head section that links
to the humans.txt file. It's a rel author link tag that is inserted.
",
    WPHumansTxt::TEXT_DOMAIN
); ?>

<h3><?php _e('humans.txt button', WPHumansTxt::TEXT_DOMAIN); ?></h3>
<?php _e(
    "
    Enabling this option allows you to choose one of four buttons that will be
    inserted in the wp_footer section. The button links to the humans.txt file.
",
    WPHumansTxt::TEXT_DOMAIN
);
