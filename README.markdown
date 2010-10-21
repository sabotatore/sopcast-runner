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

    $ sopcast-runner [ChannelId]

CONFIG
======

You can change default player

    $ sudo gedit /etc/sopcast_runner/sopcast_runner.conf
