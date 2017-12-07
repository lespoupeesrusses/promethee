# Refactoring

## The Views

The purpose of our views structure is to bring out:
- **Actions** → *What does it do?*
- **Logic** → *How does it work?*, *What are/mean the rules?*

> Because ?

They are meant to be overwritten, updated, and extended. And so everything need to be clean and have a strong structure which can live for a long time through evolutions.

To do that, we should:
- Wrap everything into **actions**, nothing could exists outside (if we meet a point where actions have to share things, then we might put them in a shared folder).
- Nest things in terms of their **dependencies**

### Actions:

Prométhée does **3 things**:
- It **Show**s data
- It **Edit**s data
- It **Localize**s data

In fact, the two last actions are the same in a CRUD design, but it would be more comfortable for us to separate them because they work very differently and, in a vast majority of cases, will not be attached to the same user status.

Thus we need 3 views **_show.html.erb**, **_edit.html.erb**, and **_localize.html.erb**; and 3 folders **show**, **edit**, and **localize**.

### Logic

Here, logic is to say:
> The navbar is for editing, lets put it in the edit folder.

Or:
> The image component belongs to the component group, so we will put it in a component folder.

The idea is to nest thing in terms of their dependencies: the navbar doesn't exist without the edit view.

Or:
> If the edit action folder has *this* structure, the localize action must have the same. Because they are the same thing, **they are both actions**.

The idea is to keep our project strong and understable, developer-friendly, maintenance-friendly.

### File tree
*Because everything is better with pictures*

```yaml
promethee:
└─ app:
   └─ views:
      └─ promethee:
         ├─ edit:
         │  ├─ component:
         │  │  ├─ _column.html.erb
         │  │  ├─ _image.html.erb
         │  │  ├─ _row.html.erb
         │  │  ├─ _text.html.erb
         │  │  └─ _video.html.erb
         │  ├─ _component.html.erb
         │  ├─ _components.html.erb
         │  ├─ _navbar.html.erb
         │  └─ _toolbar.html.erb
         ├─ localize:
         │  └─ component:
         │     ├─ _column.html.erb
         │     ├─ _image.html.erb
         │     ├─ _row.html.erb
         │     ├─ _text.html.erb
         │     └─ _video.html.erb
         ├─ show:
         │  ├─ component:
         │  │  ├─ _column.html.erb
         │  │  ├─ _image.html.erb
         │  │  ├─ _row.html.erb
         │  │  ├─ _text.html.erb
         │  │  └─ _video.html.erb
         │  ├─ _component.html.erb
         │  └─ _components.html.erb
         ├─ _edit.html.erb
         ├─ _localize.html.erb
         └─ _show.html.erb
```
