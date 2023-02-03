#!/bin/bash
#------------------------------------------------------------------------------
# Unit Test: test-apply-logo.sh
#------------------------------------------------------------------------------
input_dir=../../output/dallas
# Get list of images
image_list=(${input_dir}/*)
# Iterate over image_list and apply logo to each one.
for ((i=0; i<${#image_list[@]}; i++)); do
  file_name=$(basename -- "${image_list[$i]}")
  image_ext="${file_name##*.}"
  image_name="${file_name%.*}"
  echo "- name: ${image_name}"
  echo "  src: https://storage.googleapis.com/corbs-foto/dallas/${file_name}"
  echo "  description: ${image_name}"
done