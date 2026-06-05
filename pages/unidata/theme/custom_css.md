---
title: Adding Custom CSS In Project
last_updated: 2026-06-01
toc: false
sidebar: unidata_sidebar
permalink: custom_css.html
---
You can add custom CSS to your project without having to modify the existing theme by following these steps:

1. Create The `customstyles.css` File

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

2. Add Your Custom CSS

   Add your custom CSS to the `assets/css/customstyles.css` file you just created.
   Jekyll will insert the content of this CSS file into the main Unidata theme's `customstyles.css` file as it compiles the project.
