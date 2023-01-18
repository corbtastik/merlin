#!/bin/bash

# Logoize options
input=${input:-null}
logo=${logo:-null}
output=${output:-null}
format=${format:-png}
gravity=${gravity:-southeast}
geometry=${geometry:-+25+25}
date=${date:-$(date +%Y-%m-%d)}

# Parse options
while [ $# -gt 0 ]; do
   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
   fi
  shift
done

# Input validation
if [ ${logo} == "null" ]; then
  echo "Input Error: --logo is required"
  echo "      Usage: ./logoize.sh --logo mylogo.png"
  exit 1
fi

if [ ${input} == "null" ]; then
  echo "Input Error: --input is required"
  echo "      Usage: ./logoize.sh --input myimage.png"
  exit 1
fi

if [ ${output} == "null" ]; then
  echo "Input Error: --output is required"
  echo "      Usage: ./logoize.sh --output myimage-logoized.png"
  exit 1
fi

# Startup banner
echo "= merlin > logoize ==================================================="
echo "  logo:       ${logo}"
echo "  input:      ${input}"
echo "  output:     ${output}"
echo "  format:     ${format}"
echo "  gravity:    ${gravity}"
echo "  geometry:   ${geometry}"
echo "  date:       ${date}"
echo "======================================================================"

# Imagemagick convert function to add logo
convert ${input} ${logo} \
  -gravity ${gravity} \
  -geometry ${geometry} \
  -format ${format} \
  -composite ${output}
