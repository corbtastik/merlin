#!/bin/bash
#IMAGE=$1
#SQUARE_WIDTH=1024
#SQUARE_HEIGHT=1024
#LANDSCAPE_WIDTH=1024
#LANDSCAPE_HEIGHT=768
#PORTRAIT_WIDTH=1024
#PORTRAIT_HEIGHT=1365
#FILENAME=$(basename -- "${IMAGE}")
#EXTENSION="${FILENAME##*.}"
#FILENAME="${FILENAME%.*}"
INPUT_DIR=../../source-images
OUTPUT_DIR=../../output-images
#------------------------------------------------------------------------------
# resizeOne: Resize one image
# $1: Source image file as a path
#------------------------------------------------------------------------------
resizeOne() {
  local logo=../../images/logo.png
  local source_image=$1
  local landscape_width=$2
  local landscape_height=$3
  local portrait_width=$4
  local portrait_height=$5
  local file_name=$(basename -- "${source_image}")
  local file_ext="${file_name##*.}"
  # 1=landscape, 0=portrait or square
  local orientation=`convert ${source_image} -format "%[fx:(w/h>1)?1:0]" info:`

  file_name="${file_name%.*}"
  landscape_width=${landscape_width:-1024}
  landscape_height=${landscape_height:-768}
  portrait_width=${portrait_width:-1024}
  portrait_height=${portrait_height:-1365}

  echo "source_image=${source_image}"
  echo "file_name=${file_name}"
  echo "file_ext=${file_ext}"
  echo "orientation=${orientation}"
  echo "landscape_width=${landscape_width}"
  echo "landscape_height=${landscape_height}"
  echo "portrait_width=${portrait_width}"
  echo "portrait_height=${portrait_height}"

  if [[ ${orientation} -eq 1 ]]; then
      echo "Source image ${source_image} is landscape orientation, resizing to ${landscape_width}x${landscape_height}"
      convert ${source_image} \
          -resize ${landscape_width}x${landscape_height}^ \
          -gravity center \
          -extent ${landscape_width}x${landscape_height} \
          ${OUTPUT_DIR}/${file_name}-${landscape_width}x${landscape_height}.${file_ext}
      echo "Resized complete: ${OUTPUT_DIR}/${file_name}-${landscape_width}x${landscape_height}.${file_ext}"

      # Imagemagick convert function to add logo
      convert ${OUTPUT_DIR}/${file_name}-${landscape_width}x${landscape_height}.${file_ext} ${logo} \
        -gravity southeast \
        -geometry +25+25 \
        -format ${file_ext} \
        -composite ${OUTPUT_DIR}/${file_name}-logoized.${file_ext}
  else
      echo "Source image ${source_image} is portrait orientation, resizing to ${portrait_width}x${portrait_height}"
      convert ${source_image} \
          -resize ${portrait_width}x${portrait_height}^ \
          -gravity center \
          -extent ${portrait_width}x${portrait_height} \
          ${OUTPUT_DIR}/${file_name}-${portrait_width}x${portrait_height}.${file_ext}
      echo "Resized complete: ${OUTPUT_DIR}/${file_name}-${portrait_width}x${portrait_height}.${file_ext}"

      # Imagemagick convert function to add logo
      convert ${OUTPUT_DIR}/${file_name}-${portrait_width}x${portrait_height}.${file_ext} ${logo} \
        -gravity southeast \
        -geometry +25+25 \
        -format ${file_ext} \
        -composite ${OUTPUT_DIR}/${file_name}-logoized.${file_ext}
  fi
}

resizeAll() {
  image_list=(${INPUT_DIR}/*)
  # iterate through array using a counter
  for ((i=0; i<${#image_list[@]}; i++)); do
      #do something to each element of array
      echo "Start resizing: ${image_list[$i]}"
      resizeOne ${image_list[$i]}
      echo "Complete resizing: ${image_list[$i]}"
  done
}

resizeAll