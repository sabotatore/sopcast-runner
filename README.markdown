SopCast Runner is ruby command line script for running streaming video in external player

[![Code Climate](https://codeclimate.com/github/sabotatore/sopcast-runner.png)](https://codeclimate.com/github/sabotatore/sopcast-runner)

INSTALL
=======

For Ubuntu Precies 12.04 LTS:

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

Already has integration with internet browsers. Stream runs automatically after clicking by sop:// links.

CONFIG
======

You can change default player

    $ sudo gedit /etc/sopcast_runner/sopcast_runner.conf
