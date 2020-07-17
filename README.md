# unidata-jekyll-theme

This repository contains a jekyll theme for Unidata documentation.
This is a fork of the excellent [documentation-theme-jekyll](https://idratherbewriting.com/documentation-theme-jekyll) theme, with Unidata specific styling and extensions.
In order to work with this repository, you will need to install Ruby.

## Installing Ruby
The Jekyll documentation has pointers on how to do that for the [various platforms](https://jekyllrb.com/docs/installation/).
I was able to do this on Windows without any issues following the [RubyInstaller](https://jekyllrb.com/docs/installation/windows/#installation-via-rubyinstaller) instructions.


## Working with this repository

Once you have setup Ruby and cloned the repository, open the command line and go to the root of your local repository and execute the following command:

~~~sh
bundle install
~~~

To live edit the theme in a browser, run:

~~~
bundle exec jekyll clean
bundle exec jekyll serve
~~~

To build the static site, run:

~~~
bundle exec jekyll build
~~~

If you would like to remove any temporairy files generated from the build, run:

~~~
bundle exec jekyll clean
~~~

Edit away, and get your `git` on!

## publishing

### Initial setup

We will be publishing the gem file for our theme to the Unidata [artifacts server](https://artifacts.unidata.ucar.edu/#browse/browse:unidata-gems).
In order to do this, you will need to install the nexus gem:

~~~sh
gem install nexus
~~~

Next, you need to configure the nexus publisher so that it knows about our artifacts server.

First, you will need to increment the version of the gem to be published.
Change the `spec.version` entry in `unidata-jekyll-theme.gemspec` (following [Semantic Versioning](https://semver.org/)).
Next, build the gem file using:

~~~sh
gem build unidata-jekyll-theme.gemspec
~~~

This will create a gem file called `unidata-jekyll-theme-<version>.gem`.

Finally, publish to the Unidata nexus gem repository using

~~~sh
gem nexus gemfile.gem
~~~

The first time you run this command, the nexus gem will ask you for the url of the server you would like to publish to, as well as your credentials.
The url you want to use is `https://artifacts.unidata.ucar.edu/repository/unidata-gems`.
These are cached and reused in the future.

## Using the gem-based theme in your own documentation

Since the Unidata theme gem file is hosted on our artifacts server, you will need to tell your Ruby installation that the artifacts server exists:

~~~sh
gem sources --add https://artifacts.unidata.ucar.edu/repository/gems/
~~~

Once you have done this, you can generally follow the jekyll documentation regarding the installation and use of a [gem based theme](https://jekyllrb.com/docs/themes/#installing-a-theme).
As this theme progresses, we will add more details about Unidata specific extensions to the theme, but for now, consider this a work in progress :-)
