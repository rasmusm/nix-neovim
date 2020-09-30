version 6.0
" vi: tw=76 ts=8
" vim600:fdm=marker fdl=0 fdc=3

" Uses the tricks from http://stackoverflow.com/a/1184897 to do dualplatform
" dropbox sync of vomrc and vimfiles
" Main Setup {{{1

" We'll have to keep this the first, as it canges other
" Settings as well. And NOPE, we DONT want Vim to behave like Vi by
" the way :-)
set nocompatible

" backspace:  '2' allows backspacing over
" indentation, end-of-line, and start-of-line.
" see also "help bs".
set backspace=2

" completion control:
set complete=.,w,b,u,t,i,d,k

" errorbells: damn this beep!  ;-)
set noerrorbells

" esckeys: allow usage of cursor keys within insert mode
" You will find this useful when working, eg, on SunOS.
" not in neovim
"set esckeys

" expandtab:  Expand Tabs?  no!
" This dosn't makes tabs be spaces
set expandtab

" hidden:  Allow "hidden" buffers.  A must-have!
set hidden

" hlsearch :  highlight search - show the current search pattern
" This gets rather annoying FAST!
set nohlsearch

" Add the dash ('-') and the '@' as "letters" to "words".
" This makes it possible to expand email addresses, eg
set iskeyword=@,48-57,_,192-255,@-@

" startofline:  no:  do not jump to first character with page
" commands, ie keep the cursor in the current column.
set nostartofline

" splitbelow:  Create new window below current one.
set splitbelow

" folder
set fdm=marker fdl=0

filetype plugin on
" }}}2

" Looks {{{2

" Line Numbers
set nu
" I like to have vim autoindent my code.
set autoindent

" ruler:       show cursor position?  Yep!
set ruler

" shiftwidth:  Number of spaces to use for each
" insertion of (auto)indent.
set shiftwidth=2

"
set softtabstop=2

" tabstop. A tab should always give 8 characters of space
set tabstop=8

" showcmd: Show current uncompleted command?  Absolutely!
set showcmd

" showmatch: Show the matching bracket for the last ')'
set showmatch

" showmode: Show the current mode?  YEEEEEEEEESSSSSSSSSSS!
set showmode

" background:  Are we using a "light"
" or "dark" background?
" set background=dark
" background
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif
"set t_Co=256
"set t_ut=

set encoding=utf-8

" }}}2
" Files {{{2

" Backups are for whimps }:-)
set nobackup

    " Don't lave the backup files floating around on the disc
    set backupdir=/tmp/
    " Swapdir
    set dir=/tmp/
    " Dictionary file:
    set dictionary=~/.vimdict




" suffixes: Ignore filename with any of these suffixes
"           when using the ":edit" command.
"           Most of these are files created by LaTeX.
set suffixes=.aux,.bak,.dvi,.gz,.idx,.log,.ps,.swp,.tar,.o

" }}}2
" {{{2 GUI Specific Settings

" This forces Vim to have no GUI really. We only run in GUI mode to
" accomodate the use of the more powerful color system
set guioptions='acmtr'

if has('gui_running')
  colorscheme solarized
endif

" }}}2
" VimSpell {{{2
let spell_language_list = "dansk,english" 
let spell_auto_type = ""
" }}}2

" }}}1

" {{{1  Mappings

map <BS> X

"
map [5~ <PageUP>
map [6~ <PageDown>
inoremap <Up> <Up>
inoremap <Down> <Down>
inoremap <PageUp> <PageUp>
inoremap <PageDown> <PageDown>

" from msvim.vim
if has("clipboard")
    " SHIFT-Del are Cut
    vnoremap <S-Del> "+x

    " CTRL-Insert are Copy
    vnoremap <C-Insert> "+y

    " SHIFT-Insert are Paste
    map <S-Insert>		"+gp

    cmap <S-Insert>		<C-R>+

    exe 'inoremap <script> <S-Insert> <C-G>u' . paste#paste_cmd['i']
    exe 'vnoremap <script> <S-Insert>' . paste#paste_cmd['v']
endif

" }}}1

" {{{1 Autocommands

" c/c++
autocmd BufNewfile,BufRead *.c,*.cc,*.cpp,*.C,*.h,*.hh,*.hpp set cindent
autocmd BufNewfile,BufRead *.c,*.cc,*.cpp,*.C,*.h,*.hh,*.hpp set cino=t0,l1

" }}}1

" {{{1 For Syntax highligting:
if has("syntax")
  syntax on
endif

set listchars=tab:->,trail:·
set list
"
" highlight all trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" }}}1

" Abbreviations {{{1

"       A pair of time abbr's
iab Ydatea <C-R>=strftime("%Y%m%d")<CR>
" Example: 20030920

"       A pair of time abbr's
iab Ydate <C-R>=strftime("%Y %b %d")<CR>
" Example:  2003 Sep 20

iab Ytime <C-R>=strftime("%H:%M")<CR>
" Example: 14:28

iab Ydatec <C-R>=strftime("%c")<CR>
" Example: Thu Jun 21 01:44:32 2001

"}}}1
