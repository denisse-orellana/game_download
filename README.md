# Board Games

This project involves the development of a storage database system about board games which includes images and documents. The storage implementation is made through the Active Storage Gem the Amazon Simple Storage Service (Amazon S3).

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
* gem "rails-erd", "~> 1.6". More information: [Rails-erd](https://github.com/voormedia/rails-erd)

## Diagram model

The final Game domain model is summarised in the next flowchart:

![game_domain_model](/app/assets/images/game_domain_model.png)

## Defining the model structures

The model and the relations are specified as it follows:

![game_diagram](/app/assets/images/game_diagram.png)

As it can be seen above, the rule, component and boxes models are part of the game model, and each one of them will have files attached. These are generated as:

```console
rails g scaffold Rule name content game:references
rails g scaffold Component name typecomp:integer game:references
rails g scaffold Box content game:references
rails g scaffold Game title description
```

The associations are added as:

```ruby
class Rule < ApplicationRecord
    belongs_to :game
    has_one_attached :document
end

class Component < ApplicationRecord
    belongs_to :game
    has_many_attached :images
end

class Box < ApplicationRecord
    belongs_to :game
    has_one_attached :image
end

class Game < ApplicationRecord
  has_one :rule, dependent: :destroy
  has_many :components, dependent: :destroy
  has_one :box, dependent: :destroy
end
```

The functionality of the relations can be checked in the rails console:

```console
Game.new.rule
Game.new.components
Game.new.box
```

```console
Rule.new.game
Component.new.game
Box.new.game
```
## Amazon Simple Storage Service (Amazon S3)

First, the gem for AWS SDK is added:

```ruby
gem "aws-sdk-s3"
```

The creation of a Bucket and a User is needed to the implementation of the service. Next, the gem to secure the configuration on Rails applications is added and install:

```console
bundle add figaro
bundle exec figaro install
```

After the configuration of the keys, the location of the files on the rails console can be search for the service url, just as:

```console
Game.last.box.image.service_url
"https://g46game.s3.amazonaws.com/..."

Game.last.rule.document.service_url
https://g46game.s3.amazonaws.com/..."

Game.last.components.last.images.last.service_url
"https://g46game.s3.amazonaws.com/..."
```

## Heroku deployment

The project was uploaded to Heroku. You can see it here: [GamesApp](https://young-river-73372.herokuapp.com/games)

For more information of the project, the step_by_step readme is available.