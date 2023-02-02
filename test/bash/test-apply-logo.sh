#!/bin/bash
#------------------------------------------------------------------------------
# Unit Test: test-apply-logo.sh
#------------------------------------------------------------------------------
input_dir=../../images/fullsize
output_dir=../../output/test-apply-logo

# Make directory for output images
mkdir -p ${output_dir}

# Get list of images
image_list=(${input_dir}/*)

# Iterate over image_list and apply logo to each one.
for ((i=0; i<${#image_list[@]}; i++)); do
  file_name=$(basename -- "${image_list[$i]}")
  image_ext="${file_name##*.}"
  image_name="${file_name%.*}"
  echo "File:       ${image_list[$i]}"
  echo "Image Name: ${image_name}"
  echo "Image Ext:  ${image_ext}"
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
    echo "Mean color is ${mean_int}, applying black logo."
    logoize-one.sh --logo ../../images/logos/corbs-black.png \
      --image ${output_dir}/${image_name}-resized.${image_ext} \
      --output_dir ${output_dir} \
      --output_image ${image_name}.${image_ext}
  # Else if section where logo will go is dark (<= 100) then use white text logo
  else
    echo "Mean color is ${mean_int}, applying white logo."
    logoize-one.sh --logo ../../images/logos/corbs-white.png \
      --image ${output_dir}/${image_name}-resized.${image_ext} \
      --output_dir ${output_dir} \
      --output_image ${image_name}.${image_ext}
  fi
  # Clean up resized and cropped image, keep the one with the logo.
  rm -f ${output_dir}/${image_name}-resized.${image_ext}
  rm -f ${output_dir}/${image_name}-cropped.${image_ext}
done
