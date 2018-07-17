# Tiny-hello

Tiny docker image providing a web-server test

Is based on a minimal web-server implementation [shefeng/tiny-web-server](https://github.com/shenfeng/tiny-web-server)

Inspired by docker image [tutum/hello-world](https://hub.docker.com/r/tutum/hello-world/)

Instead of building on top of `alpine`, and `php`, this uses a modified [`tiny-web-server`](https://github.com/swarminglogic/tiny-web-server) built to run on `busybox`, for a grand total of `1.92 MiB`, a `93.5%` size reduction.

### Changes to [`tiny-web-server`](https://github.com/shenfeng/tiny-web-server):

1. Build static executable for busybox
2. Direct to `index.html` as default
3. Remove directory listing functionality

## Build docker image

Everything should be ready from the initial repostory clone.

    docker build .

## Build `nweb` webserver

A pre-compiled version is already provided in `server` folder. These notes are if you wish to build it yourself.

Initialize the submodule:

    git submodule init
    git submodule update

Run `build-nweb.sh`, this generates the compiled tiny-web-server.

This requires c99

## Caveats

This hosts a static page with `hostname` information, as well as listing certain environment variables used by k8s matching regex `^(.*)_PORT_([0-9]*)_(TCP|UDP)`.

To mitigate this, a cron-job is installed that recreates the `index.html` once every minute. Takes order of 2ms to execute.

## TODOs

 - Compile `tiny` using a docker container
 - Consider modifying `tiny` to generate webpage at reqest time

