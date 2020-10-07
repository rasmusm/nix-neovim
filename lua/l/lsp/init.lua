local kb = require("c.keybind")
local plug = require("c.plug")

local layer = {}

--- Returns plugins required for this layer
function layer.register_plugins()
  plug.add_plugin('neovim/nvim-lspconfig')
  plug.add_plugin('nvim-lua/completion-nvim')
  plug.add_plugin('nvim-lua/diagnostic-nvim')
  plug.add_plugin('steelsojka/completion-buffers')
end

function layer.init_config()
  local nvim_lsp = require'nvim_lsp'
  local configs = require'nvim_lsp/configs'
  local util = require'nvim_lsp/util'

  local map = function(type, key, value)
   vim.fn.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
  end

  local mapexpr = function(type, key, value)
   vim.fn.nvim_buf_set_keymap(0,type,key,value,{expr = true, noremap = true, silent = true});
  end

  local custom_attach = function(client)

    vim.wo.signcolumn="yes"
    print("LSP started.");
    require'completion'.on_attach(client)
    require'diagnostic'.on_attach(client)

    map('n','<C-]>','<cmd>lua vim.lsp.buf.definition()<CR>')
    map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
    map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
    map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
    map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
    map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
    map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
    map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
    map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
    map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
    map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
    map('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
    map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
    map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')

    mapexpr('i', '<C-p>', 'completion#trigger_completion()')
    mapexpr('i', '<C-n>', 'completion#trigger_completion()')

    -- Use <Tab> and <S-Tab> to navigate through popup menu
    mapexpr('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"')
    mapexpr('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"')

  end

  configs["nix_language_server_lsp"] = {
    default_config = {
      on_attach=custom_attach;
      cmd = {"/home/rasmusm/builds/nix-language-server/target/debug/nix-language-server"};
      filetypes = {'nix'};
      root_dir = function(fname)
        return util.find_git_ancestor(fname) or vim.loop.os_homedir()
      end;
      settings = {};
    };
  }
  -- Check if it's already defined for when I reload this file.
--nvim_lsp.nix_language_server_lsp.setup{
--  on_attach=custom_attach;
--}

  local function get_lua_runtime()
    local result = {};
    for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
        local lua_path = path .. "/lua/";
        if vim.fn.isdirectory(lua_path) then
            result[lua_path] = true
        end
    end

    -- This loads the `lua` files from nvim into the runtime.
    result[vim.fn.expand("$VIMRUNTIME/lua")] = true

    return result;
  end

  nvim_lsp.sumneko_lua.setup{
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",

          -- TODO: Figure out how to get plugins here.
          -- path = vim.split(package.path, ';'),
          -- path = {package.path},
        },

        completion = {
          -- You should use real snippets
          keywordSnippet = "Disable",
        },

        diagnostics = {
          enable = true,
          disable =  {
            "trailing-space",
          },
          globals = {
              "vim",
          }
        },

        workspace = {
          library = get_lua_runtime(),
          maxPreload = 1000,
          preloadFileSize = 1000,
        },
      }
    },
    cmd = {"lua-lsp"};
    on_attach=custom_attach;
  }

  nvim_lsp.rnix.setup {
    on_attach=custom_attach;
  }

  nvim_lsp.ccls.setup {
    on_attach=custom_attach;
  }

  nvim_lsp.ghcide.setup {
    on_attach=custom_attach,
    root_dir = nvim_lsp.util.root_pattern("stack.yaml", "hie-bios", "BUILD.bazel", "cabal.config", "package.yaml", "*.cabal")
  }
  vim.g.completion_enable_auto_popup = 0

  vim.g.completion_enable_auto_hover = 1

  -- Set completeopt to have a better completion experience
  vim.cmd("set completeopt=menuone,noinsert,noselect")

  -- Avoid showing message extra message when using completion
  vim.cmd("set shortmess+=c")

  vim.g.diagnostic_enable_virtual_text = 1

  vim.g.diagnostic_insert_delay = 1

end

return layer
