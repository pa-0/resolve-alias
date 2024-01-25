# resolve-alias

A macOS tool to resolve a Finder alias or bookmark file.

## Building

A [Makefile](./Makefile) is included. Simply run

```shell
make
```

to build the binary and shell completions.

## Usage

```shell
resolve-alias ALIAS_FILE [ALIAS_FILE ...]
```

resolve-alias will resolve each ALIAS_FILE in turn and print the result.

If an alias points to a file on disk, the path is printed. If an alias points to a URL, the URL is printed.

## Example

A [macOS burn folder](https://support.apple.com/guide/mac-help/create-a-burn-folder-mac-hold-files-cd-dvd-mchlp2806/mac) contains aliases to folders and files rather than the folders and files themselves, making it impossible to use [du](https://ss64.com/mac/du.html) on the burn folder to tell how much space the burn will take.

du on the burn folder like this will only show how much disk space the aliases are taken:

```shell
du -ks "Burn Folder.fpbf"
```

However, you can use resolve-alias:

```shell
find "Burn Folder.fpbf" -type f -print0 | \
    xargs -0 resolve-alias | \
    tr '\n' '\0' | \
    xargs -0 du -ksc
```

This invocation finds all files inside "Burn Foler.fpbf" (which are expected to be aliases), runs them all through resolve-alias, then translates that output into NUL-separated input for xargs one more time to run through du and get disk usage for each referenced file as well as a total.
