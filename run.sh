#!/bin/bash

mkdir -p CMAKE
rm -rf CMAKE/*
rm -rf deps/out
rm -rf deps/src
rm -rf deps/tmp
cd CMAKE
cmake ..
cmake --build . -j $(nproc) --verbose