# Main feature:
Tiny docker image providing a web-server test

Inspired by [`tutum/hello-world`](https://hub.docker.com/r/tutum/hello-world/), however, instead of building on top of `alpine` and `php`, this uses a modified [`nweb`](https://github.com/swarminglogic/nweb) by Nigel Grffith, built to run on `busybox`, for a grand total of `1.52 MiB`, a `91.5%` size reduction.

# Example usage

docker run -d -p :80 swalog/tiny-hello

# Server log files

These are available through he container log output, as well as the endpoint at `<yourservice>/nweb.log`

# Built using:

- `nweb` by Nigel Griffith. See https://www.ibm.com/developerworks/systems/library/es-nweb/index.html
- `busybox`, the minimal linux distro


# Changes to [`nweb`](https://github.com/swarminglogic/nweb):

1. Allow serving `.log` files (useful for debugging)

Hit `<endpoint>/nweb.log` to request it from server

# Building docker image

Everything should be ready to build from the initial repostory clone.

Docker image is also automatically built on dockerhub: https://hub.docker.com/r/swalog/tiny-hello/


# How-to: Rebuilding `nweb` webserver

A pre-compiled version is already provided in `server` folder. These notes are if you wish to build it yourself.

Initialize the submodule: `git submodule init && git submodule update`

Run `./build-nweb.sh`, this generates the compiled `nweb` server


# Caveats

This hosts a static page with `hostname` information, as well as listing certain environment variables used by k8s matching regex `^(.*)_PORT_([0-9]*)_(TCP|UDP)`.

To mitigate this, a cron-job is installed that recreates the `index.html` once every minute. Takes order of 2ms to execute.

# TODOs

 - Compile `nweb` using a docker container
 - Consider modifying `nweb` to generate webpage at reqest time
