# Prométhée | Bring fire to your page

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
@page.data = [
  {
    type: 'row',
    children: [
      {
        type: 'col',
        attributes: {
          size: 4,
          offset: 0
        },
        children: [
          {
            type: 'text',
            attributes: {
              body: '<p><b>This</b> is a text</p>'
            }
          },
          {
            type: 'image',
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
```

The view is:

```erb
<%= promethee @page.data %>
```

Which renders to:

```html
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

#### An editor in an iframe

At first, the editor was rendered in the view.
When trying to create a preview, it was impossible to manage responsivity, because it relies on the page width, and the page width does not change.
This is the first problem of the kind, but many others would follow: stylesheet conflicts, bootstrap parameters (number of columns...) conflicts, maybe javascript conflicts...

The solution is to put the editor in an iframe.
The editor creates an iframe.
The global scheme is illustrated in docs/iframe.html.
The idea is to create the angular app inside the iframe so it's completely independant.
Before the form is submit, we take the data from the angular app (through a plain javascript variable) and put it in the form input.

### Roadmap
- ~~Gem setup~~
- renderer helper
- editor helper (for form tag)
- editor helper (for simple form)
- Row
- Col
- Text
- Image (http)
- Video (http)
- Hooks (needed for image and video)
- Gallery
- Menu
- Tab
- Cover
- Chapter (or maybe it's a cover too?)

## Development
After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/arnaudlevy/promethee. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct
Everyone interacting in the Promethee project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/arnaudlevy/promethee/blob/master/CODE_OF_CONDUCT.md).
