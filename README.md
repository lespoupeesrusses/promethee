# Prométhée
## Brings fire to your pages

## Where does it come from?
As we built sites and digital solutions for some of the most prestigious brands (Givenchy, L’Oréal, Lancôme, Cartier, Hermès…) we often need to build spectacular pages, with a responsive layout, using a predefined design system or visual guidelines. Very often, our clients need to be able to do some creation or adaptation on their own. And in most situation, it has to be translated very easily, with no technical cost.
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
tinymce / trix...
divi
semplice
shogun


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'promethee'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install promethee

## Usage

### Render

The data is:
```ruby
# This could be stored in database
data = [
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
<%= promethee data %>
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

This would allow editing for a page model, with a data attributes as jsonb.
``èrb
<%= form_for @page do |f| %>
    <%= f.text_field :title %>
    <%= f.promethee :data %>
    <%= f.submit %>
<% end %>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/arnaudlevy/promethee. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Promethee project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/arnaudlevy/promethee/blob/master/CODE_OF_CONDUCT.md).
