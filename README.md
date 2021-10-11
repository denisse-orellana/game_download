# Board Games

This project involves the development of a storage database system about board games which includes images and documents. The storage implementation is made through the Amazon Web Services (AWS).

![game_project](/app/assets/images/game_project.png)

## Ruby & Rails version

* ruby '2.6.1'
* gem 'rails', '~> 5.2.6'

## Ruby & Rails gems

* gem 'image_processing', '~> 1.12'. More information: [Image-processing](https://github.com/janko/image_processing)
* gem 'bootstrap', '~> 4.3.1'. More information: [Bootstrap](http://getbootstrap.com)
* gem 'jquery-rails'. More information: [Jquery-rails](https://github.com/rails/jquery-rails)
* gem "aws-sdk-s3", "~> 1.103". More information: [AWS SDK para Ruby](https://aws.amazon.com/es/sdk-for-ruby/)
* gem "figaro", "~> 1.2". More information: [Figaro](https://github.com/laserlemon/figaro)
* gem "cocoon", "~> 1.2". More information: [Cocoon](https://github.com/nathanvda/cocoon)
* gem "activestorage-validator", "~> 0.1.5". More information: [ActiveStorage Validator](https://github.com/aki77/activestorage-validator)

## Diagram model

The final Game domain model is summarised in the next flowchart:

![game_domain_model](/app/assets/images/game_domain_model.png)

## Defining the model structures

![game_diagram](/app/assets/images/game_diagram.png)

```console
bundle add figaro
bundle exec figaro install
```

To checked the location of the files on the rails console, search for the service url as it follows:

```console
Game.last.box.image.service_url
"https://g46game.s3.amazonaws.com/

Game.last.rule.document.service_url
https://g46game.s3.amazonaws.com/

Game.last.components.last.images.last.service_url
"https://g46game.s3.amazonaws.com/
```