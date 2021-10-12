## Step by Step 

- [Step by Step](#step-by-step)
  * [Models structure](#models-structure)
  * [Permit images and documents](#permit-images-and-documents)
  * [Active Storage Validations](#active-storage-validations)
  * [AWS S3](#aws-s3)
  * [Heroku deployment](#heroku-deployment)

### Models structure

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

### Permit images and documents

To permit the attached files the controller, first this Rails tool and gem are installed:

```console
rails active_storage:install
bundle add image_processing
bundle add cocoon
```

The Cocoon Gem are included for the nested attributes. Then in the Game model:

```ruby
class Game < ApplicationRecord
  has_one :rule, dependent: :destroy
  has_many :components, dependent: :destroy
  has_one :box, dependent: :destroy

  enum typecomp: %w[piece part]

  accepts_nested_attributes_for :rule, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :components, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :box, reject_if: :all_blank, allow_destroy: true
end
```

Next, in the controller:

```ruby
games_controller.rb

class GamesController < ApplicationController
  # GET /games/new
  def new
    @game = Game.new
    @box = Box.new
    @rule = Rule.new
    @component = Component.new
    @game.build_box
    @game.build_rule
    @game.components.build
  end

  # GET /games/1/edit
  def edit
    @box = Box.new
    @rule = Rule.new
    @component = Component.new
    @game.build_box
    @game.build_rule
    @game.components.build
  end

   # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:title, :description, { rule_attributes: [:id, :name, :content, :document, :_destroy] }, { components_attributes: [:id, :name, :typecomp, {images: []}, :_destroy] }, { box_attributes: [:id, :content, :image, :_destroy] } )
    end
```

Then, the attributes can be called from the Game index.

### Active Storage Validations 

It is needed the gem:

```console
bundle add activestorage-validator
```

In each model we validate just as:

```ruby
class Rule < ApplicationRecord
    validates :document, presence: true, blob: { content_type: ['application/pdf'], size_range: 1..5.megabytes }
end

class Box < ApplicationRecord
    validates :image, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }
end

class Component < ApplicationRecord
    validates :images, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }
end
```

### AWS S3

The gems for the AWS and to configurate the keys are added:

```console
bundle add aws-sdk-s3
bundle add figaro
bundle exec figaro install
```

First, the creation of a Bucket and a User is needed to the implementation of the service. Then, we use Figaro to configure the main access keys:

The use of the Amazon server is indicated:

```ruby
# development.rb

config.active_storage.service = :amazon
```

The access keys are specified as:

```ruby
# application.yml

development:
  aws_access_key_id: "#############"
  aws_secret_access_key: "#############"
  aws_region: "#############"
  aws_bucket: "#############"
```

And then call from the storage:

```ruby
# storage.yml

amazon:
  service: S3
  access_key_id: <%= Figaro.env.aws_access_key_id %>
  secret_access_key: <%= Figaro.env.aws_secret_access_key %>
  region: <%= Figaro.env.aws_region %>
  bucket: <%= Figaro.env.aws_bucket %>
```

### Heroku deployment

Gems added to the Gemfile:

```ruby	
gem 'sqlite3', group: :development			
gem 'pg', group: :production			
```

From the terminal:

```console
heroku login
bundle install

heroku create
git remote -v

gi status
git add .
git commit -m "add: initial state"
git log

git push heroku master

heroku run rails db:migrate
```