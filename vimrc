" My VIMRC File :
" ---------------
" @Author   : JulioJu
" @Forked version from https://github.com/GuillaumeSeren/vimrc on the 16/10/2015 (Lot of modifications).
" @AUTHOR       : Guillaume Seren ( http://guillaumeseren.com)
" @LICENSE      : www.opensource.org/licenses/bsd-license.php
    " @Link         : https://github.com/juanes10/vimrc
    " ---------------


        " Plugins {{{1
        call plug#begin('~/.vim/plugged')


        " DelimitMate {{{2
        " https://github.com/Raimondi/delimitMate
        " Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc.
        " if has('nvim')
            Plug ('Raimondi/delimitMate')
            autocmd BufReadPost markdown DelimtMateOff

        " IndentLine {{{2
        " A vim plugin to display the indention levels with thin vertical lines A vim plugin to display the indention levels with thin vertical lines u
        " https://github.com/Yggdroot/indentLine
        Plug 'Yggdroot/indentLine'
        let g:indentLine_color_term = 239
        let g:indentLine_color_gui = '#09AA08'
        let g:indentLine_char = '│'

        " Rainbow_parentheses.vim {{{2
        " https://github.com/kien/rainbow_parentheses.vim
        " Better Rainbow Parentheses
        Plug 'junegunn/rainbow_parentheses.vim'
        let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
        au BufEnter * RainbowParentheses

        " Coc.nvim {{{2
        " Intellisense engine for vim8 & neovim, full language server protocol support as VSCode
        Plug 'neoclide/coc.nvim', {
                    \ 'branch': 'release',
                    \ 'for': [
                        \ 'typescript',
                        \'javascript',
                        \'vue',
                        \'json',
                        \'css',
                        \'scss',
                        \'sass',
                        \'less',
                        \'java',
                        \'sh',
                        \'ps1',
                        \'php',
                        \'go',
                        \'typescriptreact',
                    \ ]
                    \ }

        function! CocNvimCustomization()
            command! -nargs=0 CocDetail :call CocAction('diagnosticInfo')
            let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
            let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

            " https://github.com/neoclide/coc.nvim/issues/236
            nmap <silent> ]c <Plug>(coc-diagnostic-next)

            nmap <leader>qf  <Plug>(coc-fix-current)
            nmap <leader>rn <Plug>(coc-rename)


            nmap <silent> gd :Telescope coc definitions<CR>
            nmap <silent> gy :Telescope coc type_definitions<CR>
            nmap <silent> gi :Telescope coc implementations<CR>
            nmap <silent> gr :Telescope coc references<CR>

            command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

            " https://github.com/neoclide/coc.nvim/issues/869
            nmap <silent> K :call CocAction('doHover')<CR>
        endfunction

        autocmd! user coc.nvim call CocNvimCustomization()

        Plug 'fannheyward/telescope-coc.nvim'


        " TComment {{{2
        " An extensible & universal comment vim-plugin that also handles embedded filetypes http://www.vim.org/scripts/script.php?script_id=1173
        " https://github.com/tomtom/tcomment_vim
        Plug 'tomtom/tcomment_vim'
        vnoremap <leader>c :call tcomment#SetOption("count", 2)<CR>gv:TCommentBlock<CR>
        nnoremap <leader>c :TComment<CR>


        " Neoformat {{{2
        " https://github.com/sbdchd/neoformat
        "  A (Neo)vim plugin for formatting code.
        Plug 'sbdchd/neoformat'

        " fzf {{{2
        " A command-line fuzzy finder written in Go
        " https://github.com/junegunn/fzf
        " https://github.com/junegunn/fzf.vim
        " Installé dans le système, vu que c'est un programme système on l'installe avec le système.
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
        Plug 'junegunn/fzf.vim'

        " https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
        command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

        let $FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude '.git' --exclude 'node_modules'"

        " Ripgrep {{{2
        " Use RipGrep in Vim and display results in a quickfix list
        " https://github.com/jremmen/vim-ripgrep
        Plug 'jremmen/vim-ripgrep'

        " Vim ranger {{{2
        " Ranger integration in vim and neovim
        " https://github.com/francoiscabrol/ranger.vim
        Plug 'francoiscabrol/ranger.vim'
        let g:ranger_map_keys = 0

        " Undotree
        " The undo history visualizer for VIM
        " https://github.com/mbbill/undotree
        Plug 'mbbill/undotree'

        " Vim-autoread {{{2
        " https://github.com/djoshea/vim-autoread
        " Have Vim automatically reload a file that has changed externally
        Plug 'djoshea/vim-autoread'

        " MatchTagAlways {{{2
        " https://github.com/Valloric/MatchTagAlways
        " A Vim plugin that always highlights the enclosing html/xml tags
        Plug 'Valloric/MatchTagAlways', {'for ' : ['html', 'php', 'jsp', 'xml', 'xsd', 'dtd', 'xsl']}

        " vim-ipmotion {{{2
        " Improved paragraph motion http://www.vim.org/scripts/script.php?script_id=3952
        " https://github.com/justinmk/vim-ipmotion
        Plug 'justinmk/vim-ipmotion'

        " vim-abolish {{{2
        " abolish.vim: Work with several variants of a word at once
        " https://github.com/tpope/vim-abolish
        Plug 'tpope/vim-abolish'

        " Vim magit {{{2
        " https://github.com/jreybert/vimagit
        " Ease your git workflow within Vim
        Plug 'jreybert/vimagit'
        let g:magit_default_fold_level = 2
        let g:magit_discard_untracked_do_delete=1
        let g:magit_auto_foldopen = 1
        let g:magit_warning_max_lines=500

        " plenary.nvim {{{2
        " https://github.com/nvim-lua/plenary.nvim
        " plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice.
        Plug 'nvim-lua/plenary.nvim'

        " Neogit {{{2
        " https://github.com/TimUntersberger/neogit
        " magit for neovim
        Plug 'TimUntersberger/neogit'

        " Telescope {{{2
        " https://github.com/nvim-telescope/telescope.nvim
        " Find, Filter, Preview, Pick. All lua, all the time.
        Plug 'nvim-telescope/telescope.nvim'

        " diffchar.vim {{{2
        " https://github.com/rickhowe/diffchar.vim
        " Highlight the exact differences, based on characters and words
        " See also https://github.com/neovim/neovim/pull/14537
        Plug 'rickhowe/diffchar.vim'

        " Diffview.nvim {{{2
        " https://github.com/sindrets/diffview.nvim
        " Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
        Plug 'sindrets/diffview.nvim'

        " gitsigns.nvim {{{2
        " https://github.com/lewis6991/gitsigns.nvim
        " Git integration for buffers
        Plug 'lewis6991/gitsigns.nvim'

        " LSP Colors {{{2
        " https://github.com/folke/lsp-colors.nvim
        " Plugin that creates missing LSP diagnostics highlight groups for color schemes that don't yet support the Neovim 0.5 builtin LSP client.
        Plug 'folke/lsp-colors.nvim'

        " kotlin-vim {{{2
        " Kotlin plugin for Vim. Featuring: syntax highlighting, basic indentation, Syntastic support
        " https://github.com/udalov/kotlin-vim
        Plug 'udalov/kotlin-vim'

        " Sensible {{{2
        " sensible.vim: Defaults everyone can agree on
        " https://github.com/tpope/vim-sensible
        Plug 'tpope/vim-sensible'

        " Fugitive {{{2
        " fugitive.vim: a Git wrapper so awesome, it should be illegal
        " https://github.com/tpope/vim-fugitive
        Plug 'tpope/vim-fugitive'

        " Fugitive gitlinker {{{2
        " A lua neovim plugin to generate shareable file permalinks (with line ranges) for several git web frontend hosts. Inspired by tpope/vim-fugitive's :GBrowse
        " https://github.com/ruifm/gitlinker.nvim
        Plug 'ruifm/gitlinker.nvim'

        " Repeat {{{2
        " repeat.vim: enable repeating supported plugin maps with "."
        " http://www.vim.org/scripts/script.php?script_id=2136
        " https://github.com/tpope/vim-repeat
        Plug 'tpope/vim-repeat'


        " vim-eunuch {{{2
        " tpope/vim-eunuch
        " eunuch.vim: helpers for UNIX
        " http://www.vim.org/scripts/script.php?script_id=4300
        " https://github.com/tpope/vim-eunuch
        Plug 'tpope/vim-eunuch'

        " Recover.vim {{{2
        " chrisbra/Recover.vim
        " A Plugin to show a diff, whenever recovering a buffer
        " http://www.vim.org/scripts/script.php?script_id=3068
        Plug 'chrisbra/Recover.vim'

        " VimAirline {{{2
        " lean & mean status/tabline for vim that's light as air
        " https://github.com/bling/vim-airline
        Plug 'bling/vim-airline'
        let g:airline#extensions#tabline#enabled = 1
        " See https://github.com/ryanoasis/vim-devicons
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#tabline#fnametruncate = 0

        " Vim Quickscokp {{{2
        " Lightning fast left-right movement in Vim
        " https://github.com/unblevable/quick-scope
        Plug 'unblevable/quick-scope'
        let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

        " EasyMotion {{{2
        " Vim motions on speed!
        " https://github.com/Lokaltog/vim-easymotion
        Plug 'Lokaltog/vim-easymotion'
        nmap ,s <Plug>(easymotion-F)
        nmap ,f <Plug>(easymotion-f)
        nmap ,g <Plug>(easymotion-overwin-f2)
        let g:EasyMotion_keys = 'asdfghjklqwertyuiopzxcvbnm'
        let g:Easymotion_do_mapping=0

        " Tabularize ! {{{2
        " https://github.com/godlygeek/tabular
        " Vim script for text filtering and alignment
        " select text in visual mode, then hit : Tabularize /:
        " change the : with the needed char to align
        Plug 'godlygeek/tabular'

        " Mardwown {{{2
        " https://github.com/plasticboy/vim-markdown
        " Markdown Vim Mode http://plasticboy.com/markdown-vim-mode/
        Plug 'plasticboy/vim-markdown', { 'for': ['markdown']}
        let g:vim_markdown_folding_disabled=1
        let g:vim_markdown_follow_anchor = 1
        let g:vim_markdown_frontmatter = 1
        let g:vim_markdown_conceal = 0
        function! MarkdownHookInner(timer)
            normal h
        endfunction
        function! MarkdownHook(timer)
            " Delay otherwise `conceallevel' is setted by the plugin
            set conceallevel=0
            " Delay otherwise Tagbar is not loaded correctly
            Tagbar
            " call feedkeys("<C-w>h")
            call timer_start(200, 'MarkdownHookInner',
                        \ {'repeat': 1})

        endfunc
        autocmd BufAdd *.md call timer_start(1000, 'MarkdownHook',
                    \ {'repeat': 1})

        " Vim Markdown TOC {{{2
        " A vim 7.4+ plugin to generate table of contents for Markdown files.
        " https://github.com/mzlogin/vim-markdown-toc
        Plug 'mzlogin/vim-markdown-toc', { 'for': ['markdown']}

        " https://github.com/kyazdani42/nvim-web-devicons
        " https://github.com/kyazdani42/nvim-web-devicons
        " lua `fork` of vim-web-devicons for neovim
        Plug 'kyazdani42/nvim-web-devicons'

        " kanagawa.nvim {{{2
        " NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
        " https://github.com/rebelot/kanagawa.nvim
        Plug 'rebelot/kanagawa.nvim'

        " Treesitter {{{2
        " Nvim Treesitter configurations and abstraction layer
        " https://github.com/nvim-treesitter/nvim-treesitter
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

        " vim-systemd-syntax {{{2
        " https://codeberg.org/Dokana/vim-systemd-syntax
        Plug 'Matt-Deacalion/vim-systemd-syntax', { 'for': 'systemd' }


