#!/bin/bash

# Logoize options
input=${input:-null}
logo=${logo:-null}
output=${output:-${input}}
output_dir=${output_dir:-./logoize}
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
  echo "      Usage: ./logoize.sh --logo /path/to/mylogo.png"
  exit 1
fi

if [ ${input} == "null" ]; then
  echo "Input Error: --input is required"
  echo "      Usage: ./logoize.sh --input /path/to/myimage.png"
  exit 1
fi

# startup banner
echo "= merlin > logoize ==================================================="
echo "  logo:       ${logo}"
echo "  input:      ${input}"
echo "  output_dir: ${output_dir}"
echo "  output:     ${output_dir}/${output}"
echo "  format:     ${format}"
echo "  date:       ${date}"
echo "======================================================================"

#mkdir -p ${output_dir}
#
#convert ${input} ${logo} \
#  -gravity ${gravity} \
#  -geometry ${geometry} \
#  -format ${format} \
#  -composite ${output_dir}/${output}
