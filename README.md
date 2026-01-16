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
gem 'unidata-jekyll-plugins', '0.0.4'

git 'https://github.com/Unidata/unidata-jekyll-theme.git', tag: 'v0.0.6' do
  gem 'unidata-jekyll-theme'
  gem 'unidata-jekyll-plugins'
end
```

Note that we used to build and publish .gem files for the theme and plugins to the unidata artifacts server, but no longer do so.

Jekyll is listed as a dependency of the `unidata-jekyll-theme`, so you do not need to explicitly list its `gem`.
Check out the [Building and live editing](#Building-and-live-editing) section for information on how to build and live edit jekyll documentation.

### Build docs using docker

To serve the unidata-jekyll-theme using the unidata-jekyll-docs image, go to the top of this repository and run:

```shell
docker run -it --rm -e SRC_DIR="/unidata-jekyll-theme" -v .:/unidata-jekyll-theme -p 4000:4000 docker.io/unidata/unidata-jekyll-docs:0.0.6 serve --livereload
```

The SRC_DIR environment variable must be set.
It should be the path to the directory _inside the container_ that holds the jekyll `_config.yml` file.
This should be a directory at or under the bind mount point.

Similarly, to build using the unidata-jekyll-docs image:

```shell
docker run -it --rm -e DOCS_UID=$(id -u) -e SRC_DIR="/unidata-jekyll-theme" -v .:/unidata-jekyll-theme -v ./_site:/site docker.io/unidata/unidata-jekyll-docs:0.0.6 build
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

To work with this repository, you will need to install Ruby.

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

## Release

To release a new version of the theme, bump the versions in the .gemspec files as needed.
Update the tag referenced in example Gemfile in this README.md document, as well as `docker/Gemfile` and any other references to the theme version.
Commit the changes, push to GitHub and create a PR.
Once the changes are merged, create a new release on GitHub.
Finally, pull down the new tag and build/publish the docker images as described in docker/README.md.
Note: while the gemspecs are versioned independently, the theme is accessed based on the version of the GitHub release.
