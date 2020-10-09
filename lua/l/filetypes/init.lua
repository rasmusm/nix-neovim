local kb = require("c.keybind")
local plug = require("c.plug")

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin('LnL7/vim-nix')
end

function layer.init_config()
end

return layer
