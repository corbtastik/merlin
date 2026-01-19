# Merlin - The Image Wizard 🧙‍♂️

**Merlin** is a robust Bash script that uses ImageMagick to batch process photos for the web. It handles resizing, format conversion, and applies a "smart" watermark that automatically switches between black or white text based on the brightness of the image background.

## Features

*   **Batch Processing:** Processes all `jpg`, `png`, and `heic` files in a directory.
*   **Smart Watermarking:** Analyzes the bottom-right corner of each image to detect brightness.
    *   *Light Background* → Applies Black Logo.
    *   *Dark Background* → Applies White Logo.
*   **Web Optimization:** Automatically converts images to JPG (Quality 85).
*   **Resize Modes:**
    *   `fit`: Resizes to a target width while maintaining original aspect ratio (default).
    *   `cover`: Crops and resizes to fill a target width (defaults to 4:5 aspect ratio).
*   **Non-Destructive:** Saves new files with a suffix (e.g., `-merlin.jpg`), leaving originals untouched.

## Prerequisites

You must have **ImageMagick (v7+)** installed on your system.

### macOS (Homebrew)
```bash
brew install imagemagick
```

### sudo apt-get install imagemagick
```bash
sudo apt-get install imagemagick
```

_Note: Ensure the `magick` command is available in your path._

## Installation

1. Download merlin.sh to your project folder.
2. Make the script executable:

```bash
chmod +x merlin.sh
```

3. (Optional) Move it to your global path:

```bash
mv merlin.sh /usr/local/bin/merlin
```

## Usage

### Basic Usage

The simplest way to run Merlin. This uses the default width (1600px) and "fit" style.

```bash
./merlin.sh \
  --input ./photos \
  --logo-white ./assets/logo-white.png \
  --logo-black ./assets/logo-black.png
```

### Advanced Usage

Specify an output directory, a custom width, and use "cover" style crop.

```bash
./merlin.sh \
  --input ./raw-photos \
  --output ./web-ready \
  --width 1080 \
  --style cover \
  --logo-white ./assets/logo-white.png \
  --logo-black ./assets/logo-black.png
```

| Flag | Description | Required? | Default |
| :--- | :--- | :--- | :--- |
| `-i`, `--input` | Directory containing source images. | **Yes** | N/A |
| `--logo-white` | Path to the white version of your watermark. | **Yes** | N/A |
| `--logo-black` | Path to the black version of your watermark. | **Yes** | N/A |
| `-o`, `--output` | Directory to save processed files. | No | Same as Input |
| `-w`, `--width` | Target width in pixels. | No | 1600 |
| `--style` | Resize mode: `fit` or `cover`. | No | fit |
| `--suffix` | String appended to filenames. | No | merlin |

## How it Works

### Resize:
- If Fit: The image is resized so the width matches the argument. The height adjusts automatically to keep the shape.
- If Cover: The image is center-cropped and resized to the target width with a 4:5 aspect ratio (vertical), ideal for social media.

### Analysis:
- Merlin looks at a virtual crop (20% width x 15% height) of the bottom-right corner.
- It calculates the mean brightness (0.0 to 1.0).
- If brightness > 0.4, it assumes the background is light.

### Composite:
- It overlays the appropriate logo (Black for light backgrounds, White for dark).
- Note: The logo is applied at its native resolution. It is not scaled. Ensure your logo files are the pixel size you want them to appear (e.g., 100x45px).

## Example Output

Files are renamed automatically to avoid overwriting originals:

- Source: `IMG_1234.HEIC`
- Output: `IMG_1234-merlin.jpg`