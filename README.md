# xuantong.nvim · 玄同

A true-color Neovim theme named after *Xuantong* (玄同) in chapter 56 of the
Dao De Jing. It renders Vim's default highlighting with the supplied Dracula
terminal palette, then adds more distinct Tree-sitter colors for Python.

Requires Neovim 0.12 or newer. The theme has no runtime plugin dependencies.
Tree-sitter parsers and queries are installed separately by the user.

For local development, add this directory to `runtimepath` before loading the
theme:

```lua
vim.opt.runtimepath:prepend("/path/to/xuantong.nvim")
vim.o.termguicolors = true
vim.cmd.colorscheme("xuantong")
```

The palette lives in `lua/xuantong/palette.lua`. Shared colors and the
conversion from terminal color numbers live in `highlights.lua`. Language
overrides live in `languages/<language>.lua` and are listed in
`languages/init.lua`. A new language only needs a module when the shared
highlight groups do not provide enough distinction. Parser installation and
Tree-sitter activation remain in the user's Neovim configuration.

Run the standalone smoke test from this directory with:

```sh
nvim --clean -n --headless "+luafile tests/smoke.lua" +qa
```
