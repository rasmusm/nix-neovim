source /home/rasmusm/projects/neovim-conf/plug.vim
call plug#begin('/home/rasmusm/projects/neovim-conf/plugged/')

" Make sure you use single quotes

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ryanoasis/vim-devicons'

Plug 'LnL7/vim-nix'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tomasiser/vim-code-dark'
Plug 'mg979/vim-studio-dark'
"Plug 'altercation/vim-colors-solarized'
Plug 'arakashic/nvim-colors-solarized' " upstream plus nvim patch
Plug 'lifepillar/vim-solarized8'
Plug 'romainl/flattened'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'kdheepak/lazygit.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'steelsojka/completion-buffers'

call plug#end()
