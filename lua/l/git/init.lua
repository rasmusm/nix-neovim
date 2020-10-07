local kb = require("c.keybind")
local plug = require("c.plug")

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin('airblade/vim-gitgutter')
  plug.add_plugin('tpope/vim-fugitive')
  -- requre lazygit
  plug.add_plugin('kdheepak/lazygit.nvim')
end

function layer.init_config()
end

return layer
