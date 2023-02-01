#!/bin/bash
#------------------------------------------------------------------------------
# Options crop-one
#------------------------------------------------------------------------------
image=${image:-null}
output_dir=${output_dir:-null}
width=${width:-150}  # Width is 1.5 times width of logo
height=${height:-90} # Height is 2 times height of logo
x=${x:-0}
y=${y:-0}
gravity=${gravity:-southeast}
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
# Print crop-one options
#------------------------------------------------------------------------------
echo "= merlin > crop-one =================================================="
echo "  image:      ${image}"
echo "  output_dir: ${output_dir}"
echo "  width:      ${width}"
echo "  height:     ${height}"
echo "  x:          ${x}"
echo "  y:          ${y}"
echo "  gravity:    ${gravity}"
echo "  date:       ${date}"
echo "======================================================================="
#------------------------------------------------------------------------------
# Input validation, ensure required values are set, otherwise exit.
#------------------------------------------------------------------------------
if [ ${image} == "null" ]; then
  echo "Input Error: --image is required"
  echo "      Usage: ./crop-one.sh --image myimage.png"
  exit 1
fi

if [ ${output_dir} == "null" ]; then
  echo "Input Error: --output_dir is required"
  echo "      Usage: ./crop-one.sh --output_dir /tmp/images"
  exit 1
fi
#------------------------------------------------------------------------------
# Extract section from inout image
#------------------------------------------------------------------------------
magick ${image} -gravity ${gravity} \
  -crop ${width}x${height}+${x}+${y} \
  ${output_dir}/${file_name}-crop-${width}x${height}+${x}+${y}.${file_ext}