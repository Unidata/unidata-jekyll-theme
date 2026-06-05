---
title: Adding Custom CSS In Project
last_updated: 2026-06-05
toc: false
sidebar: unidata_sidebar
permalink: custom_css.html
---
You can add custom CSS to your project without having to modify the existing theme.

## Create The `customstyles.css` File

Create `assets/css/customstyles.css` directly in the top level documentation directory:

```none
project_docs/
├── _data/
├── assets/                    <──┐
│   └── css/                   <──┤  Create these
│       └── customstyles.css   <──┘
├── images/
├── pages/
├── Gemfile
├── _config.yml
├── ...
```

## Add Your Custom CSS

Add your custom CSS to the `assets/css/customstyles.css` file you created.
Jekyll will insert this CSS into the main Unidata theme's empty `customstyles.css` file as it compiles the project.
