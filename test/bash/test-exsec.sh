#!/bin/bash

SRC_BASH=../../src/bash
IMG_DIR=../../images

# Test extracting section with defaults, x=0, y=0, width=100, height=100
${SRC_BASH}/exsec.sh --input ${IMG_DIR}/crater-lake.png --output ./crater-lake-x0-y0-w100-h100.png

# Test extracting section with defaults, x=0, y=0, width=300, height=300
${SRC_BASH}/exsec.sh --input ${IMG_DIR}/crater-lake.png --output ./crater-lake-x0-y0-w300-h300.png --width 300 --height 300

# Test extracting section with defaults, x=824, y=668, width=200, height=100
${SRC_BASH}/exsec.sh --input ${IMG_DIR}/crater-lake.png --output ./crater-lake-x824-y668-w200-h100.png --width 200 --height 100 --x 824 --y 668