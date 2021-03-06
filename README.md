# Prométhée

[![Maintainability](https://api.codeclimate.com/v1/badges/98a8649f411bc9f50786/maintainability)](https://codeclimate.com/github/lespoupeesrusses/promethee/maintainability)

## Installation
Add these lines to your application's Gemfile:

```ruby
gem 'bootstrap-sass' # For Bootstrap 3 (not with bootstrap 4!)
gem 'bootstrap' # For Bootstrap 4 (not with bootstrap 3!)
gem 'promethee'
```

And then execute:
```bash
$ bundle
```

Add these lines in `config/application.rb`:
```ruby
config.action_view.sanitized_allowed_tags = ['strong', 'em', 'b', 'i', 'p', 'code', 'pre', 'tt', 'samp', 'kbd', 'var', 'sub', 'sup', 'dfn', 'cite', 'big', 'small', 'address', 'hr', 'br', 'div', 'span', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'ul', 'ol', 'li', 'dl', 'dt', 'dd', 'abbr', 'acronym', 'a', 'img', 'blockquote', 'del', 'ins']
config.action_view.sanitized_allowed_attributes = ['href', 'src', 'srcset', 'width', 'height', 'alt', 'cite', 'datetime', 'title', 'class', 'name', 'xml:lang', 'abbr', 'style']
```

## Usage
In this example, we have a page with a title (string) and a data (jsonb) attribute.

### Render
The data is:

```ruby
@page.data = {
  id: 'ero342ezr',
  type: 'page',
  version: 1,
  children: [
    {
      id: '7lebjl4j6',
      type: 'row',
      version: 1,
      children: [
        {
          id: '8lebjl4j6',
          type: 'column',
          version: 1,
          attributes: {
            size: 4,
            offset: 0
          },
          children: [
            {
              id: '9lebjl4j6',
              type: 'text',
              version: 1,
              attributes: {
                body: '<p><b>This</b> is a text</p>'
              }
            },
            {
              id: '12lebjl4j6',
              type: 'image',
              version: 1,
              attributes: {
                src: 'https://c1.staticflickr.com/5/4089/4975306844_f849232195_b.jpg',
                alt: 'Prométhée'
              }
            }
          ]
        }
      ]
    }
  ]
}
```

The view is:

```erb
<%= promethee @page.data %>
```

Which renders to:

```html
<div class="promethee">
  <div class="row promethee__component promethee__component--row">
    <div class="col-md-4 promethee__component promethee__component--col">
      <div class="promethee__component promethee__component--text">
        <p><b>This</b> is a text</p>
      </div>
      <div class="promethee__component promethee__component--image">
        <img src="https://c1.staticflickr.com/5/4089/4975306844_f849232195_b.jpg" alt="Prométhée">
      </div>
    </div>
  </div>
</div>
```

With javascript set:
```
//= require 'bootstrap-sprockets'
//= require @fancyapps/fancybox/dist/jquery.fancybox.min
//= require promethee/fancybox
```

With stylesheets set:
```
@import 'bootstrap-sprockets' // Only Bootstrap 3
@import 'bootstrap'
@import 'font-awesome-sprockets'
@import 'font-awesome'
@import 'font-awesome/shims'
@import 'promethee'
```

### Editor

This would allow editing for a page model, with a jsonb data attribute:

```erb
<%= form_for @page do |f| %>
  <%= f.promethee :data %>
  <%= f.submit %>
<% end %>
```

This would do quite the same thing:

```erb
<form action="/pages" method="post">
  <%= promethee_editor :page, :data, @page.data %>
  <input type="submit">
</form>
```

You can specify a preview url:

```erb
<%= form_for @page do |f| %>
  <%= f.promethee :data, preview_url: some_preview_path %>
  <%= f.submit %>
<% end %>
```

You can specify a back link url to go to when closing the editor without saving:

```erb
<%= form_for @page do |f| %>
  <%= f.promethee :data, back_url: root_path %>
  <%= f.submit %>
<% end %>
```

> In these examples, the `Page` model would need a migration adding a `data` column:
>
> ```ruby
> class AddDataToPages < ActiveRecord::Migration[5.2]
>   def change
>     add_column :pages, :data, :jsonb
>
>     # Or, if jsonb isn't supported by your storage strategy:
>     # add_column :pages, :data, :string
>   end
> end
> ```

With javascript set:
```
//= require jquery
//= require jquery-ui
//= require bootstrap-sprockets
//= require angular
//= require angular-animate
//= require summernote/summernote     // Only Bootstrap 3
//= require summernote/summernote-bs4 // Only Bootstrap 4
//= require activestorage
//= require promethee
```

With stylesheets set:
```
@import 'bootstrap-sprockets' // Only Bootstrap 3
@import 'bootstrap'
@import 'font-awesome-sprockets'
@import 'font-awesome'
@import 'font-awesome/shims'
@import 'summernote'     // Only Bootstrap 3
@import 'summernote-bs4' // Only Bootstrap 4
@import 'promethee'
@import 'promethee-edit'
```

> These require/import statements are quite flexible: if you already use gems or packages which include bootstrap, jquery, summernote... you're likely to be able to use them in place of those included in Prométhée.
ATTENTION: If you use the Pace JS lib it must be required AFTER the promethee lib

#### The editor has components

The component is made of a show and and edit.
The component has to be registered in order to be addable to the page.
In the edit, the component description looks like:
```
{
  name: 'Image',
  thumb: 'http://via.placeholder.com/300x200',
  data: {
    type: 'image',
    attributes: {
      src: 'https://source.unsplash.com/random/1920x1080'
    }
  }
}
```
The name and thumbs are used in the list of components, whereas the data is what will be injected in the page when component is added.

To register a component, the code is:
```javascript
  angular.injector(['ng', 'Promethee']).get('definitions').push({
    name: 'Image',
    thumb: 'http://via.placeholder.com/300x200',
    data: {
      type: 'image',
      attributes: {
        src: 'https://source.unsplash.com/random/1920x1080'
      }
    }
  });
```

#### The editor needs routes to be defined

To provide preview and active storage management features, **Prométhée use a controller which have to be targeted by routes**. The gem provide a shortcut helper to achieve that:

```ruby
# config/routes.rb

Rails.application.routes.draw do
  promethee
  # Equivalent to:
  # namespace :promethee do
  #   post 'preview' => 'promethee#preview', as: :preview
  #   post 'blob' => 'promethee#blob_create'
  #   get 'blob/:id' => 'promethee#blob_show'
  # end
end
```

Since it's just a shortcut calling Rails native methods, this helper consider the route priority order (higher priority at the top, lower at the bottom).

You can specify the namespace path by providing a value to the `path` option:

```ruby
# config/routes.rb

Rails.application.routes.draw do
  promethee path: 'admin/promethee'
  # Equivalent to:
  # namespace :promethee, path: 'admin/promethee', module: nil do
  #   post 'preview' => 'promethee#preview', as: :preview
  #   post 'blob' => 'promethee#blob_create'
  #   get 'blob/:id' => 'promethee#blob_show'
  # end
end
```

#### The editor previews in an iframe

To be able to preview responsivity, there is a POST "promethee/preview" route.
When you send your data, it renders the page in the default layout.

If you want to use a different layout, specify it in your editor's options :

```erb
<%= promethee_editor :page, :data, value: @page.data, back_url: root_path, preview_layout: 'layouts/my-preview' %>
```

This is used to generate a live responsive preview.

### Render localized (l10n)

The page can be localized.

The localization data looks like:
```
@localization.data = {
  version: 1,
  components: [
    {
      id: '9lebjl4j6',
      type: 'text',
      version: 1,
      master_version: 1,
      attributes: {
        body: '<p><b>Ceci</b> est un texte</p>'
      }
    }
  ]
}
```

The view is:

```erb
<%= promethee @page.data, l: @localization.data %>
```

Which renders to:

```html
<div class="promethee">
  <div class="row promethee__component promethee__component--row">
    <div class="col-md-4 promethee__component promethee__component--col">
      <div class="promethee__component promethee__component--text">
        <p><b>Ceci</b> est un texte</p>
      </div>
      <div class="promethee__component promethee__component--image">
        <img src="https://c1.staticflickr.com/5/4089/4975306844_f849232195_b.jpg" alt="Prométhée">
      </div>
    </div>
  </div>
</div>
```

### Edit localization

```erb
<%= form_for @localization do |f| %>
  <%= f.promethee_localizer :data, master: @page.data %>
  <%= f.submit %>
<% end %>
```

This would do quite the same thing:

```erb
<form action="/localization" method="post">
  <%= promethee_localizer :localization, :data, localization_data: @localization.data, master_data: @page.data %>
  <input type="submit">
</form>
```

## Active Storage

Prométhée works natively with Active Storage.

[https://github.com/rails/rails/tree/master/activestorage](Configure it properly.)

## Database

### PostgreSQL

To generate the standard models, you might use this:
```
rails g scaffold Page title:string data:jsonb
rails g scaffold Localization page:references data:jsonb
```
Usually, the Localization will reference a language or a locale, or maybe use a locale stored as a String ("fr-FR").

Add the null false, default '{}' like this:
```
class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.string :title
      t.jsonb :data, null: false, default: {}

      t.timestamps
    end
  end
end
```
and this:
```
class CreateLocalizations < ActiveRecord::Migration[5.1]
  def change
    create_table :localizations do |t|
      t.references :page, foreign_key: true
      t.jsonb :data, null: false, default: {}

      t.timestamps
    end
  end
end
```

In the controllers, don't forget to change the params to convert the data from json to a hash:
```
  def page_params
    params.require(:page).permit(:name, :metier, :position, :parent_id, :data).tap { |permitted| permitted[:data] = JSON.parse(params[:page][:data]) }
  end
```

If you want to store true Json (and not a string) in the "data" attribute of the model just include the concern PrometheeData
```
class Page < ApplicationRecord
  include PrometheeData
end
`a `

### SQLite (or other not native json storage)

Prométhée takes a ruby hash.
With Postgresql, there's a native jsonb storage, which results in a ruby hash.
If you use SQLite, you'll store json as string, and will need to convert it to a hash.
The code example below does this properly, with keys as symbols and not as strings.

```erb
JSON.parse(data, symbolize_names: true)
```

### Roadmap
- ~~Gem setup~~
- ~~renderer helper~~
- ~~editor helper (for form tag)~~
- ~~editor helper (for simple form)~~
- ~~Show Row~~
- ~~Show Col~~
- ~~Show Text~~
- ~~Show Image (http)~~
- ~~Show Video (http vimeo / youtube)~~
- ~~Edit Row~~
- ~~Edit Text~~
- ~~Edit Image (http)~~
- ~~Edit Video (http)~~
- ~~Preview in iframe~~
- ~~Preview~~
- ~~Fullscreen~~
- ~~Cover~~
- ~~Chapter (or maybe it's a cover too? *Yes it is, but see next line*)~~
- ~~Grid background helper~
- Section (in order to organize page contents within distincts parts which can be referenced. eg: scrollspy, hyperlink, tabs, ...)
- Hooks (needed for image and video)
- promethee-i18n
- Component versioning
- Edit in a column
- UI and branding
- Gallery
- Menu
- Tab
- Better col sizing/positioning UX
- File upload?
- Utils rake tasks (generate, destroy, override, ...)
- Doc (to be updated in terms of the new component concept and structure)

## Development
After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/lespoupeesrusses/promethee. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct
Everyone interacting in the Promethee project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/lespoupeesrusses/promethee/blob/master/CODE_OF_CONDUCT.md).
