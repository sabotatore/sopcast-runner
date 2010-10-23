SopCast Runner is ruby command line script for running streaming video in external player

INSTALL
=======

For Ubuntu Maverick 10.10:

add ppa repository

    $ sudo add-apt-repository ppa:sabotatore/sopcast

install sopcast-runner package
    
    $ sudo apt-get update && sudo apt-get install sopcast-runner

USAGE
=====

    $ sopcast-runner [ChannelURL]

or

    $ sopcast-runner [ChannelId]

INTEGRATE
=========

Integrate with Gnome browsers, such as Firefox or Google Chrome

    $ gconftool-2 -s /desktop/gnome/url-handlers/sop/command '/usr/bin/sopcast-runner %s' --type String
    $ gconftool-2 -s /desktop/gnome/url-handlers/sop/enabled --type Boolean true

CONFIG
======

You can change default player

    $ sudo gedit /etc/sopcast_runner/sopcast_runner.conf
