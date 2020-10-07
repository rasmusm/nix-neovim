local kb = require("c.keybind")
local plug = require("c.plug")
local em = require("c.edit_mode")

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin("/nix/store/2z28s52nkkql772h3pz915z1dsc1vlfw-tree_nvim-1.17git/share/vim-plugins/tree.nvim")
  plug.add_plugin("preservim/nerdtree")
  plug.add_plugin('Xuyuanp/nerdtree-git-plugin')
  plug.add_plugin('ryanoasis/vim-devicons')
end

function tfn () print "1" end

--local keymap =
plugin = { }

function plugin.is_directory()
  return true
end

function plugin.openFile()
  print "openfile"
end

function plugin.toggleDir()
  print "toggleDir"
end

function plugin.viewToggle()
  return ":NERDTreeToggle<CR>"
end

function plugin:defaultClick()
  return function ()
    if self.is_directory() then
      self.toggleDir()
    else
      self.openFile()
    end
  end
end

function plugin:genKeyMap()
  local m = require("c.edit_mode")
  return { name="File tree",
    all = {
      ["<leader>n"] = {name="FileTree commands",
        maps = {
          { "", self.viewToggle(), "Toggle"}
        }
      }
    },
    fileTypes = {
      tree = {
        [""] = {name="FileTree commands",
          maps = {
            { "<2-LeftMouse>", self:defaultClick(), "def dooble click" },
            { "<2-LeftMouse>", self:defaultClick(), {mode=m.VISUAL_SELECT }, "def dooble click" },
            { "<CR>",          self:defaultClick(), {}, "Enter"            },
          }
        }
      }
    }
  }
end

function tostringopt (opt)
  local opt = opt or {}
  local str = "{"
  local first = 1
  for k, v in pairs(opt) do
    if first==0 then
      str = str .. ", "
    end
    first = 0
    local s
    if type(v) == "table" and v.map_prefix then
      s=v.map_prefix
    else
      s= tostring(v)
    end
    str = str .. tostring(k) .. "=" .. s
  end
  str = str .. "}"
  return str
end



function setKeyMap (keymap)
  local kb = require("c.keybind")
  local em = require("c.edit_mode")
  function submap(subkeymap)
    for pre, submap in pairs(subkeymap) do
      if not (pre == "") and submap.name then
        --print ("kb.set_group_name(" .. tostring(pre) .. ", " .. tostring(submap.name) .. ")")
      end

      for _, cn in ipairs(submap.maps) do
        local opt = {}
        local name = ""
        local fullkey = pre .. cn[1]
        if cn[3] then
          if type(cn[3]) == "table" then
            opt = cn[3]
            if cn[4] then
              name = cn[4]
            end
          elseif type(cn[3]) == "string" then
            name = cn[3]
          end
        end
        local mode = em.NORMAL
        if opt["mode"] then
          mode = opt["mode"]
        end
        command = cn[2]

        -- bindings
        if type(command) == "string" then
          --print ("kb.bind_command(".. mode.map_prefix .. ", " .. fullkey .. ", " ..  tostring(command) .. ", " .. tostringopt(opt) .. ". " .. name .. ")" )
          kb.bind_command(mode, fullkey, command, opt, name)
        elseif type(command) == "function" then
          --print ("kb.bind_function(".. mode.map_prefix .. ", " .. fullkey .. ", " ..  tostring(command) .. ", " .. tostringopt(opt) .. ". " .. name .. ")" )
        end
      end
    end
  end
  if keymap.all then
    submap(keymap.all)
  end
  if keymap.fileTypes then
    for t, m in pairs(keymap.fileTypes) do
      submap (m)
    end
  end
end

--setKeyMap(plugin:genKeyMap())

function layer.set_keybindings()

  local tt = plugin:genKeyMap()
  print (tt.buffer.keymap.dir())

  for _, v in ipairs(tt.buffer.keymap) do
    print (v)
  end
end

function layer.init_config()
  local tree = require("tree")
  --kb.nmap ('<leader>n', ':NERDTreeToggle<CR>')

  setKeyMap(plugin:genKeyMap())

  -- Array of reg.ex of filenames nerdtree ignores
  vim.g.NERDTreeIgnore = {'\\.pyc$', '\\.hi$', '\\.o$', '\\.git$[[dir]]', '^tags$'}

  -- from http://enigmatrix.me/blog/2019/06/12/my-vim-setup/
  vim.g.NERDTreeShowHidden = 1
  vim.g.NERDTreeMinimalUI = 1
  vim.g.NERDTreeWinPos = 'rightbelow'
  -- vim.g.NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']
  vim.g.NERDTreeStatusline = ''
  -- Automaticaly close nvim if NERDTree is only thing left open
  vim.cmd ('autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif')

  -- vim-devicons
  vim.g.webdevicons_enable = 1
  vim.g.webdevicons_enable_nerdtree = 1
  vim.g.webdevicons_enable_unite = 1
  vim.g.webdevicons_enable_vimfiler = 1
  vim.g.webdevicons_enable_airline_tabline = 1
  vim.g.webdevicons_enable_airline_statusline = 1
  vim.g.webdevicons_enable_ctrlp = 1
  vim.g.webdevicons_enable_flagship_statusline = 1
  vim.g.WebDevIconsUnicodeDecorateFileNodes = 1
  vim.g.WebDevIconsUnicodeGlyphDoubleWidth = 1
  vim.g.webdevicons_conceal_nerdtree_brackets = 1
  vim.g.WebDevIconsNerdTreeAfterGlyphPadding = ' '
  vim.g.WebDevIconsNerdTreeGitPluginForceVAlign = 1
  vim.g.webdevicons_enable_denite = 1
  vim.g.WebDevIconsUnicodeDecorateFolderNodes = 1
  vim.g.DevIconsEnableFoldersOpenClose = 1
  vim.g.DevIconsEnableFolderPatternMatching = 1
  vim.g.DevIconsEnableFolderExtensionPatternMatching = 1
  vim.g.WebDevIconsUnicodeDecorateFolderNodesExactMatches = 1


  vim.g.NERDTreeGitStatusUseNerdFonts = 1
end

return layer
