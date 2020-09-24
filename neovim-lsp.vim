lua << EOF
local nvim_lsp = require'nvim_lsp'

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
  -- mapexpr('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"')
  -- mapexpr('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"')

end


nvim_lsp.ghcide.setup {
  on_attach=custom_attach,
  root_dir = nvim_lsp.util.root_pattern("stack.yaml", "hie-bios", "BUILD.bazel", "cabal.config", "package.yaml", "*.cabal")
}
EOF
" Trigger completion with <Tab>
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
