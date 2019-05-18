" TODO vimrc done very quickly from ~/.vim/vimrc
" Should be factorized and ~/.vim/vimrc should be improved

" Minimalist config before all
" ————————————————————————————
set nocompatible
filetype plugin indent on
syntax on

" For roast.vim
set hidden

" Plug
" ————

call plug#begin('~/.vim/plugged')
    " Roast
    " https://github.com/sharat87/roast.vim
    " An HTTP client for ViM, that can also be used as a REST client.
    Plug 'sharat87/roast.vim'

    " precision colorscheme for the vim text editor
    " http://ethanschoonover.com/solarized
    " https://github.com/altercation/vim-colors-solarized
    Plug 'altercation/vim-colors-solarized'

  " EasyMotion
  " Vim motions on speed!
  " https://github.com/Lokaltog/vim-easymotion
  Plug 'Lokaltog/vim-easymotion'

  Plug 'majutsushi/tagbar'
  Plug 'sheerun/vim-polyglot', { 'for': ['markdown']}

   map <Leader> <Plug>(easymotion-prefix)
   nmap ,s <Plug>(easymotion-F)
   nmap ,f <Plug>(easymotion-f)
   nmap ,g <Plug>(easymotion-overwin-f2)
   let g:EasyMotion_keys = 'asdfghjklqwertyuiopzxcvbnm'
   let g:Easymotion_do_mapping=0
call plug#end()

" Display
" ————————

" Indiquer le nombre de modification lorsqu'il y en a plus de 0
" suite à une commande
set report=0

set background=dark
let g:solarized_termtrans = 1
colorscheme solarized

" show tabs / nbsp ' ' / trailing spaces
if has("Win32")
    set listchars=tab:--
else
set listchars=nbsp:¬,tab:··,trail:¤,extends:▷,precedes:◁
endif
set list

" Lines, columns and cursor
" —————————————————————————

" SHOW CURRENT LINE :
set cursorline

"SHOW CURRENT COLUMN :
set cursorcolumn

" Show line number
set number
" Show number relative from the cursor
set relativenumber

" Text limit
set textwidth=80

" SHOW CURSOR
highlight Cursor  guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
hi CursorColumn ctermbg=239
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

" highlight the textwidth limit
let &colorcolumn="81,".join(range(81,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27

" Split
" —————

" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

set diffopt=vertical
set visualbell
set showmode
set showcmd


" Search and scroll
" —————————————————

" Recherche en minuscule -> indépendante de la casse,
" une majuscule -> stricte
set smartcase
" Ne jamais respecter la casse
" (attention totalement indépendant du précédent mais de priorité plus faible)
set ignorecase
" Met en évidence TOUS les résultats d'une recherche,
" A consommer avec modération
set hlsearch
" Déplacer le curseur quand on écrit un (){}[]
" (attention il ne s'agit pas du highlight
set showmatch

set virtualedit=block
set scrolloff=5

" http://vim.wikia.com/wiki/Remove_unwanted_spaces
" However, this is a very dangerous autocmd to have as it will always strip trailing whitespace from every file a user saves. Sometimes, trailing whitespace is desired, or even essential in a file so be careful when implementing this autocmd.
autocmd BufWritePre * %s/\s\+$//e

" Reselect visual block after indentation
vnoremap > >gv
vnoremap < <gv

" From http://lambdalisue.hatenablog.com/entry/2013/06/23/071344
" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

nnoremap i :noh<CR>i
nnoremap I :noh<CR>I
nnoremap a :noh<CR>a
nnoremap A :noh<CR>A

" Indentation
" ———————————

" Automatically indent when adding a curly bracket, etc.
set smartindent
" Indispensable pour ne pas tout casser avec ce qui va suivre
set preserveindent
" Largeur de l'autoindentation
set shiftwidth=4
" Arrondit la valeur de l'indentation
set shiftround
" Largeur du caractère tab
set tabstop=4
" Largeur de l'indentation de la touche tab
set softtabstop=4
" Remplace les tab par des expaces
set expandtab ts=4 sw=4 ai
" Do not tab expand on Makefile
autocmd FileType make set noexpandtab shiftwidth=2 softtabstop=0
" 20140901: Add for test.
" redraw only when we need to.
set lazyredraw
" Detection de l'indentation
set cindent

" BACKUP
" —————————————————————————————
" Modif tmp
set swapfile
" Modif tmp
let g:dotvim_backup=expand('$HOME') . '/.vim/backup'
if ! isdirectory(g:dotvim_backup)
    call mkdir(g:dotvim_backup, "p")
endif
set directory=~/.vim/backup

" Backups with persistent undos
" —————————————————————————————
set backup
let g:dotvim_backups=expand('$HOME') . '/.vim/backups'
if ! isdirectory(g:dotvim_backups)
    call mkdir(g:dotvim_backups, "p")
endif
exec "set backupdir=" . g:dotvim_backups
if has('persistent_undo')
    set undofile
    set undolevels=1000
    set undoreload=10000
    exec "set undodir=" . g:dotvim_backups
endif

" Others map
" ——————————

noremap \ ,
noremap <Leader>w :w<CR>
noremap <Leader>W :w !sudo tee % > /dev/null

noremap <Leader>o o<Esc>k
noremap <Leader>O O<Esc>

nnoremap <leader>wwww :w<CR>:b#<CR><C-\><C-n>:bw#<CR>

noremap <Space> <C-d>zz
" http://stackoverflow.com/questions/23189568/control-space-vim-key-binding-in-normal-mode-does-not-work
noremap <NUL> <C-u>zz

" Others Autocmd
" ——————————————

" http://stackoverflow.com/questions/6453595/prevent-vim-from-clearing-the-clipboard-on-exit
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" https://superuser.com/questions/604122/vim-file-name-completion-relative-to-current-file
autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
" https://georgebrock.github.io/talks/vim-completion/
" Autocomplete with dictionary words when spell check is on
set complete+=kspell

"http://vim.wikia.com/wiki/Disable_automatic_comment_insertion This sets up an auto command that fires after any filetype-specific plugin; the command removes the three flags from the 'formatoptions' option that control the automatic insertion of comments. With this in your vimrc, a comment character will not be automatically inserted in the next line under any situation.
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


" Note: FocusGained and FocusLost autocmd seems to be buggy
" https://github.com/neovim/neovim/issues/7578
" https://vi.stackexchange.com/questions/18515/nvim-can-not-detect-focus-change-inside-tmux-sessions/18521
" Therefore I can't redraw on this event.
