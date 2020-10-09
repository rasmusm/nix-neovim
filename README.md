# My WIP neovim config and nix overlay/shell

##install:

```bash
clone https://github.com/rasmusm/nix-neovim.git
ln -s  $(pwd)/nix-neovim $HOME/config/nvim  # optinal to this config as the default $USER config for nvim
```

This are only to help with the examples
```bash
cd nix-neovim           # optinal for examples
export $GITROOT=$(pwd)  # optinal for examples
```

on first run install the plugins with `:PLugInstall`

## Nix stuff

Use the overlay like:
`pkgs = import <nixpkgs> { overlays=[ (import ./pkgs/neovim-overlay.nix) ]; }`
to get set pkgs to <nixpkgs> with nvim overwrite with the new version (see the wiki for an example)

Use the shell.nix by running `nix-shell` (or `nix-shell $GITROOT/shell.nix` if
$PWD are not $GITROOT) get a nix-shell with the new nvim and the dependencies
(not for all lsp, but most)

right now i do not use nix to handle plugins except for the ones there requires building

[niv](https://github.com/nmattia/niv) are used for manage version of sources, except for sumneko-lua-language-server there are using `nix-prefetch-git` until niv supports git submodules.

there are nix packages for some tools/addons in pkgs/

* pkgs/sumneko-lua-language-server.nix for https://github.com/sumneko/lua-language-server
* pkgs/tree_nvim.nix for https://github.com/zgpio/tree.nvim

Thees are not added with the neovim-overlay

## Nvim

I fail in love with the layer system that
[CraftedCart](https://gitlab.com/CraftedCart/dotfiles/-/tree/master/.config/nvim)
have made based on spacemace.

### lua modules and structure

- c/ are general commands and libs
- l/ are layers

#### layers
A layer are like a module but for configs, a layer are a dir under l/ with the name of the layer eg.

`$GITROOT/lua/l/colors/init.lua` are the base of a layer called *colors*

a layer must at lest have this functions (the name layer can be anything and are not exposed):

```lua
local plug = require("c.plug")

local layer = {}

--- Sets plugins required for this layer
function layer.register_plugins()
  plug.add_plugin('romainl/flattened') --example
end

--- Init config for theis layer
function layer.init_config()
  vim.g.ilovenix = 1 -- example
end

return layer
```

they are called at the right time by `c.layer`

To load a new layer simple add `layer.add_layer("l.colors")` to `$GITROOT\lua\init.lua (excthange l.colors with the name of the new layer.

### Plugings

- use `:PlugStatus` to see if the are updates to plugins
- use `:PlugUpdate` to update plugins
- use `:lua require("c.plug").('vim-airline/vim-airline')` insted of `Plug('vim-airline/vim-airline')`

c.layer.lua handels the real call to Plug

## TODO:
 * look at spell checking
 * pick a file manager
 * filetype layers
 * ui / get the windows to allways be where i want then
 * git merge view
 * repl/terminal
 * popup menus in general and on right click, see here for examples:
  * https://github.com/kvngvikram/rightclick-macros
  *
    

