#!/bin/bash

testing() {
    local source_image=$1
    local landscape_width=$2
    local landscape_height=$3
    landscape_width=${landscape_width:-1024}
    landscape_height=${landscape_height:-768}
    echo "source_image=${source_image}"
    echo "landscape_width=${landscape_width}"
    echo "landscape_height=${landscape_height}"
}

testing "my-image-01.png" 1000 500
testing "my-image-02.png" 1000