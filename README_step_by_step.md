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

For the enum implementation in the model and controller:

```ruby
class Component < ApplicationRecord
  enum typecomp: %w[piece part]
end

class GamesController < ApplicationController
  before_action :set_select, only: %i[ new edit create update ]

  def set_select
    @typecomps = Component.typecomps.keys.to_a
  end
end
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

The partial forms are created to add the new attributes of rule, box and component:

```ruby
# _box_fields.html.erb

<div class="form-group">
    <%= f.label :name %>
    <%= f.text_field :name, class: "form-control" %>
</div>

<div class="form-group">
    <%= f.label :content %>
    <%= f.text_field :content, class: "form-control"  %>
</div>

<div class="form-group">
    <%= f.label :document %>
    <%= f.file_field :document, class: "form-control"  %>
</div
```

```ruby
# _box_fields.html.erb

<div class="form-group">
    <%= f.label :content %>
    <%= f.text_field :content, class: "form-control" %>
</div>

<div class="form-group">
    <%= f.label :image %>
    <%= f.file_field :image, class: "form-control" %>
</div>
```

```ruby
# _component_fields.html.erb

<div class="form-group">
    <%= f.label :name %>
    <%= f.text_field :name, class: "form-control" %>
</div>

<div class="form-group">
    <%= f.label :typecomp %>
    <%= f.select :typecomp, @typecomps, class: "form-control"  %>
</div>

<div class="form-group">
    <%= f.label :images %>
    <%= f.file_field :images, multiple: true, class: "form-control"  %>
</div>

```

Next in the form of Game, the non association for one to one nested attributes is added as:

```ruby
# games/_form.html.erb

<div class="form-group">
  <%= form.label :description %>
  <%= form.text_field :description, class: "form-control" %>
</div>

<div class="field">
  <%= form.fields_for :box do |ff| %>
    <%= render 'box_fields', f: ff %>
  <% end %>
</div>

<div class="field">
  <%= link_to_add_association 'Add box', form, :box, force_non_association_create: true %>
</div>

<div class="field">
  <%= form.fields_for :rule do |ff| %>
    <%= render 'rule_fields', f: ff %>
  <% end %>
</div>

<div class="field">
  <%= link_to_add_association 'Add rule', form, :rule, force_non_association_create: true %>
</div>

<div class="field">
  <%= form.fields_for :components do |ff| %>
    <%= render 'component_fields', f: ff %>
  <% end %>
</div>

<div class="field">
  <%= link_to_add_association 'Add component', form, :components %>
</div>
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

The location of the files can be checked by searching for the service url on the rails console just as:

```console
Game.last.box.image.service_url
"https://g46game.s3.amazonaws.com/..."

Game.last.rule.document.service_url
https://g46game.s3.amazonaws.com/..."

Game.last.components.last.images.last.service_url
"https://g46game.s3.amazonaws.com/..."
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

git push heroku main

heroku run rails db:migrate
```

#### Figaro configuration in Heroku

First unset the variables:

```console
heroku config:unset aws_access_key_id
heroku config:unset aws_secret_access_key
heroku config:unset aws_region
heroku config:unset aws_bucket
```

Then, run this commands in the terminal:
```console
heroku buildpacks:add -i 1 https://github.com/heroku/heroku-buildpack-activestorage-preview
heroku config:set google_analytics_key=UA-35722661-5
figaro heroku:set -e development
```