call NERDTreeAddKeyMap({
       \ 'key': 'foo',
       \ 'callback': 'NERDTreeEchoPathHandler',
       \ 'quickhelpText': 'echo full path of current node',
       \ 'scope': 'DirNode' })


function! NERDTreeEchoPathHandler(dirnode)
  let path = a:dirnode.path.str()
  let currdir = getcwd()
  execute 'lcd '.path
  wincmd t
  split
  terminal
  execute 'lcd '.currdir
endfunction
