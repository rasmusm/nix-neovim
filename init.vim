let s:path = expand('<sfile>:p:h')
execute 'set runtimepath^=' . s:path
execute 'source ' . s:path . '/neovim-plugs.vim'
execute 'source ' . s:path . '/core.vim'

set mouse=a

execute 'source ' . s:path . '/neovim-plugins-config.vim'
lua require("neovim-lsp")
execute 'source ' . s:path . '/neovim-lsp.vim'

let g:completion_enable_auto_popup = 0

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
