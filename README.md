# Prométhée

[![Maintainability](https://api.codeclimate.com/v1/badges/98a8649f411bc9f50786/maintainability)](https://codeclimate.com/github/lespoupeesrusses/promethee/maintainability)

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'promethee'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install promethee
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

With stylesheets set:
```
@import 'bootstrap'
@import 'font-awesome.css'
@import 'summernote'
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

With javascript set:
```
//= require jquery
//= require jquery-ui
//= require bootstrap
//= require summernote
//= require angular
//= require angular-animate
//= require angular-summernote
//= require ui-sortable
```

With stylesheets set:
```
@import 'bootstrap'
@import 'font-awesome.css'
@import 'summernote'
@import 'promethee'
@import 'promethee-edit'
```

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

#### The editor previews in an iframe

To be able to preview responsivity, there is a POST "promethee/preview" route.
When you send your data, it renders the page in the default layout.

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
