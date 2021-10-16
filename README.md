# Simple API to resize images.

This should have two endpoints:

* An endpoint which will validate your file is an image and return key metadata (filetype, size, dimensions)
* An endpoint which will return a resized version of your image file

Focus todo:

* Code clarity
* Smart architectural decisions
* Wise use of encapsulation and abstraction

## Run

## Seolutions to use

* [ImageMagick](https://imagemagick.org/index.php)

    brew install imagemagick
    sudo apt-get install imagemagick

or

* [GraphicsMagick](http://www.graphicsmagick.org/)

    brew install graphicsmagick

### Gems to choose from

[rmagick](https://github.com/rmagick/rmagick)

    brew install pkg-config imagemagick
    sudo apt-get install graphicsmagick

[MiniMagick](https://github.com/minimagick/minimagick)
