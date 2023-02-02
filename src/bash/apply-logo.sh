#!/bin/bash
#------------------------------------------------------------------------------
# Options apply-logo
#------------------------------------------------------------------------------
input_dir=${input_dir:-null}
output_dir=${output_dir:-null}
logo_black=${logo_black:-null}
logo_white=${logo_white:-null}
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
# Print apply-logo options
#------------------------------------------------------------------------------
echo "= merlin > apply-logo ================================================="
echo "  input_dir:    ${input_dir}"
echo "  output_dir:   ${output_dir}"
echo "  logo_black:   ${logo_black}"
echo "  logo_white:   ${logo_white}"
echo "  date:         ${date}"
echo "======================================================================="
#------------------------------------------------------------------------------
# Input validation, ensure required values are set, otherwise exit.
#------------------------------------------------------------------------------
if [ ${input_dir} == "null" ]; then
  echo "Input Error: --input_dir is required"
  echo "      Usage: ./apply-logo.sh --input_dir /dir/of/images"
  exit 1
fi

if [ ${output_dir} == "null" ]; then
  echo "Input Error: --output_dir is required"
  echo "      Usage: ./apply-logo.sh --output_dir /tmp/images"
  exit 1
fi

if [ ${logo_black} == "null" ]; then
  echo "Input Error: --logo_black is required"
  echo "      Usage: ./apply-logo.sh --logo_black /logos/black-logo.png"
  exit 1
fi

if [ ${logo_white} == "null" ]; then
  echo "Input Error: --logo_white is required"
  echo "      Usage: ./apply-logo.sh --logo_white /logos/white-logo.png"
  exit 1
fi
#------------------------------------------------------------------------------
# Apply logo to all images in ${input_dir}
#------------------------------------------------------------------------------
# Make directory for output images
mkdir -p ${output_dir}
# Get list of images
image_list=(${input_dir}/*)
# Iterate over image_list and apply logo to each one.
for ((i=0; i<${#image_list[@]}; i++)); do
  file_name=$(basename -- "${image_list[$i]}")
  image_ext="${file_name##*.}"
  image_name="${file_name%.*}"
  echo "- merlin > apply-logo -------------------------------------------------"
  echo "  file:       ${image_list[$i]}"
  echo "  image_name: ${image_name}"
  echo "  image_ext:  ${image_ext}"
  echo "-----------------------------------------------------------------------"
  # Resize full-size image
  resize-one.sh --image ${input_dir}/${image_name}.${image_ext} \
    --output_dir ${output_dir} \
    --output_image ${image_name}-resized.${image_ext}
  # Crop out section where logo will go
  crop-one.sh --image ${output_dir}/${image_name}-resized.${image_ext} \
    --output_dir ${output_dir} \
    --output_image ${image_name}-cropped.${image_ext}
  # Get the mean color value of cropped section to determine which logo (black or white) to apply
  mean=`convert ${output_dir}/${image_name}-cropped.${image_ext} -format "%[fx:255*mean]" info:`
  # Truncate the fractional part, not exactly correct rounding but good enough for logoizing
  mean_int=${mean%.*}
  # If section where logo will go is light (> 100) then use black text logo
  if (( ${mean_int} > 100 )); then
    echo "Mean color is ${mean_int}, applying black logo ${logo_black}."
    logoize-one.sh --logo ${logo_black} \
      --image ${output_dir}/${image_name}-resized.${image_ext} \
      --output_dir ${output_dir} \
      --output_image ${image_name}.${image_ext}
  # Else if section where logo will go is dark (<= 100) then use white text logo
  else
    echo "Mean color is ${mean_int}, applying white logo ${logo_white}."
    logoize-one.sh --logo ${logo_white} \
      --image ${output_dir}/${image_name}-resized.${image_ext} \
      --output_dir ${output_dir} \
      --output_image ${image_name}.${image_ext}
  fi
  # Clean up resized and cropped image, keep the one with the logo.
  rm -f ${output_dir}/${image_name}-resized.${image_ext}
  rm -f ${output_dir}/${image_name}-cropped.${image_ext}
done
