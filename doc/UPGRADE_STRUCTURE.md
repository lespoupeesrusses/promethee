# Upgrade Structure (V4)

## Info

Before Prométhée 4.0, the attributes' data were very simple with simple values:

```json
{
 "image": {
   "id": "X",
   "name": "filename.png"
 },
  "searchable_title": "Lorem ipsum",
  "searchable_body": "<p>Lorem ipsum dolor sit amet</p>",
  "special_question": true
}
```

Problem is, between string and text attributes, we can't use the same sanitization process because of richtexts' HTML special characters.

We introduce a new structure for every component. We also set boolean values to define if the attribute is searchable and/or translatable.

```json
{
  "image": {
    "searchable": false,
    "translatable": false,
    "type": "blob",
    "value": {
      "id": "X",
      "name": "filename.png"
    }
  },
  "title": {
    "searchable": true,
    "translatable": true,
    "type": "string",
    "value": "Lorem ipsum"
  },
  "body": {
    "searchable": true,
    "translatable": true,
    "type": "text",
    "value": "<p>Lorem ipsum dolor sit amet</p>"
  },
  "special_question": {
    "searchable": false,
    "translatable": false,
    "type": "boolean",
    "value": true
  }
}
```

## Rake task

A rake task allows you to upgrade your pages' data structure in your models (master & localizations) : `rake promethee:upgrade_structure[MODEL_NAME]`. Example:

```bash
$ rake promethee:upgrade_structure[Page]
```
