# Tiny-hello

Tiny docker image providing a web-server test

Is based on a minimal web-server implementation [ankushagarwal/nweb](https://github.com/ankushagarwal/nweb)

Inspired by docker image [tutum/hello-world](https://hub.docker.com/r/tutum/hello-world/)

Instead of building on top of `alpine`, and `php`, this uses a modified [`nweb`](https://github.com/swarminglogic/nweb) built to run on `busybox`, for a grand total of `1.92 MiB`, a `93.5%` size reduction.

### Changes to [`nweb`](https://github.com/swarminglogic/nweb):

1. Allows serving `.log` files (useful for debugging)

## Build docker image

Everything should be ready from the initial repostory clone.

    docker build .

## Build `nweb` webserver

A pre-compiled version is already provided in `server` folder. These notes are if you wish to build it yourself.

Initialize the submodule:

    git submodule init
    git submodule update

Run `build-nweb.sh`, this generates the compiled `nweb` server


## Caveats

This hosts a static page with `hostname` information, as well as listing certain environment variables used by k8s matching regex `^(.*)_PORT_([0-9]*)_(TCP|UDP)`.

To mitigate this, a cron-job is installed that recreates the `index.html` once every minute. Takes order of 2ms to execute.

## TODOs

 - Compile `nweb` using a docker container
 - Consider modifying `nweb` to generate webpage at reqest time
