" Trigger completion with <Tab>
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'path', 'buffers']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]
