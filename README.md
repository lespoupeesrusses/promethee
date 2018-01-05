![Prométhée](https://github.com/lespoupeesrusses/promethee/blob/master/app/assets/images/logo-promethee-vertical.svg)

# Bring fire to your page

[![Maintainability](https://api.codeclimate.com/v1/badges/98a8649f411bc9f50786/maintainability)](https://codeclimate.com/github/lespoupeesrusses/promethee/maintainability)

## Where does it come from?
As we build sites and digital solutions for some of the most prestigious brands (Givenchy, L’Oréal, Lancôme, Cartier, Hermès…) we often need to build spectacular pages, with a responsive layout, using a predefined design system or visual guidelines. Very often, our clients need to be able to do some creation or adaptation on their own. And in most situation, it has to be translated very easily, with no technical cost.

Our first approach was to generate custom templates. For example, 10 years ago, before responsivity, we did a lot of multilingual content for Parfums Lolita Lempicka using a simple read/write system with something like 10 templates. We soon made a “Do what you feel” template, allowing the designer to put fields wherever he needed on the page, but it was completely unusable for people who lacked either design or development background.

We then built a system for Cartier, where the content was made by a designer, then implemented by a front end developer with keys allowing the translation. This was good because creation was very free, but the client could make no content on its own.

We built another tool for Diptyque, with content bricks that we assembled. Basically, it looked like vertical slides doing a nice one-page. It seemed like the perfect solution, but in the end it had so many options it became very hard to use, and still the different pages like quite similar.

Then came the page builder. Inspired by Divi, the idea was to offer rows and columns, based on bootstrap. We built that for Hermès, as one of the different components available to build pages. Translation was fine, responsivity was fine, content was not super simple to do, but still quite simple, and the use of presets provided a good “easy to use” solution.

We re-used the concept for Céline, and realized we had a mis-conception: the builder was the basic page editor, and we could add components in it.

As we needed the solution for 2 projects, and a third one coming, we decided to make it a gem.

Prométhée was born.

## What does it do?
It builds responsive pages!

There are 2 parts: the editor, which lets you build the pages, and the renderer. The pages are stored as json data, which can easily be added to a model in rails, and saved via a regular form.

## How does it relate to existing solutions?

### Regarding wysiwyg editors like tinymce, trix...

It's not only rich text: it lets you build complete pages, with a grid system.

### Regarding page builders like Divi, Semplice, Shogun

It's for Rails (unlike Divi or Semplice which are for Wordpress).
It's open source.
It does not provide as many options, as it's intended to be integrated in a website with specific brand guidelines through some custom css.

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
@import 'material_icons.css'
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
//= require angular-ui-bootstrap
//= require angular-summernote
//= require promethee
//= require promethee-editor
```

With stylesheets set:
```
@import 'bootstrap'
@import 'font-awesome.css'
@import 'material_icons.css'
@import 'summernote'
@import 'promethee'
@import 'promethee-editor'
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
- Hooks (needed for image and video)
- promethee-i18n
- Component versioning
- Edit in a column
- UI and branding
- Gallery
- Menu
- Tab
- Better col sizing/positioning UX
- Grid background helper
- File upload?
- ~~Cover~~
- ~~Chapter (or maybe it's a cover too? *Yes it is, but see next line*)~~
- Section (in order to organize page contents within distincts parts which can be referenced. eg: scrollspy, hyperlink, tabs, ...)
- Utils rake tasks (generate, destroy, override, ...)
- Doc (to be updated in terms of the new component concept and structure)

## Development
After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/lespoupeesrusses/promethee. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct
Everyone interacting in the Promethee project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/lespoupeesrusses/promethee/blob/master/CODE_OF_CONDUCT.md).
