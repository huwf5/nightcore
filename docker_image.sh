#!/bin/bash

ROOT_DIR=`realpath .`

function build_nightcore(){
    docker build -t nightcore:latest \
        -f ${ROOT_DIR}/dockerfiles/Dockerfile.nightcore \
        ${ROOT_DIR}
}

function build_launcher(){
    local fprocess_name=$1
    local func_id=$2
    local fprocess_path=$3
    docker build -t ${fprocess_name}:latest \
        --build-arg FPROCESS=${fprocess_path} \
        --build-arg FUNC_ID=${func_id} \
        -f ${ROOT_DIR}/dockerfiles/Dockerfile.launcher \
        ${ROOT_DIR}
}

function build_foo(){
    build_launcher foo 1 examples/c/libfoo.so
}

function build_bar(){
    build_launcher bar 2 examples/c/libbar.so
}

case $1 in
    "nightcore")
        build_nightcore
        ;;
    "launcher")
        build_launcher $2 $3
        ;;
    "foo")
        build_foo
        ;;
    "bar")
        build_bar
        ;;
    *)
        echo "Usage: $0 [nightcore|launcher|foo|bar]"
        ;;
esac
