
set runtimepath^=/home/rasmusm/projects/neovim-conf/
source /home/rasmusm/projects/neovim-conf/neovim-plugs.vim
source /home/rasmusm/projects/neovim-conf/core.vim

set mouse=a

source /home/rasmusm/projects/neovim-conf/neovim-plugins-config.vim
lua require("neovim-lsp")
source /home/rasmusm/projects/neovim-conf/neovim-lsp.vim

let g:completion_enable_auto_popup = 0

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c



