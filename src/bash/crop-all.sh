#!/bin/bash
#------------------------------------------------------------------------------
# Options for crop-all
#------------------------------------------------------------------------------
input_dir=${input_dir:-null}
output_dir=${output_dir:-null}
#------------------------------------------------------------------------------
# Parse input options
#------------------------------------------------------------------------------
while [ $# -gt 0 ]; do
   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
   fi
  shift
done
#------------------------------------------------------------------------------
# Computed variables from input options
#------------------------------------------------------------------------------
date=${date:-$(date +%Y-%m-%d)}
#------------------------------------------------------------------------------
# Print crop-all options
#------------------------------------------------------------------------------
echo "= merlin > crop-all ==================================================="
echo "  input_dir:        ${input_dir}"
echo "  output_dir:       ${output_dir}"
echo "  date:             ${date}"
echo "======================================================================="
#------------------------------------------------------------------------------
# Input validation, ensure required values are set, otherwise exit.
#------------------------------------------------------------------------------
if [ ${input_dir} == "null" ]; then
  echo "Input Error: --input_dir is required"
  echo "      Usage: crop-all.sh --input_dir /dir/of/images"
  exit 1
fi

if [ ${output_dir} == "null" ]; then
  echo "Input Error: --output_dir is required"
  echo "      Usage: crop-all.sh --output_dir /tmp/images"
  exit 1
fi
#------------------------------------------------------------------------------
# Crop all images in input_dir
#------------------------------------------------------------------------------
image_list=(${input_dir}/*)
for ((i=0; i<${#image_list[@]}; i++)); do
    echo "Start cropping: ${image_list[$i]}"
    crop-one.sh --image ${image_list[$i]} --output_dir ${output_dir}
    echo "Complete cropping: ${image_list[$i]}"
done
