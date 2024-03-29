# Trash

When it's too hard to say goodbye... an alternative to `rm`.

A simple command line utility to move files/folders to a "trash" folder before deleting them.

## Usage

From the command line:

```shell
trash [file/directory name(s)]
# example:
trash potentially-important-file.txt
trash this-folder that-folder some-random-file.txt
```

Handles multiple files with the same name

```shell
trash ~/Documents/Groceries/shopping-list.txt
trash ~/Documents/Christmas/shopping-list.txt
trash ~/Documents/AutoParts/shopping-list.txt
```

The trash will contain:

```shell
shopping-list.txt     # originally ~/Documents/Groceries/shopping-list.txt
shopping-list01.txt   # originally ~/Documents/Christmas/shopping-list.txt
shopping-list02.txt   # originally ~/Documents/AutoParts/shopping-list.txt
```

You will find the files that you've trashed in `~/.Trash`.

## Installation

```shell
gem install trash
```

## Contributors

* [ericmathison](https://github.com/ericmathison) (Eric Mathison)
* [brian-davis](https://github.com/brian-davis) (Brian Davis)

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Releasing a new version

* Start a Docker container:

    ```shell
    docker run --rm -it --volume="${PWD}:/app" --workdir /app ruby:2.7 bash
    ```

* Install dependencies:

    ```shell
    bundle install
    ```

* Bump the version in the `VERSION` file.
* Build the gem:

    ```shell
    gem build trash.gemspec
    ```

* Check that it's valid by installing it locally:

    ```shell
    gem install "./trash-$(cat VERSION).gem"
    ```

* Publish it:

    ```shell
    GEM_HOST_API_KEY=TODO gem push "trash-$(cat VERSION).gem"
    ```

* Commit the changes in Git.

    ```shell
    git add -p && git commit --message "Bump version to v$(cat VERSION)"
    ```

* Tag it:

    ```shell
    git tag "v$(cat VERSION)" && git push origin "v$(cat VERSION)"
    ```

## Copyright

Copyright (c) 2010 Lee Jones. See LICENSE for details.
