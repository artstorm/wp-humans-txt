=== WP humans.txt ===
Contributors: artstorm
Donate link: http://johansteen.se/donate/
Tags: humans.txt, credits, humans, txt
Requires at least: 3.3
Tested up to: 3.5.1
Stable tag: 0.3
License: GPLv2 or later
License URI: http://www.gnu.org/licenses/gpl-2.0.html

Generates a virtual humans.txt file according to the specifications at 
humanstxt.org.


== Description ==

The plugin generates a virtual humans.txt file according to the specifications
at humanstxt.org. The virtual file is located at domain.com/humans.txt.

= Features =

* Provides an editor within WordPress admin to edit the humans.txt 'file'.
* Outputs as plain text, with utf-8 encoding.
* The editor allows the usage of the tab key for convenient editing.
* Uses WordPress' system for on screen help documentation.
* Generates a virtual humans.txt, no physical file is created on disk.

= Related Links =

* [Documentation](http://johansteen.se/code/wp-humans-txt/ 
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


== Changelog ==

= Version 0.2 - 11 Apr 2013 =
 * Adds check so WordPress is properly configured for permalink rewrites.
 * Adds help documentation within the plugin admin.

= Version 0.1 - 11 Apr 2013 =
 * Initial Release.
