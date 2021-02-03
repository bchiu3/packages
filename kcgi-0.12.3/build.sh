#!/bin/bash
./configure PREFIX=$(pwd)/../build
bmake
bmake install
