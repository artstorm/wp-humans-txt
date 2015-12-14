=== WP Humans.txt ===
Contributors: artstorm
Donate link: https://johansteen.se/donate/
Tags: humans.txt, cresdits, humans, txt
Requires at least: 3.3
Tested up to: 4.4
Stable tag: 1.0.3
License: GPLv2 or later
License URI: http://www.gnu.org/licenses/gpl-2.0.html

Generates a virtual humans.txt file that complies with the specifications at
humanstxt.org.


== Description ==

The plugin generates a virtual humans.txt file complying with the specifications
at [humanstxt.org](http://humanstxt.org/). The virtual file is located at
WordPress Install/humans.txt. The plugin is fast, lightweight and
straightforward to use.

= Features =

* Generates a virtual humans.txt, no physical file is created on disk.
* Optional author link to be inserted in the html head section.
* Optional humans.txt button to be inserted in the wp footer.
* Provides an editor within WordPress admin to edit the humans.txt 'file'.
* Outputs as plain text, with utf-8 encoding.
* The editor allows the usage of the tab key for convenient editing.
* Uses WordPress' system for on screen help documentation.
* Clean uninstall.

= Related Links =

* [Documentation](https://johansteen.se/code/wp-humans-txt/
  "Complete usage instructions")
* [Support Forum](http://wordpress.org/support/plugin/wp-humanstxt
  "Use this for support and feature requests")
* [GitHub](https://github.com/artstorm/wp-humans-txt
  "Contribute to the plugin")


== Installation ==

= Install =

1. Install the plugin either via the `WordPress.org` plugin directory, or by
   uploading the files to your server (in the `/wp-content/plugins/` directory).
2. Activate the plugin through the `Plugins` menu in WordPress.
3. Go to `Settings -> WP humans.txt` and setup your info.

= Uninstall =

1. Deactivate the plugin in the `Plugins` menu in WordPress.
2. After Deactivation a `Delete` link appears below the plugin name, follow the
   link and confim with `Yes, Delete these files`.
3. This will delete all the plugin files from the server as well as erasing all
   options the plugin has stored in the database.


== Frequently Asked Questions ==

= Where can I get support? =

This is a free plugin, so support is not guaranteed. Post your question in the
support forum and help might be provided by the developer or by the community.
[Support Forum](http://wordpress.org/support/plugin/wp-humanstxt)

= How can I contribute? =

You can contribute with Bug Reports, Feature Requests or Pull Requests. Please
take a moment to review the guidelines for contributing.
[Guidelines](https://github.com/artstorm/wp-humans-txt/blob/develop/CONTRIBUTING.md)


== Screenshots ==

1. The admin screen to control the plugin.
2. The built in help texts available from the admin screen.


== Changelog ==

= Version 1.0.3 - 14 Dec 2015 =
 * Updates translatable strings to be Language Pack compatible.

= Version 1.0.2 - 11 Sep 2014 =
 * Added Swedish translation.

= Version 1.0.1 - 17 Apr 2014 =
 * Bugfix: Asset files were not loaded if folder name was changed.

= Version 1.0 - 16 Apr 2013 =
 * Adds a button to the plugin admin to quickly view the current humans.txt.
 * Adds an insert button for a base template to the plugin admin.
 * Adds more help sections and elaborates more on the help texts available from
   the admin screen.
 * Adds content type to the author meta link.
 * Changes the plugin name to use capital H.

= Version 0.3 - 16 Apr 2013 =
 * Adds author link to the html head section.
 * Adds selection of humans.txt buttons to display in the wp_footer, linking to
   the humans.txt file.
 * Adds notification message when settings are updated.

= Version 0.2 - 11 Apr 2013 =
 * Adds check so WordPress is properly configured for permalink rewrites.
 * Adds help documentation within the plugin admin.

= Version 0.1 - 11 Apr 2013 =
 * Initial Release.
