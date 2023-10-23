# Containerized APVAS+

A repository that containerized experiment environment of protocol APVAS+ .

## Preparation

Before building image, please download the archive of [tepla](http://www.cipher.risk.tsukuba.ac.jp/tepla/download.html) first, and place it into `archive` directory.

Also we need docker to be installed.

## Build and run

* Build
    ```bash
    docker build . -t <CONTAINER_NAME>
    ```
* Run (in interactive mode)
    ```bash
    docker run -it <CONTAINER_NAME>
    ```