# Neovim Config

To ignore changes to local plugins file. Used for keeping computer specific configs/plugins
```shell
git update-index --assume-unchanged lua/plugins-local.lua
```

## Requirements
* ripgrep - for telescope
* [A patched font](https://www.nerdfonts.com/) - for icons

## Todo
* Automatic updating of comments at `#endif`,
```c
#ifdef FOOBAR
// ...
#endif // FOOBAR
// The text "FOOBAR" above should update when the paring `#ifdef` updates
```
* Correctly indent `#ifdef` blocks
* Fix cmacro indent to not reformat lines, if nothing needs to be changed
