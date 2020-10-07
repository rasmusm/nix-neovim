local kb = require("c.keybind")
local plug = require("c.plug")

local layer = {}

local defColorScheme = ""

--- Returns plugins required for this layer
function layer.register_plugins()

  plug.add_plugin('tomasiser/vim-code-dark')
  plug.add_plugin('mg979/vim-studio-dark')
  -- plug.add_plugin('altercation/vim-colors-solarized')
  plug.add_plugin('arakashic/nvim-colors-solarized') -- upstream plus nvim patch
  plug.add_plugin('lifepillar/vim-solarized8')
  plug.add_plugin('romainl/flattened')
end

function layer.get_default_scheme()
  return defColorScheme
end

function layer.init_config()
  defColorScheme = 'flattened_dark'
  vim.api.nvim_command("colorscheme flattened_dark")
end

return layer
