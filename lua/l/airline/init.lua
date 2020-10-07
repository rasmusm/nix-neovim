local kb = require("c.keybind")
local plug = require("c.plug")

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin('vim-airline/vim-airline')
  plug.add_plugin('vim-airline/vim-airline-themes')
end

function layer.init_config()
  vim.g.airline_powerline_fonts = 1
  vim.g["airline#extensions#tabline#enabled"] = 1
  vim.g.airline_theme = 'solarized_flood'
end

return layer
