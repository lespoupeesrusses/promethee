# Upgrade Blob Data

## Info

Before Prométhée 3.0, blobs' data had this structure:

```json
{
  "id": 42,
  "name": "filename.png"
}
```

Problem is, the route to preview was `/promethee/blob/:id` and was a security vulnerability because we can crawl the blobs by incrementing the param `id`.

Now, we use the signed IDs provided natively by ActiveStorage.

```json
{
  "id": "eyJfcmFpb...",
  "name": "filename.png"
}
```

We now use an helper `blob_from_data` in the components' front view to get blob from this hash. If you have custom components, make sure to use this helper to get blobs.

## Rake task

A rake task allows you to upgrade your blobs' data structure in your master models : `rake promethee:upgrade_blob_data[MODEL_NAME]`. Example:

```bash
$ rake promethee:upgrade_blob_data[Page]
```

Please note that your localizations don't contain blobs' data so it won't be affected.