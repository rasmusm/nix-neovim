
local kb = require("c.keybind")
local plug = require("c.plug")

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin('voldikss/vim-floaterm')
  plug.add_plugin('hkupty/iron.nvim')
  plug.add_plugin('bfredl/nvim-luadev')
end

function layer.init_config()
  local iron = require('iron')

  iron.core.add_repl_definitions {
    nix = {
      nix = {
        command = {"nix", "repl"}
      }
    },
    bash = {
      mycustom = {
        command = {"bash", "-i"}
      }
    }
  }

  iron.core.set_config {
    -- debug_level = iron.behavior.debug_level.fatal,
    visibility = iron.behavior.visibility.toggle,
    scope = iron.behavior.scope.path_based,
    preferred = {
      bash = "bash",
      nix  = "nix"
    },
    repl_open_cmd = "belowright 10 split"
  }

  vim.g.iron_map_defaults = false
  vim.g.iron_map_extended = false

  local function plugkey(key)
    return '<leader>r' .. key
  end

  kb.nmap(plugkey'r',    '<PLug>(iron-send-motion)')
  kb.vmap(plugkey'r',    '<Plug>(iron-visual-send)')
  kb.nmap(plugkey'l',    '<Plug>(iron-send-line)')
  kb.nmap(plugkey'p',    '<Plug>(iron-repeat-cmd)')
  kb.nmap(plugkey'<CR>', '<Plug>(iron-cr)')
  kb.nmap(plugkey'i',    '<Plug>(iron-interrupt)')
  kb.nmap(plugkey'Q',    '<Plug>(iron-exit)')
  kb.nmap(plugkey'c',    '<Plug>(iron-clear)')
end

return layer
