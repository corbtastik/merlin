# Merlin

A collection of image manipulation utilities, most of which use Imagemagick.

* Merlin can be used as a container via Podman or Docker.

## References

1. [imagemagick.org](https://imagemagick.org/)

## Scratch Notes

```bash
# I like this one
convert ./images/crop/welcome-to-marfa-crop-150x90+0+0.png -format "%[fx:255*mean]" info: 
```