# Merlin

A collection of image manipulation utilities, most of which use Imagemagick.

* Merlin can be used as a container via Podman or Docker.

## References

1. [imagemagick.org](https://imagemagick.org/)

## Scratch Notes

```bash
# convert to grayscale
convert ./crater-lake-x824-y668-w200-h100.png -colorspace Gray -format "%[fx:quantumrange*image.mean]" info:
convert ./crater-lake-x824-y668-w200-h100.png -colorspace Gray -format "%[mean]" info:
convert ./crater-lake-x824-y668-w200-h100.png -colorspace Gray -format "%[fx:image.mean]" info:
convert ./crater-lake-x824-y668-w200-h100.png -colorspace gray -resize 1x1 -format "%[pixel:p{0,0}]" info:
convert ./crater-lake-x824-y668-w200-h100.png -colorspace Gray -resize 1x1 -format "%[pixel:p{0,0}]" info:
convert ./crater-lake-x824-y668-w200-h100.png -colorspace Gray -scale 1x1! -format "%[pixel:s.p{0,0}]" info:
convert ./crater-lake-x824-y668-w200-h100.png -format "%[mean]" info:
```