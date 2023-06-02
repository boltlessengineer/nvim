# My Neovim config

## How to install Neovim

```bash
brew install neovim # (v0.8.3)

brew install neovim --HEAD # (v0.9.0)
```

## Dependencies

- ripgrep - optional (for grep in neovim/telescope)
- fd - optional (for telescope)
- sed - optional (for nvim-spectre)

## NOTE

### undercurl in wezterm

See the solution [in wezterm documentation](https://wezfurlong.org/wezterm/faq.html#how-do-i-enable-undercurl-curly-underlines)

## Referenced Configs:

- [LazyVim](https://github.com/LazyVim/LazyVim)
  My config is **heavily** depend on LazyVim. Many util codes are copied from here.
  Also, config structure is highly inspired
- [abiriadev/nvimrc](https://github.com/abiriadev/nvimrc)
  Discord mate's config
- [max397574/ignis-nvim](https://github.com/max397574/ignis-nvim)
  Neorg contributer's config
  Great tree-sitter queries examples & some snippet examples (see: `modules/completion/snippets/init.lua`)
- [JoosepAlviste/dotfiles](https://github.com/JoosepAlviste/dotfiles/blob/master/config/nvim)
  Author of palenightfall theme
- [folke/dot](https://github.com/folke/dot/tree/master/nvim)
- [Integralist/nvim](https://github.com/Integralist/nvim)
  bunch of telescope plugins
  Also, this man has [some useful LuaSnip examples](https://github.com/Integralist/dotfiles/blob/main/.snippets/go.lua)

and more
