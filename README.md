# Simple API to resize images

This should have two endpoints:

* An endpoint which will validate your file is an image and return key metadata (filetype, size, dimensions)
* An endpoint which will return a resized version of your image file

## App requirements

- ruby 3.0.2
- [ImageMagick](https://imagemagick.org/index.php)
- gem dependencies

    bundle install

## Run

    ruby app.rb

## Usage

/api/v1/metadata

    curl -X POST -H 'content-type: multipart/form-data' -F file=@data/Greenwich.PNG http://127.0.0.1:4040/api/v1/metadata

/api/v1/resize

    curl -X POST -H 'content-type: multipart/form-data' -F file=@data/Greenwich.PNG http://127.0.0.1:4040/api/v1/resize


## Tests

    rspec --format documentation
    rubocop


## Todo:

- check size of the file
- log errors
- handle_empty_content when empty POST body
- custom ACCEPTED_FORMATS and RESIZE_TO
- check tests coverage
