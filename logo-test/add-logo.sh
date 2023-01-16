#!/bin/bash

INPUT_FILE=./times-square.png
LOGO_FILE=./corbs-white-100w.png
OUTPUT_FILE=./output/${INPUT_FILE}

mkdir -p ./output

convert ${INPUT_FILE} ${LOGO_FILE} \
  -gravity southeast \
  -geometry +25+25 \
  -format png \
  -composite ${OUTPUT_FILE}

# -------------------------------------------------------------------
# [main] - init and flow
# -------------------------------------------------------------------
main() {
	case "$1" in
		clean) clean ;;
        build) clean && build ;;
        docker-build) docker-build ;;
		run) clean && build && run ;;
        docker-run) docker-run ;;
        upload) clean && build && upload ;;
        post) post $2 ;;
		*)
			echo $"Usage: $0 {clean|build|docker-build|run|docker-run|upload|post}"
			exit 1
	esac
}