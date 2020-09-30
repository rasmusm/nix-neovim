" Nerdtree {{{1

  " https://github.com/scrooloose/nerdtree
  nmap <silent> <Leader>n :NERDTreeToggle<CR>

  " Array of reg.ex of filenames nerdtree ignores
  let NERDTreeIgnore = ['\.pyc$', '\.hi$', '\.o$', '\.git$[[dir]]']

  " from http://enigmatrix.me/blog/2019/06/12/my-vim-setup/
  let g:NERDTreeShowHidden = 1
  let g:NERDTreeMinimalUI = 1
  let g:NERDTreeWinPos = 'rightbelow'
  " let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']
  let g:NERDTreeStatusline = ''
  " Automaticaly close nvim if NERDTree is only thing left open
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim-devicons
  let g:webdevicons_enable = 1
  let g:webdevicons_enable_nerdtree = 1
  let g:webdevicons_enable_unite = 1
  let g:webdevicons_enable_vimfiler = 1
  let g:webdevicons_enable_airline_tabline = 1
  let g:webdevicons_enable_airline_statusline = 1
  let g:webdevicons_enable_ctrlp = 1
  let g:webdevicons_enable_flagship_statusline = 1
  let g:WebDevIconsUnicodeDecorateFileNodes = 1
  let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
  let g:webdevicons_conceal_nerdtree_brackets = 1
  let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
  let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
  let g:webdevicons_enable_denite = 1
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1
  let g:DevIconsEnableFoldersOpenClose = 1
  let g:DevIconsEnableFolderPatternMatching = 1
  let g:DevIconsEnableFolderExtensionPatternMatching = 1
  let WebDevIconsUnicodeDecorateFolderNodesExactMatches = 1


  let g:NERDTreeGitStatusUseNerdFonts = 1

" completion
  let g:completion_enable_auto_popup = 0

  let g:completion_enable_auto_hover = 0

  " Set completeopt to have a better completion experience
  set completeopt=menuone,noinsert,noselect

  " Avoid showing message extra message when using completion
  set shortmess+=c

  let g:diagnostic_enable_virtual_text = 0

  let g:diagnostic_insert_delay = 1

" Airline {{{1

  let g:airline#extensions#tabline#enabled = 1
  " let g:airline_extensions = []
"/  let g:airline_theme = 'codedark'
  let g:airline_theme = 'solarized_flood'

" Colors
colorscheme flattened_dark

 " let g:Vsd.contrast = 2  "" high
