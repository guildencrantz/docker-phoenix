# Usage

## With Access From localhost

    $ run_phoenix.sh

If you want to be able to use `hbase shell`, `sqlline.py`, or your own code running on your own machine to talk to phoenix you'll need the IP of the docker container in your hosts file. You can manually do this, or review the included `run_phoenix.sh` script, which will automate the process for you. This script does modify `/etc/hosts` so will ask you for your sudo password.

## Self-contained access

    $ docker-compose up

If you only intend to use `sqlline.py` from within the phoenix container, or otherwise do everything from within the docker created environment you can just run `docker-compose up`

# Prerequisites

* [docker-compose](https://www.docker.com/docker-compose)

Everything else should be standard bash/gnu utilities.
