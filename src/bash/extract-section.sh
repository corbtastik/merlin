#!/bin/bash
#------------------------------------------------------------------------------
# Options extract-section
#------------------------------------------------------------------------------
input=${input:-null}
output=${output:-null}
width=${width:-100}
height=${height:-100}
x=${x:-0}
y=${y:-0}
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
# Print extract-section options
#------------------------------------------------------------------------------
echo "= merlin > extract-section ============================================"
echo "  input:  ${input}"
echo "  output: ${output}"
echo "  width:  ${width}"
echo "  height: ${height}"
echo "  x:      ${x}"
echo "  y:      ${y}"
echo "  date:   ${date}"
echo "======================================================================="
#------------------------------------------------------------------------------
# Input validation, ensure required values are set, otherwise exit.
#------------------------------------------------------------------------------
if [ ${input} == "null" ]; then
  echo "Input Error: --input is required"
  echo "      Usage: ./extract-section.sh --input myimage.png"
  exit 1
fi

if [ ${output} == "null" ]; then
  echo "Input Error: --output is required"
  echo "      Usage: ./extract-section.sh --output myimage-section.png"
  exit 1
fi
#------------------------------------------------------------------------------
# Extract section from inout image
#------------------------------------------------------------------------------
magick ${input} -crop ${width}x${height}+${x}+${y} ${output}