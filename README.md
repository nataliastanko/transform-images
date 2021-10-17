# Simple API to resize images

This should have two endpoints:

* An endpoint which will validate your file is an image and return key metadata (filetype, size, dimensions)
* An endpoint which will return a resized version of your image file

Focus todo:

- validate coming params to request
- check size of the file

* Code clarity
* Smart architectural decisions
* Wise use of encapsulation and abstraction

## Run

    ruby app.rb

    curl -i -X POST -H 'content-type: multipart/form-data' -F file=@data/Greenwich.PNG http://127.0.0.1:4040/api/v1/validate
    curl -X POST -H 'content-type: multipart/form-data' -F file=@data/Greenwich.PNG http://127.0.0.1:4040/api/v1/validate


### Tests

    rspec --format documentation
    rubocop

## Solutions used

* [ImageMagick](https://imagemagick.org/index.php)
* gem [MiniMagick](https://github.com/minimagick/minimagick)

## Requirements

* [ImageMagick](https://imagemagick.org/index.php)

Install examples

    brew install imagemagick
    sudo apt-get install imagemagick
