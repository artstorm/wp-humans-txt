<h2><?php _e('The humans', WPHumansTxt::TEXT_DOMAIN); ?></h2>
<?php _e(
    "
Include the following information about every human involved in the project: role, name, contact, twitter, geolocation, etc. Please be aware that you may have to deal with spam if you include email adresses.
",
    WPHumansTxt::TEXT_DOMAIN
); ?>

<h2><?php _e('Additional', WPHumansTxt::TEXT_DOMAIN); ?></h2>
<?php _e(
    "
You can also include additional information about the site, such as the date of the last update (YYYY/MM/DD), its main language, its Doctype and other components, tools and software used on the development.
",
    WPHumansTxt::TEXT_DOMAIN
); ?>

<h2><?php _e('The standard', WPHumansTxt::TEXT_DOMAIN); ?></h2>
<?php printf(
    __(
        "
Visit %s quick start to read more about what to include and the standard.
",
        WPHumansTxt::TEXT_DOMAIN
    ),
    "<a href='http://humanstxt.org/Standard.html'>humanstxt.org</a>"
); ?>

<h2><?php _e('Example', WPHumansTxt::TEXT_DOMAIN); ?></h2>
<code>
/* TEAM */<br />
Your title: Your name.<br />
Site: email, link to a contact form, etc.<br />
Twitter: your Twitter username.<br />
Location: City, Country.<br />
<br />
                        [...]<br />
<br />							
/* THANKS */<br />
Name: name or url<br />
<br />
                        [...]<br />
<br />                            
/* SITE */<br />
Last update: YYYY/MM/DD<br />
Standards: HTML5, CSS3,..<br />
Components: Modernizr, jQuery, etc.<br />
Software: Software used for the development
</code>
