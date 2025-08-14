# unidata-jekyll-theme and unidata-jekyll-plugins

This repository contains a jekyll theme and associated plugins for Unidata documentation.
This is a fork of the excellent [documentation-theme-jekyll](https://idratherbewriting.com/documentation-theme-jekyll) theme, with Unidata specific styling and extensions.

## Using the gem-based theme in your own documentation

There are two ways to generate jekyll-based documentation using the unidata-jekyll-theme.
The first is using a local Ruby installation, and the second is using Docker.
For information on how to configure and write documentation using the unidata theme and unidata plugin, please visit the [documentation](https://unidata.github.io/unidata-jekyll-theme/).

### Ruby

The jekyll documentation will get you a long way.
Your `Gemfile` should, at a minimum, look like:

```shell
source 'https://artifacts.unidata.ucar.edu/repository/gems/'

gem 'unidata-jekyll-theme', '0.0.6'
gem 'unidata-jekyll-plugins', '0.0.4'
```

Jekyll is listed as a dependency of the `unidata-jekyll-theme`, so you do no need to explicitly list its `gem`.
Check out the [Building and live editing](#Building-and-live-editing) section for information on how to build and live edit jekyll documentation.

### Build docs using docker

To serve the unidata-jekyll-theme using the unidata-jekyll-docs image, go to the top of this repository and run:

```shell
docker run -it --rm -e SRC_DIR="/unidata-jekyll-theme" -v .:/unidata-jekyll-theme -p 4000:4000 docker.unidata.ucar.edu/unidata-jekyll-docs:0.0.6 serve --livereload
```

The SRC_DIR environment variable must be set.
It should be the path to the directory _inside the container_ that holds the jekyll `_config.yml` file.
This should be a directory at or under the bind mount point.

Similarly, to build using the unidata-jekyll-docs image:

```shell
docker run -it --rm -e DOCS_UID=$(id -u) -e SRC_DIR="/unidata-jekyll-theme" -v .:/unidata-jekyll-theme -v ./_site:/site docker.unidata.ucar.edu/unidata-jekyll-docs:0.0.6 build
```

Note the additional bind mount `-v ./_site:/site` and the inclusion of `-e DOCS_UID=$(id -u)`.
The additional bind mount is used define where the rendered documentation should be saved.
The `DOCS_UID` environment variable is used to ensure the permissions of the rendered site files are correct.

#### A note on SRC_DIR

Coordinating `SRC_DIR` and the bind mount containing the necessary files for a successful build can be tricky when the `includecodeblock` functionality of the unidata-jekyll-plugins is used.

For example, to serve the documentation of the netCDF-Java project for live editing, you would run the following from the root directory of the project:

```sh
docker run -it --rm -e SRC_DIR="/netcdf-java/docs/src/site" -v .:/netcdf-java -p 4005:4005 unidata-jekyll-docs:latest serve --livereload
```

Because the netCDF-Java documentation uses code snippets from outside the main documentation directory (`/netcdf-java/docs/src/site`), we have to bind mount the entire project.

## Working with this repository

In order to work with this repository, you will need to install Ruby.

### Installing Ruby
The Jekyll documentation has pointers on how to do that for the [various platforms](https://jekyllrb.com/docs/installation/).
I was able to do this on Windows and Mac without any issues following the [RubyInstaller](https://jekyllrb.com/docs/installation/windows/#installation-via-rubyinstaller) instructions.
The current minimum version of Ruby supported is 3.4.5.

### Building and live editing

Once you have set up Ruby and cloned the repository, open the command line and go to the root of your local repository and execute the following command:

~~~sh
bundle install
~~~

To live edit the theme in a browser, run:

~~~sh
bundle exec jekyll serve --livereload
~~~

You should see something similar to the following:

~~~sh
Configuration file: /unidata-jekyll-theme/_config.yml
 Theme Config file: /unidata-jekyll-theme/_config.yml
            Source: /unidata-jekyll-theme
       Destination: /unidata-jekyll-theme/_site
 Incremental build: disabled. Enable with --incremental
      Generating...
                    done in 0.786 seconds.
 Auto-regeneration: enabled for '/unidata-jekyll-theme'
LiveReload address: http://127.0.0.1:35729
    Server address: http://127.0.0.1:4000
  Server running... press ctrl-c to stop.
~~~

Note the `Server address` in the output - this is where you should point your browser to see a live view of the documentation.
Each time a documentation file is edited and saved, Jekyll will regenerate the html file:

~~~sh
Regenerating: 1 file(s) changed at 2021-04-01 13:35:51
              pages/unidata/DocGuide.md
              ...done in 1.735274 seconds.
~~~

To build the static site, run:

~~~sh
bundle exec jekyll build
~~~

If you would like to remove any temporary files generated from the build, run:

~~~sh
bundle exec jekyll clean
~~~

Edit away, and get your `git` on!

### Potentially useful utilities

The `utilities/` directory contains some potentially useful scripts from the upstream repository for generating tags and pdf docs.
They were sort of cluttering up the main directory of the repo, so I moved them.

### Publishing

#### Initial setup

We will be publishing the gem file for our theme to the Unidata [Nexus Repository Manager server](https://artifacts.unidata.ucar.edu/#browse/browse:gem-unidata).
In order to do this, you will need to install the `nexus` gem:

~~~sh
gem install nexus
~~~

Note, you will need to redo this if you have updated your Ruby installation.

#### Release

Next, you will need to increment the version(s) of the gem(s) to be published.
This github repository manages the generation and publication of two Ruby gems, and each are versioned independently.
A new release of the `unidata-jekyll-plugin` gem will be required any time a change is made to the files under the `_plugins/` directory.
All other changes will require a new release of the `unidata-jekyll-theme` gem.
If you need to make new releases for both gems, start by releasing the `unidata-jekyll-plugin`, as the `unidata-jekyll-theme` depends on it.
The following steps apply for releasing both the `unidata-jekyll-theme` gem as well as the `unidata-jekyll-plugin` gem (with one noted exception).

First, change the `spec.version` entry in `.gemspec` file (following [Semantic Versioning](https://semver.org/)).
Note: if you are updating both gems, you will also need to update the `spec.add_runtime_dependency` entry in `unidata-jekyll-theme.gemspec` to account for the new plugin version.

Next, build the gem file using:

~~~sh
gem build <gem-name>.gemspec
~~~

For example,

~~~sh
gem build unidata-jekyll-plugins.gemspec
~~~

This will create a gem file called `<gem-name>-<version>.gem` (e.g. `unidata-jekyll-plugins-0.0.4.gem`).

Finally, publish the gem file to the Unidata nexus gem repository using

~~~sh
gem nexus <gem-name>-<version>.gem
~~~

For example,

~~~sh
gem nexus unidata-jekyll-plugins-0.0.4.gem
~~~

The first time you run this command, the nexus gem will ask you for the url of the server you would like to publish to, as well as your credentials.
The url you want to use is `https://artifacts.unidata.ucar.edu/repository/gem-unidata`.
These are cached and reused in the future.
