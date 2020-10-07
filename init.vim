let s:path = expand('<sfile>:p:h')
execute 'set runtimepath^=' . s:path
"execute 'source ' . s:path . '/neovim-plugs.vim'
execute 'source ' . s:path . '/viml/core.vim'

" TODO find a better place
set mouse=a
set inccommand=split

let g:BASE_PATH = s:path

" execute 'source ' . s:path . '/neovim-lsp.vim'
execute 'luafile ' . s:path . '/lua/init.lua'

