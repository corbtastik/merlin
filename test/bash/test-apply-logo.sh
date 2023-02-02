#!/bin/bash

IMAGE=../../images/fullsize/granada-theater.png
OUTPUT_DIR=../../output/test-apply-logo
mkdir -p ${OUTPUT_DIR}
resize-one.sh --image ${IMAGE} --output_dir ${OUTPUT_DIR}
crop-one.sh --image ${OUTPUT_DIR}/granada-theater-1024x1365.png --output_dir ${OUTPUT_DIR}
mean=`convert ${OUTPUT_DIR}/granada-theater-1024x1365-crop-150x90+0+0.png -format "%[fx:255*mean]" info:`
echo ${mean}
if (( ${mean} > 127 )); then
  echo "Mean is ${mean}, use black logo."
else
  echo "Mean is ${mean}, use white logo."
fi