" Plug LSP and nvim-cmp {{{1
" https://github.com/hrsh7th/nvim-cmp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

call plug#end()

filetype plugin indent on

  " SEARCH {{{2
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

  " COMPLETION MENU {{{2
  " Afficher une liste lors de complétion de commandes/fichiers :
  set wildmode=list:full
  " Allow completion on filenames right after a '='.
  " Uber-useful when editing bash scripts
  set isfname-==

  " BACKUP {{{2
  " Modif tmp
  set swapfile
  " Modif tmp
  let g:dotvim_backup=expand('$HOME') . '/.vim/backup'
  if ! isdirectory(g:dotvim_backup)
      call mkdir(g:dotvim_backup, "p")
  endif
  set directory=~/.vim/backup

  " Backups with persistent undos {{{2
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

  " MOVE CURSOR {{{2

  " Stay on the same column if possible {{{2
  " Tenter de rester toujours sur la même colonne lors de changements de lignes :
  set nostartofline

  " COMMAND HISTORY {{{2
  " Nombre de commandes maximale dans l'historique :
  set history=10000

  " Vim display {{{1
  " Folding {{{2
  " @TODO: Do not change status on :w keep state fold saved.
  " I like some folding ideas from :
  " http://dougblack.io/words/a-good-vimrc.html#colors
  set foldmethod=marker
  " Then we want it to close every fold by default so that we have this high level
  " view when we open our vimrc.
  set foldlevel=0

  " Show command (useful for leader) {{{2
  set showcmd

  " COLORSHEME {{{2

  set background=dark
  colorscheme kanagawa

  " STATUS {{{2
  " Show editing mode
  set showmode

  " VISUAL BELL {{{2
  " Error bells are displayed visually.
  set visualbell

  " DIFF {{{2
  " Affiche toujours les diffs en vertical
  set diffopt=vertical

  " Split {{{2
  " Set the split below the active region.
  set splitbelow
  " https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
  set splitright


  " Display cmd mod {{{2
  " Indiquer le nombre de modification lorsqu'il y en a plus de 0
  " suite à une commande
  set report=0

  " Title {{{2
  " This is nice if you have something
  " that reset the title of you term at
  " each command, othersize it's annoying ...
  set title

  " Show Special Char {{{2
  " show tabs / nbsp ' ' / trailing spaces
  if has("Win32")
    set listchars=tab:--
  else
    set listchars=nbsp:¬,tab:··,trail:¤,extends:▷,precedes:◁
  endif

  set list

  " LINE NUMBER {{{2
  " Show number relative from the cursor
  set relativenumber

  "
  " SESSION {{{2
  " Récupération de la position du curseur entre 2 ouvertures de fichiers
  if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                  \| exe "normal g'\"" | endif
  endif

  " SHEBANG {{{2
  " shebang automatique lors de l'ouverture nouveau
  " d'un fichier *.py, *.sh (bash), modifier l'entête selon les besoins :
  " shell
  :autocmd BufNewFile *.sh,*.bash 0put =\"#!/bin/bash\<nl>\<nl>\"|$
  " python
  :autocmd BufNewFile *.py 0put=\"#!/usr/bin/env python\<nl>\\"|1put=\"\<nl>\"|$
  " php
  :autocmd BufNewFile *.php 0put=\"<?php\<nl>\<nl>\"|$
  " perl
  :autocmd BufNewFile *.pl 0put=\"#!/usr/bin/env perl -w\"|1put=\"use strict;\"|2put=\"use feature qw(say switch evalbytes);\<nl>\<nl>\"|$


  " Input bindings {{{1
  " Searching {{{2
  " From http://lambdalisue.hatenablog.com/entry/2013/06/23/071344
  " 検索後にジャンプした際に検索単語を画面中央に持ってくる
  nnoremap n nzz
  nnoremap N Nzz
  nnoremap * *zz
  nnoremap # #zz
  nnoremap g* g*zz
  nnoremap g# g#zz

  " Reselect visual block after indentation
  vnoremap > >gv
  vnoremap < <gv

  " Change default leader key {{{2
  let mapleader = ","

  " MOUSE {{{2
  " =======
  " Utilise la souris pour les terminaux qui le peuvent (tous ?)
  " pratique si on est habitué à coller sous la souris et pas sous le curseur,
  " attention fonctionnement inhabituel
  set mouse=a


  "" Remapage perso {{{2


  cnoremap sv vert belowright sb<Space>

  noremap <Leader>o o<Esc>k
  noremap <Leader>O O<Esc>

  nnoremap <leader><leader>t :tabnew<SPACE><CR>:
  nnoremap <leader><leader>v :vs<SPACE>
  nnoremap <leader><leader>e :e<SPACE>
  nnoremap <leader><leader>b :b<SPACE>

 "http://asktherelic.com/2011/04/02/on-easily-replacing-text-in-vim/
" vmap <Leader>r "sy:%s/<C-R>=substitute(@s,"\n",'\\n','g')<CR>/

nnoremap <leader><leader>q :bd<CR>
nnoremap <leader><leader>d :bd#<CR>
  nnoremap <leader><leader><leader>t :tabnew<CR>:Terminal<CR>a
  nnoremap <leader><leader><leader>v :vs!<CR>:Terminal<CR><C-w><<C-w>>a
  nnoremap <leader><leader><leader>p :sp!<CR>:Terminal<CR><C-w>-<C-w>+a
  tnoremap <F5> <C-\><C-n>
if has('nvim')
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l
  " See https://github.com/neovim/neovim/issues/7678#issuecomment-349228286
  " autocmd TermOpen * startinsert
  " autocmd VimEnter,BufWinEnter,WinEnter term://* startinsert
  autocmd TermOpen * setlocal nornu nonu statusline=%{b:term_title}
  autocmd BufLeave term://* stopinsert
  tnoremap <Leader>q <C-\><C-n>:bw!<CR>
  tnoremap <Leader>gt <C-\><C-n>gt<CR>
  tnoremap <Leader>gT <C-\><C-n>gT<CR>
  tnoremap <Leader>1gt <C-\><C-n>1gt<CR>
  tnoremap <Leader>2gt <C-\><C-n>2gt<CR>
  tnoremap <Leader>3gt <C-\><C-n>3gt<CR>
  tnoremap <Leader>4gt <C-\><C-n>4gt<CR>
  tnoremap <Leader>5gt <C-\><C-n>5gt<CR>
  tnoremap <Leader>6gt <C-\><C-n>6gt<CR>
  tnoremap <Leader>7gt <C-\><C-n>7gt<CR>
  tnoremap <Leader>8gt <C-\><C-n>8gt<CR>
  tnoremap <Leader>9gt <C-\><C-n>9gt<CR>
  tnoremap <leader><leader>t <C-\><C-n>:tabnew<SPACE>
  tnoremap <leader><leader>v <C-\><C-n>:vs<SPACE><CR><C-\><C-n><C-w><<C-w>>:enew<CR>:
  tnoremap <leader><leader>p <C-\><C-n>:sp<SPACE><CR><C-\><C-n><C-w>-<C-w>+:enew<CR>:
  tnoremap <leader><leader>b <C-\><C-n>:enew!<CR>:bw!#<CR>:b<SPACE>
  tnoremap <leader><leader>e <C-\><C-n>:enew!<CR>:bw!#<CR>:e<SPACE>
  tnoremap <leader><leader><leader>t <C-\><C-n>:tabnew<CR>:Terminal<CR>a
  tnoremap <leader><leader><leader>v <C-\><C-n>:vs<CR><C-\><C-n><C-w><<C-w>>:Terminal<CR><C-w><<C-w>>a
  tnoremap <leader><leader><leader>p <C-\><C-n>:sp<CR><C-\><C-n><C-w>-<C-w>+:Terminal<CR><C-w>-<C-w>+a
endif

" Ajouts persos {{{1


"http://vim.wikia.com/wiki/Disable_automatic_comment_insertion This sets up an auto command that fires after any filetype-specific plugin; the command removes the three flags from the 'formatoptions' option that control the automatic insertion of comments. With this in your vimrc, a comment character will not be automatically inserted in the next line under any situation.
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


autocmd BufNew,BufRead,BufEnter *.txt,*.md setlocal spell spelllang=fr,en

" ATTENTION, IL FAUT BIEN METTRE NNOREMAP, SINON, QUAND ON ENTRE EN VISUAL BLOCK, ÇA PLANTE QUAND ON VEUT REPASSER directement EN MODE INSERTION ^^
nnoremap i :noh<CR>i
nnoremap I :noh<CR>I
nnoremap a :noh<CR>a
nnoremap A :noh<CR>A


noremap <leader>3 *N
" Planck Keyboard
noremap <leader>e *N

nmap cp :let @" = expand("%<")<CR>p

noremap <Space> <C-d>zz
" http://stackoverflow.com/questions/23189568/control-space-vim-key-binding-in-normal-mode-does-not-work
noremap <NUL> <C-u>zz

set virtualedit=block

" http://stackoverflow.com/questions/6453595/prevent-vim-from-clearing-the-clipboard-on-exit
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" http://vim.wikia.com/wiki/Remove_unwanted_spaces
" However, this is a very dangerous autocmd to have as it will always strip trailing whitespace from every file a user saves. Sometimes, trailing whitespace is desired, or even essential in a file so be careful when implementing this autocmd.
autocmd BufWritePre * %s/\s\+$//e

" http://vi.stackexchange.com/questions/5511/showing-a-different-background-color-or-layout-beyond-80-column-using-spf13
set textwidth=80
" fo-=t otherwise break line automatically
autocmd BufNewFile,BufReadPost *.md set filetype=markdown fo-=t
set fo-=t


autocmd BufWinEnter,WinEnter set fo-=t


" https://superuser.com/questions/604122/vim-file-name-completion-relative-to-current-file
autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)

" " https://github.com/blueyed/dotfiles/blob/master/vimrc#L29
" " indent these tags for ft=html
" let g:html_indent_inctags = "body,html,head,p,tbody"
" " do not indent these
" let g:html_indent_autotags = "br,input,img"

" When on a buffer becomes hidden when it is |abandon|ed
set hidden

let g:terminal_scrollback_buffer_size = 100000

set scrolloff=5

"/\%81v.\+/

autocmd FileChangedShell * execute

" https://github.com/neoclide/coc.nvim/wiki/Using-configuration-file
autocmd FileType json syntax match Comment +\/\/.\+$+

"GVIM {{{2
"————
"http://vim.wikia.com/wiki/Restore_missing_gvim_menu_bar_under_GNOME See also help 'guioptions'
set guioptions-=T
set guioptions-=r
set guifont=Monospace\ 9

"http://vim.wikia.com/wiki/Hide_toolbar_or_menus_to_see_more_text
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar

"http://stackoverflow.com/questions/12448179/how-to-maximize-vims-windows-on-startup-with-vimrc
au GUIEnter * call system('wmctrl -i -b add,fullscreen -r '.v:windowid)

" highlight Normal guifg=White guibg=Black
" highlight Normal guibg=Black

" Microsoft Windows {{{2
if has("Win32")
  if &term=~'Win32'
    " colorscheme murphyJuanes "Le thème par défaut est très moche en console !  Attention, Murphy bug avec les SpellBad dans Windows. Je me le suis customisé (comenté tous les « red »). C'est pas mal comme thème, plus lisible pour programmer dans la console. @FIXME les codes couleurs ne semblent pas être les mêmes sous Linux et sous la console Microsoft Windows (voir aussi « help color » dans cmd.exe), mettre plutôt les noms des couleurs.
    hi SpellBad ctermbg=darkred ctermfg=Grey
    highlight Search ctermfg=Black
    highlight IncSearch ctermfg=Black
    hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=NONE
    hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=NONE
    " See also http://vim.wikia.com/wiki/Highlight_current_line
  endif
  set encoding=utf-8
  " Sinon interprète mal mon vimrc ! et notamment le plugin IndentLine.
endif

" Script batch
" ————————————
"Pour avoir les accents dans la console (scripts bat et com). Sous Vim, ouvrir ce fichier, puis taper « e ++enc=cp850 » pour recharger le fichier et l'afficher avec un codage « cp850 ». Attention, le faire à l'ouverture du fichier, avant toute modification préalable, sinon ça plante. Pour vérifier si cela a été bien pris en compte, taper « set fileencoding ». Encodage non pris en charge sous Notepad++.
" Ci après, automatisation. Permet de charger Vim en UTF-8 pour pas que a plante avec le plugin IndentLine grâce à « set encoding=utf-8 » ci-avant, puis recharge le fichier spécifique en cp850.
" Sous Linux, ne semble pas fonctionner avec Vim, mais fonctionne avec Nvim le 5/11/2015.
autocmd FileType dosbatch e ++enc=cp850



" Vim correct alt input and Terminal behaviour {{{2
" https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim

if ! has('nvim')
    let c='a'
    while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
    endw

    set timeout ttimeoutlen=50
endif


" lua {{{1

lua << EOF
require('gitsigns').setup()

require"gitlinker".setup({
  opts = {
    remote = nil, -- force the use of a specific remote
    -- adds current line nr in the url for normal mode
    add_current_line_on_normal_mode = true,
    -- callback for what to do with the url
    action_callback = require"gitlinker.actions".copy_to_clipboard,
    -- print the url after performing the action
    print_url = true,
  },
  callbacks = {
        ["github.com"] = require"gitlinker.hosts".get_github_type_url,
  },
-- default mapping to call url generation with action_callback
  mappings = "<leader>gy"
})

-- https://github.com/fannheyward/telescope-coc.nvim
require("telescope").setup({
    extensions = {
    coc = {
        theme = 'ivy',
        prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
        }
    },
    -- https://github.com/nvim-telescope/telescope.nvim/pull/828
    pickers = {
        buffers = {
        show_all_buffers = true,
        sort_lastused = true,
        theme = "dropdown",
        previewer = false,
        mappings = {
            i = {
                    ["<c-d>"] = "delete_buffer",
                }
            }
        }
    }
})
require('telescope').load_extension('coc')


-- https://github.com/nvim-treesitter/nvim-treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "javascript", "typescript", "lua", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- -- the name of the parser)
    -- -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
