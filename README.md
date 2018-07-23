[![Docker Automated build](https://img.shields.io/docker/automated/swalog/tiny-hello.svg?style=for-the-badge)](https://hub.docker.com/r/swalog/tiny-hello/builds/)
[![Docker Build Status](https://img.shields.io/docker/build/swalog/tiny-hello.svg?style=for-the-badge)](https://hub.docker.com/r/swalog/tiny-hello/builds/)
[![MicroBadger Size](https://img.shields.io/microbadger/image-size/swalog/tiny-hello.svg?style=for-the-badge)](https://hub.docker.com/r/swalog/tiny-hello)

# Main feature:
Tiny docker image providing a web-server test, which adds ONLY 18.5 kb on top of busybox.

 - `busybox` base, i.e. usable linux box w/tools
 - `nweb` http-webserver
 - Cronjob that updates landing-page with debug information
 - Access to web-server log at `<SERVER>/nweb.log`

Inspired by [`tutum/hello-world`](https://hub.docker.com/r/tutum/hello-world/), however, instead of building on top of `alpine` and `php`, this uses a modified [`nweb`](https://github.com/swarminglogic/nweb) by Nigel Griffith, built to run on `busybox`, adding only a `18.5 kB` layer, for a grand total of `1.18 MiB`, a `93.4%` size reduction.

# Example usage

`docker run -d -p 8190:80 swalog/tiny-hello`

`curl localhost:8190`

`curl localhost:8190/nweb.log`

# Server log files

These are available through he container log output, as well as the endpoint at `<yourservice>/nweb.log` hosted by the container.

# Built using:

- `nweb` by Nigel Griffith. See https://www.ibm.com/developerworks/systems/library/es-nweb/index.html
- `busybox`, the minimal linux distro


# Changes to [`nweb`](https://github.com/swarminglogic/nweb):

1. Allow serving `.log` files (useful for debugging)

Hit `<endpoint>/nweb.log` to request it from server

# Building docker image


Everything should be ready to build from the initial repostory clone, after initializing submodules:

`git submodule init && git submodule update`

Docker image is also automatically built on dockerhub: https://hub.docker.com/r/swalog/tiny-hello/


# How-to: Rebuilding `nweb` webserver

Dockerfile handles building the webserver executable in a multi-build stage.

Additionally  a pre-compiled version provided in `server` folder. Read on if you want to build it locally, on your own machine.

Run `./build-nweb.sh`, this generates the compiled `nweb` server

This requires several tools:

- `musl-gcc` (`musl-tools` package)
- `strip` (`binutils` package)
- `sstrip` (from `elfkickers`, [website](http://www.muppetlabs.com/~breadbox/software/elfkickers.html))
- `upx` (`upx-ucl` package)

All of these binary size reduction methods have been copied from [sseemayer/mini-helloworld-httpd](https://github.com/sseemayer/mini-helloworld-httpd). Thanks!

# Caveats

This hosts a static page with `hostname` information, as well as listing certain environment variables used by k8s matching regex `^(.*)_PORT_([0-9]*)_(TCP|UDP)`.

To mitigate this, a cron-job is installed that recreates the `index.html` once every minute. Takes order of 2ms to execute.

# TODOs

 - Consider modifying `nweb` to generate webpage at reqest time
