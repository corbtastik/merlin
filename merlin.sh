#!/bin/bash

# ==============================================================================
# MERLIN - Image Processor (Fixed with Auto-Orient)
# ==============================================================================

# --- Default Configuration ---
DEFAULT_WIDTH=1600               # Default target width for web
DEFAULT_STYLE="fit"              # Options: "fit" or "cover"
DEFAULT_SUFFIX="merlin"          # Suffix added to processed files
DEFAULT_QUALITY=85               # JPG Quality
LOGO_PADDING=30                  # Pixels from the edge

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# --- Usage ---
usage() {
    echo -e "${BLUE}Merlin - The Image Wizard${NC}"
    echo "Usage: ./merlin [options]"
    echo "  -i, --input <dir>        Directory containing source images"
    echo "  --logo-white <path>      Path to white logo"
    echo "  --logo-black <path>      Path to black logo"
    echo "  -o, --output <dir>       Output directory (optional)"
    echo "  -w, --width <pixels>     Target width (default: $DEFAULT_WIDTH)"
    echo "  --style <mode>           'fit' or 'cover' (default: $DEFAULT_STYLE)"
    exit 1
}

# --- Arguments ---
INPUT_DIR=""
OUTPUT_DIR=""
LOGO_WHITE=""
LOGO_BLACK=""
TARGET_WIDTH=$DEFAULT_WIDTH
RESIZE_STYLE=$DEFAULT_STYLE
SUFFIX=$DEFAULT_SUFFIX

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -i|--input) INPUT_DIR="$2"; shift ;;
        -o|--output) OUTPUT_DIR="$2"; shift ;;
        --logo-white) LOGO_WHITE="$2"; shift ;;
        --logo-black) LOGO_BLACK="$2"; shift ;;
        -w|--width) TARGET_WIDTH="$2"; shift ;;
        --style) RESIZE_STYLE="$2"; shift ;;
        --suffix) SUFFIX="$2"; shift ;;
        -h|--help) usage ;;
        *) echo "Unknown param: $1"; usage ;;
    esac
    shift
done

# --- Validation ---
if [[ -z "$INPUT_DIR" || -z "$LOGO_WHITE" || -z "$LOGO_BLACK" ]]; then
    echo -e "${RED}Error: Input directory and both logos are required.${NC}"
    usage
fi

if [[ -z "$OUTPUT_DIR" ]]; then OUTPUT_DIR="$INPUT_DIR"; fi
mkdir -p "$OUTPUT_DIR"

if ! command -v magick &> /dev/null; then
    echo -e "${RED}Error: ImageMagick (magick) not found.${NC}"; exit 1
fi

# --- Processing ---
echo -e "${BLUE}=== Starting Merlin ===${NC}"
echo "Input:  $INPUT_DIR"
echo "Output: $OUTPUT_DIR"
echo "Style:  $RESIZE_STYLE ($TARGET_WIDTH px)"
echo "----------------------------------------"

find "$INPUT_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.heic" \) | while read -r filepath; do
    
    filename=$(basename "$filepath")
    name="${filename%.*}"
    outfile="$OUTPUT_DIR/${name}-${SUFFIX}.jpg"

    echo -n "Processing $filename... "

    # 1. Determine Resize Args
    if [[ "$RESIZE_STYLE" == "cover" ]]; then
        # Force a 4:5 aspect ratio (common for social) or similar, fitting width
        TARGET_HEIGHT=$(echo "$TARGET_WIDTH * 0.8" | awk '{printf "%.0f", $1}')
        RESIZE_ARG="-resize ${TARGET_WIDTH}x${TARGET_HEIGHT}^ -gravity center -extent ${TARGET_WIDTH}x${TARGET_HEIGHT}"
    else
        # Fit (Default) - Aspect ratio preserved
        RESIZE_ARG="-resize ${TARGET_WIDTH}x>"
    fi

    # 2. Analyze Brightness (Fixed: Logic happens inside Magick now)
    # Returns 1 if Light (>0.4), 0 if Dark
    # ADDED: -auto-orient ensures we analyze the CORRECT bottom right corner
    IS_LIGHT=$(magick "$filepath" \
        -auto-orient \
        $RESIZE_ARG \
        -gravity southeast -crop 20%x15%+0+0 \
        -colorspace Gray -format "%[fx:mean>0.4?1:0]" info:)

    # 3. Select Logo
    if [[ "$IS_LIGHT" -eq 1 ]]; then
        LOGO_TO_USE="$LOGO_BLACK"
        LOGO_COLOR="Black"
    else
        LOGO_TO_USE="$LOGO_WHITE"
        LOGO_COLOR="White"
    fi

    # 4. Process (No logo resizing)
    # ADDED: -auto-orient fixes rotation before composition
    magick "$filepath" \
        -auto-orient \
        $RESIZE_ARG \
        -write mpr:main \
        \( "$LOGO_TO_USE" \) \
        -gravity southeast -geometry +${LOGO_PADDING}+${LOGO_PADDING} \
        -composite \
        -quality $DEFAULT_QUALITY \
        "$outfile"

    echo -e "${GREEN}Done${NC} ($LOGO_COLOR)"

done

echo -e "${BLUE}=== Magic Complete ===${NC}"