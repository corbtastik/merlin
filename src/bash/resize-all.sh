#!/bin/bash
#------------------------------------------------------------------------------
# Options for resize-all
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
# Print resize-all options
#------------------------------------------------------------------------------
echo "= merlin > resize-all ================================================="
echo "  input_dir:        ${input_dir}"
echo "  output_dir:       ${output_dir}"
echo "  date:             ${date}"
echo "======================================================================="
#------------------------------------------------------------------------------
# Input validation, ensure required values are set, otherwise exit.
#------------------------------------------------------------------------------
if [ ${input_dir} == "null" ]; then
  echo "Input Error: --input_dir is required"
  echo "      Usage: resize-all.sh --input_dir /dir/of/images"
  exit 1
fi

if [ ${output_dir} == "null" ]; then
  echo "Input Error: --output_dir is required"
  echo "      Usage: resize-all.sh --output_dir /tmp/images"
  exit 1
fi
#------------------------------------------------------------------------------
# Resize all images in input_dir
#------------------------------------------------------------------------------
image_list=(${input_dir}/*)
# iterate through array using a counter
for ((i=0; i<${#image_list[@]}; i++)); do
    #do something to each element of array
    echo "Start resizing: ${image_list[$i]}"
    resize-one.sh --image ${image_list[$i]} --output_dir ${output_dir}
    echo "Complete resizing: ${image_list[$i]}"
done
