#!/bin/bash
#------------------------------------------------------------------------------
# Options for logoize-one
#------------------------------------------------------------------------------
image=${image:-null}
logo=${logo:-null}
output_dir=${output_dir:-null}
format=${format:-png}
gravity=${gravity:-southeast}
geometry=${geometry:-+25+25}
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
date=${date:-$(date +%Y-%m-%d)}
#------------------------------------------------------------------------------
# Print logoize-one options
#------------------------------------------------------------------------------
echo "= merlin > logoize-one ================================================"
echo "  logo:       ${logo}"
echo "  image:      ${image}"
echo "  output_dir: ${output_dir}"
echo "  format:     ${format}"
echo "  gravity:    ${gravity}"
echo "  geometry:   ${geometry}"
echo "  file_name:  ${file_name}"
echo "  file_ext:   ${file_ext}"
echo "  date:       ${date}"
echo "======================================================================"
#------------------------------------------------------------------------------
# Input validation, ensure required values are set, otherwise exit.
#------------------------------------------------------------------------------
if [ ${logo} == "null" ]; then
  echo "Input Error: --logo is required"
  echo "      Usage: ./logoize-one.sh --logo mylogo.png"
  exit 1
fi

if [ ${image} == "null" ]; then
  echo "Input Error: --image is required"
  echo "      Usage: ./logoize-one.sh --image myimage.png"
  exit 1
fi

if [ ${output_dir} == "null" ]; then
  echo "Input Error: --output_dir is required"
  echo "      Usage: ./logoize-one.sh --output_dir myimage-logoized.png"
  exit 1
fi
#------------------------------------------------------------------------------
# Imagemagick convert function to add logo
#------------------------------------------------------------------------------
convert ${image} ${logo} \
  -gravity ${gravity} \
  -geometry ${geometry} \
  -format ${format} \
  -composite \
  ${output_dir}/${file_name}-logoized.${file_ext}
echo "Logoized complete: ${output_dir}/${file_name}-logoized.${file_ext}"
