set nu
set laststatus=2
syntax on
set tabstop=2
set list listchars=tab:>>,space:-
hi NonText    ctermfg=244  guifg=#808080  "rgb=128,128,128
hi SpecialKey ctermfg=244  guifg=#808080  "rgb=128,128,128

packadd vim-jetpack
call jetpack#begin()
  Jetpack 'tani/vim-jetpack'
  Jetpack 'scrooloose/nerdtree'
call jetpack#end()

for name in jetpack#names()
  if !jetpack#tap(name)
    call jetpack#sync()
    break
  endif
endfor

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-d> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
