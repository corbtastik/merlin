#!/bin/bash
#------------------------------------------------------------------------------
# Options for resize-one
#------------------------------------------------------------------------------
image=${image:-null}
output_dir=${output_dir:-null}
landscape_width=${landscape_width:-1024}
landscape_height=${landscape_height:-768}
portrait_width=${portrait_width:-1024}
portrait_height=${portrait_height:-1365}
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
file_name=$(basename -- "${image}")
file_ext="${file_name##*.}"
file_name="${file_name%.*}"
orientation=`convert ${image} -format "%[fx:(w/h>1)?1:0]" info:`
[ ${orientation} == 1 ] && orientation_text="landscape" || orientation_text="portrait"
date=${date:-$(date +%Y-%m-%d)}
#------------------------------------------------------------------------------
# Print resize-one options
#------------------------------------------------------------------------------
echo "= merlin > resize-one ================================================="
echo "  image:            ${image}"
echo "  output_dir:       ${output_dir}"
echo "  landscape_width:  ${landscape_width}"
echo "  landscape_height: ${landscape_height}"
echo "  portrait_width:   ${portrait_width}"
echo "  portrait_height:  ${portrait_height}"
echo "  orientation:      ${orientation_text}"
echo "  file_name:        ${file_name}"
echo "  file_ext:         ${file_ext}"
echo "  date:             ${date}"
echo "======================================================================="
#------------------------------------------------------------------------------
# Input validation, ensure required values are set, otherwise exit.
#------------------------------------------------------------------------------
if [ ${image} == "null" ]; then
  echo "Input Error: --image is required"
  echo "      Usage: ./resize-one.sh --image myimage.png"
  exit 1
fi

if [ ${output_dir} == "null" ]; then
  echo "Input Error: --output_dir is required"
  echo "      Usage: ./resize-one.sh --output_dir /tmp/images"
  exit 1
fi
#------------------------------------------------------------------------------
# Resize image based on orientation 1=landscape, 0=portrait or square.
#------------------------------------------------------------------------------
if [[ ${orientation} -eq 1 ]]; then
    convert ${image} \
        -resize ${landscape_width}x${landscape_height}^ \
        -gravity center \
        -extent ${landscape_width}x${landscape_height} \
        ${output_dir}/${file_name}-${landscape_width}x${landscape_height}.${file_ext}
    echo "Resize complete: ${output_dir}/${file_name}-${landscape_width}x${landscape_height}.${file_ext}"
else
    convert ${image} \
        -resize ${portrait_width}x${portrait_height}^ \
        -gravity center \
        -extent ${portrait_width}x${portrait_height} \
        ${output_dir}/${file_name}-${portrait_width}x${portrait_height}.${file_ext}
    echo "Resized complete: ${output_dir}/${file_name}-${portrait_width}x${portrait_height}.${file_ext}"
fi