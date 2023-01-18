#!/bin/bash




source_image=$1
landscape_width=$2
landscape_height=$3
portrait_width=$4
portrait_height=$5
file_name=$(basename -- "${source_image}")
file_ext="${file_name##*.}"
# 1=landscape, 0=portrait or square
orientation=`convert ${source_image} -format "%[fx:(w/h>1)?1:0]" info:`

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
else
    echo "Source image ${source_image} is portrait orientation, resizing to ${portrait_width}x${portrait_height}"
    convert ${source_image} \
        -resize ${portrait_width}x${portrait_height}^ \
        -gravity center \
        -extent ${portrait_width}x${portrait_height} \
        ${OUTPUT_DIR}/${file_name}-${portrait_width}x${portrait_height}.${file_ext}
    echo "Resized complete: ${OUTPUT_DIR}/${file_name}-${portrait_width}x${portrait_height}.${file_ext}"
fi