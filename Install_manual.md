# All the things a new Mac needs

* Config Apple account, ensure iCloud done.

* run setup_new_mac.sh
* install my comics mono font (https://www.myfonts.com/account?view=order-history)

* setup mail.app accounts in settings / Internet Accounts
	* sixty4k@gmail.com
	* sixty4k@fastmail.fm (bootyhouse.org and nortoncottage.com)

* create ~/profile.d/local_exports.conf
	* create GH Read Only token https://github.com/settings/tokens
	* add it to local_exports.conf (export GHAPI_KEY=<key material>)

* clone all GH repos (`bin/clone_gh_repos.sh`)

* install driver for Scarlett 6i6 USB:
	https://downloads.focusrite.com/focusrite/scarlett-1st-gen/scarlett-6i6-1st-gen

* Setup Loopback
	* open app to install ACE engine
	* /Library/Application\ Support/Loopback/
	* figure out if I can save the devices plist
		* `plutil -convert xml1 Devices.plist` to make it a xml not a binary
		* `plutil -convert binary1 Devices.plist` to make it binary again

* OBS: Old setup is crufty, need to make a clean new one and save it out.

* OBS Plugins
	*
