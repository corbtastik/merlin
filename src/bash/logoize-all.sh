#!/bin/bash
#------------------------------------------------------------------------------
# Options for logoize-all
#------------------------------------------------------------------------------
input_dir=${input_dir:-null}
output_dir=${output_dir:-null}
logo=${logo:-null}
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
# Print logoize-all options
#------------------------------------------------------------------------------
echo "= merlin > logoize-all ================================================"
echo "  input_dir:  ${input_dir}"
echo "  output_dir: ${output_dir}"
echo "  logo:       ${logo}"
echo "  date:       ${date}"
echo "======================================================================="
#------------------------------------------------------------------------------
# Input validation, ensure required values are set, otherwise exit.
#------------------------------------------------------------------------------
if [ ${input_dir} == "null" ]; then
  echo "Input Error: --input_dir is required"
  echo "      Usage: logoize-all.sh --input_dir /dir/of/images"
  exit 1
fi

if [ ${output_dir} == "null" ]; then
  echo "Input Error: --output_dir is required"
  echo "      Usage: logoize-all.sh --output_dir /tmp/images"
  exit 1
fi

if [ ${logo} == "null" ]; then
  echo "Input Error: --logo is required"
  echo "      Usage: ./logoize-all.sh --logo mylogo.png"
  exit 1
fi
#------------------------------------------------------------------------------
# Resize all images in input_dir
#------------------------------------------------------------------------------
image_list=(${input_dir}/*)
for ((i=0; i<${#image_list[@]}; i++)); do
    echo "Start logoizing: ${image_list[$i]} with logo ${logo}"
    logoize-one.sh --image ${image_list[$i]} \
      --output_dir ${output_dir} \
      --logo ${logo}
    echo "Complete logoizing: ${image_list[$i]}"
done
