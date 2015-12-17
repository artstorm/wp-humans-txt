jQuery(document).ready(function($) {
    $("a#insert_base_template").click(function(e) {
        $("#humanstxt").append(humanstxt_base_template);
    });
});

var humanstxt_base_template =
"/* TEAM * /\n\
Your title: Your name.\n\
Site: email, link to a contact form, etc.\n\
Twitter: your Twitter username.\n\
Location: City, Country.\n\
\n\
/* THANKS * /\n\
Name: name or url\n\
\n\
/* SITE * /\n\
Last update: [lastpostdate]\n\
Standards: HTML5, CSS3,..\n\
Components: [wordpress], Modernizr, jQuery, etc.\n\
Software: Software used for the development\n\
";
