" REMAP KEYBOARD for bépo {{{1
" @FIXME: Detect keyboard layout (qwerty / bépo)
" @TODO: Move it at the end, the config must not be layout dependant.
" I use kind dvorak-fr the «bépo» layout on my keyboard.
source ~/.vim/vimrc.bepo
" remap number for direct access
" source ~/.vim/vimrc.num

" Remapage perso {{{2 

noremap ' `
noremap ` '
"See http://vim.wikia.com/wiki/Using_marks

"j -> ; et réciproquement
noremap j ;
noremap ; j

"Ici, je défini la valeur de mapleader à , car la valeur par défaut,  est loin d’être pratique.
" let mapleader = ',' 
noremap  ,

noremap <Leader>W :w !sudo tee % > /dev/null
noremap <Leader>o o<Esc>k
noremap <Leader>O O<Esc>j

augroup filetype_c
	autocmd!
	autocmd filetype c nnoremap <buffer> <Leader>à i#include <stdlib.h><CR>#include <stdio.h><CR><CR><ESC>
	autocmd filetype c nnoremap <buffer> <Leader>mai iint main (int argc, char *argv[]) {<CR><CR><CR>printf ("

*********************************

");<CR><CR><CR>printf ("

*********************************

");<CR>return 0;<CR>}<ESC>kkkkkki    <ESC>
	autocmd filetype p* nnoremap <buffer> <Leader>à i#!/usr/sbin/python3.4<CR># -*-coding:Utf-8 -*<CR><CR><ESC>
augroup end

nnoremap <leader>t :tabnew 

"http://asktherelic.com/2011/04/02/on-easily-replacing-text-in-vim/
vmap <Leader>r "sy:%s/<C-R>=substitute(@s,"
",'
','g')<CR>/
