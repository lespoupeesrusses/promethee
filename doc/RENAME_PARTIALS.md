# Rename Partials (V5)

## Info

Before Prométhée 5.0, some partials had a dot in their name:
  - `_edit.define.html.erb`
  - `_edit.inspect.html.erb`
  - `_edit.move.html.erb`

Problem is, having dots in partials file names is deprecated (more info (here)[https://github.com/rails/rails/commit/dd9991bac598bb5da312278a749cf85e19b027cc])

To fix this, we simply replace the dot (`.`) by an underscore (`_`).
  - `_edit_define.html.erb`
  - `_edit_inspect.html.erb`
  - `_edit_move.html.erb`

Some other partials were impacted by this change so be careful if you render them on your side:
  - `app/views/promethee/edit/_move_header.html.erb` (old `promethee/edit/move.header`)
  - `app/views/promethee/edit/_move_remove.html.erb` (old `promethee/edit/move.remove`)
  - `app/views/promethee/edit/_inspect_advanced.html.erb` (old `promethee/edit/inspect.advanced`)
  - `app/views/promethee/show/_image_srcset.html.erb` (old `promethee/show/image.srcset`)

You may also have problem with custom preset icon:
  - Before : app/views/promethee/presets/_icon.image-with-text.svg
  - After : app/views/promethee/presets/_icon_image-with-text.svg