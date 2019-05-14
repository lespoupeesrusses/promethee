# Upgrade Table Components

## Info

Before Prométhée 2.0, table component's attributes had this structure:

```json
{
  "attributes": {
    "head": [
      { "searchable_text": "Column 1" },
      { "searchable_text": "Column 2" },
      { "searchable_text": "Column 3" }
    ],
    "body": [
      [
        { "searchable_text": "Text 1" },
        { "searchable_text": "Text 2" },
        { "searchable_text": "Text 3" }
      ],
      [
        { "searchable_text": "Text 4" },
        { "searchable_text": "Text 5" },
        { "searchable_text": "Text 6" }
      ]
    ]
  }
}
```

Problem is, tracking cell's position in the table with index is bad and translations became very complicated. That's why Prométhée 2.0 brings a new structure based on UIDs to identify row & col position.

```json
{
  "attributes": {
    "cols": ["AAA", "CCC", "BBB"],
    "cols_data": {
      "AAA": { "searchable_text": "Column 1" },
      "BBB": { "searchable_text": "Column 2" },
      "CCC": { "searchable_text": "Column 3" }
    },
    "rows": ["YYY", "ZZZ"],
    "rows_data": {
      "ZZZ": {
        "AAA": { "searchable_text": "Text 1" },
        "BBB": { "searchable_text": "Text 2" },
        "CCC": { "searchable_text": "Text 3" }
      },
      "YYY": {
        "AAA": { "searchable_text": "Text 4" },
        "BBB": { "searchable_text": "Text 5" },
        "CCC": { "searchable_text": "Text 6" }
      }
    }
  }
}
```

- `cols` & `rows` : UIDs' list in display's order (they are sortable now)
- `cols_data` & `rows_data` : Table's data (without specific order)

The example above will be displayed like this:

| **Column 1** | **Column 3** | **Column 2** |
|:------------:|:------------:|:------------:|
|    Text 4    |    Text 6    |    Text 5    |
|    Text 1    |    Text 3    |    Text 2    |

## Rake task

A rake task allows you to upgrade your table components' structure in your master models : `rake promethee:clean_localizations[MODEL_NAME]`. Example:

```bash
$ rake promethee:upgrade_table[Page]
```

Please note that your localizations won't be upgraded or modified. You have to do it manually.