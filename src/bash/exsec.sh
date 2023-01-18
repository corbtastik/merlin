#!/bin/bash

# Extract section options
input=${input:-null}
output=${output:-null}
width=${width:-100}
height=${height:-100}
x=${x:-0}
y=${y:-0}
date=${date:-$(date +%Y-%m-%d)}

# Parse options
while [ $# -gt 0 ]; do
   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
   fi
  shift
done

# Startup banner
echo "= merlin > exsec ======================================================"
echo "  input:  ${input}"
echo "  output: ${output}"
echo "  width:  ${width}"
echo "  height: ${height}"
echo "  x:      ${x}"
echo "  y:      ${y}"
echo "  date:   ${date}"
echo "======================================================================="

# Input validation
if [ ${input} == "null" ]; then
  echo "Input Error: --input is required"
  echo "      Usage: ./exsec.sh --input myimage.png"
  exit 1
fi

if [ ${output} == "null" ]; then
  echo "Input Error: --output is required"
  echo "      Usage: ./exsec.sh --output myimage-section.png"
  exit 1
fi

magick ${input} -crop ${width}x${height}+${x}+${y} ${output}