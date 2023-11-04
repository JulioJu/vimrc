" My VIMRC File :
" ---------------
" @Author   : JulioJu
" @Forked version from https://github.com/GuillaumeSeren/vimrc on the 16/10/2015 (Lot of modifications).
" @AUTHOR       : Guillaume Seren ( http://guillaumeseren.com)
" @LICENSE      : www.opensource.org/licenses/bsd-license.php
    " @Link         : https://github.com/juanes10/vimrc
    " ---------------


" MISC {{{1

    " Change default leader key
    let mapleader = ","

    " http://stackoverflow.com/questions/6453595/prevent-vim-from-clearing-the-clipboard-on-exit
    autocmd VimLeave * call system("xsel -ib", getreg('+'))

    " Utilise la souris pour les terminaux qui le peuvent (tous ?)
    " pratique si on est habitué à coller sous la souris et pas sous le curseur,
    " attention fonctionnement inhabituel
    set mouse=a

    call plug#begin('~/.vim/plugged')

    " plenary.nvim {{{2
        " https://github.com/nvim-lua/plenary.nvim
        " plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice.
        Plug 'nvim-lua/plenary.nvim'

    " Sensible {{{2
        " sensible.vim: Defaults everyone can agree on
        " https://github.com/tpope/vim-sensible
        Plug 'tpope/vim-sensible'

    " vim-eunuch {{{2
        " tpope/vim-eunuch
        " eunuch.vim: helpers for UNIX
        " http://www.vim.org/scripts/script.php?script_id=4300
        " https://github.com/tpope/vim-eunuch
        Plug 'tpope/vim-eunuch'

" Languages {{{1

    " See also
    "   * https://github.com/sheerun/vim-polyglot
    "   * https://github.com/nvim-treesitter/nvim-treesitter#supported-languages

    " Treesitter {{{2
        " Nvim Treesitter configurations and abstraction layer
        " https://github.com/nvim-treesitter/nvim-treesitter
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " vim-systemd-syntax {{{2
        " https://codeberg.org/Dokana/vim-systemd-syntax
        Plug 'Matt-Deacalion/vim-systemd-syntax', { 'for': 'systemd' }

    " Mardwown {{{2
        " https://github.com/plasticboy/vim-markdown
        " Markdown Vim Mode http://plasticboy.com/markdown-vim-mode/
        " @TODO treesitter plugin is experimental
        Plug 'plasticboy/vim-markdown', { 'for': ['markdown']}
        let g:vim_markdown_folding_disabled=1
        let g:vim_markdown_follow_anchor = 1
        let g:vim_markdown_frontmatter = 1
        let g:vim_markdown_conceal = 0

    " Batch {{{2
    " ————————————
        "Pour avoir les accents dans la console (scripts bat et com). Sous Vim, ouvrir ce fichier, puis taper « e ++enc=cp850 » pour recharger le fichier et l'afficher avec un codage « cp850 ». Attention, le faire à l'ouverture du fichier, avant toute modification préalable, sinon ça plante. Pour vérifier si cela a été bien pris en compte, taper « set fileencoding ». Encodage non pris en charge sous Notepad++.
        " Ci après, automatisation. Permet de charger Vim en UTF-8 pour pas que a plante avec le plugin IndentLine grâce à « set encoding=utf-8 » ci-avant, puis recharge le fichier spécifique en cp850.
        " Sous Linux, ne semble pas fonctionner avec Vim, mais fonctionne avec Nvim le 5/11/2015.
        autocmd FileType dosbatch e ++enc=cp850

    " Spell {{{2
        autocmd BufNew,BufRead,BufEnter *.txt,*.md setlocal spell spelllang=fr,en

" LSP / Autocompletion {{{1

    " Coc.nvim {{{2
        " https://github.com/neoclide/coc.nvim
        " Nodejs extension host for vim & neovim, load extensions like VSCode
        " and host language servers.
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'fannheyward/telescope-coc.nvim'
        let g:coc_global_extensions = [
                    \'coc-tsserver',
                    \'@yaegassy/coc-volar-tools',
                    \'coc-eslint',
                    \'coc-html',
                    \'coc-emmet',
                    \'coc-css',
                    \'coc-stylelint',
                    \
                    \'coc-sh',
                    \'coc-docker',
                    \
                \]

        " https://github.com/neoclide/coc.nvim/wiki/Using-configuration-file
        " https://stackoverflow.com/questions/55669954/why-does-vim-highlight-all-my-json-comments-in-red
        autocmd FileType json syntax match Comment +\/\/.\+$+

        command! -nargs=0 CocDetail :call CocAction('diagnosticInfo')
        let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
        let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

        " https://github.com/neoclide/coc.nvim/blob/master/README.md
        " ==========

        " Always show the signcolumn, otherwise it would shift the text each time
        " diagnostics appear/become resolved
        set signcolumn=yes

        " Use `[g` and `]g` to navigate diagnostics
        " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)


        nmap <silent> gd :Telescope coc definitions<CR>
        nmap <silent> gy :Telescope coc type_definitions<CR>
        nmap <silent> gi :Telescope coc implementations<CR>
        nmap <silent> gr :Telescope coc references<CR>


        " Use K to show documentation in preview window
        nnoremap <silent> K :call ShowDocumentation()<CR>

        function! ShowDocumentation()
        if CocAction('hasProvider', 'hover')
            call CocActionAsync('doHover')
        else
            call feedkeys('K', 'in')
        endif
        endfunction

        " Highlight the symbol and its references when holding the cursor
        autocmd CursorHold * silent call CocActionAsync('highlight')

        " Symbol renaming
        nmap <leader>rn <Plug>(coc-rename)

        " Remap <C-f> and <C-b> to scroll float windows/popups
        if has('nvim-0.4.0') || has('patch-8.2.0750')
            nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
            nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
            inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
            inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
            vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
            vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
        endif

        " ========== End README.md ======

        nmap <leader>qf  <Plug>(coc-fix-current)

        command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

        " " https://github.com/neoclide/coc.nvim/issues/869
        " nmap <silent> K :call CocAction('doHover')<CR>


    " nvim-cmp {{{2
        " https://github.com/hrsh7th/nvim-cmp
        Plug 'neovim/nvim-lspconfig'
        Plug 'hrsh7th/cmp-nvim-lsp'
        Plug 'hrsh7th/cmp-buffer'
        Plug 'hrsh7th/cmp-path'
        Plug 'hrsh7th/cmp-cmdline'
        Plug 'hrsh7th/nvim-cmp'

    " Filename completion {{{2

        " Afficher une liste lors de complétion de commandes/fichiers :
        set wildmode=list:full
        " Allow completion on filenames right after a '='.
        " Uber-useful when editing bash scripts
        set isfname-==

    " nvim-autopairs {{{2
        " https://github.com/windwp/nvim-autopairs
        " autopairs for neovim written by lua
        Plug 'windwp/nvim-autopairs'

    " TComment {{{2
        " An extensible & universal comment vim-plugin that also handles embedded filetypes http://www.vim.org/scripts/script.php?script_id=1173
        " https://github.com/tomtom/tcomment_vim
        Plug 'tomtom/tcomment_vim'
        vnoremap <leader>c :call tcomment#SetOption("count", 2)<CR>gv:TCommentBlock<CR>
        nnoremap <leader>c :TComment<CR>

    " Shebang {{{2
        " shebang automatique lors de l'ouverture nouveau
        " d'un fichier *.py, *.sh (bash), modifier l'entête selon les besoins :
        " shell
        :autocmd BufNewFile *.sh,*.bash 0put =\"#!/bin/bash\<nl>set -eux -o pipefail\<nl>\"|$
        " python
        :autocmd BufNewFile *.py 0put=\"#!/usr/bin/env python\<nl>\\"|1put=\"\<nl>\"|$
        " php
        :autocmd BufNewFile *.php 0put=\"<?php\<nl>\<nl>\"|$
        " perl
        :autocmd BufNewFile *.pl 0put=\"#!/usr/bin/env perl -w\"|1put=\"use strict;\"|2put=\"use feature qw(say switch evalbytes);\<nl>\<nl>\"|$

" Motion{{{1

    " vim-ipmotion {{{2
        " Improved paragraph motion http://www.vim.org/scripts/script.php?script_id=3952
        " https://github.com/justinmk/vim-ipmotion
        Plug 'justinmk/vim-ipmotion'

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

    " Misc {{{2

        set virtualedit=block

        " Stay on the same column if possible {{{3
        set nostartofline

        set scrolloff=5

        noremap <Space> <C-d>zz
        " http://stackoverflow.com/questions/23189568/control-space-vim-key-binding-in-normal-mode-does-not-work
        noremap <NUL> <C-u>zz

" Format {{{1
    " Neoformat {{{2
        " https://github.com/sbdchd/neoformat
        "  A (Neo)vim plugin for formatting code.
        Plug 'sbdchd/neoformat'

    " Tabularize ! {{{2
        " https://github.com/godlygeek/tabular
        " Vim script for text filtering and alignment
        " select text in visual mode, then hit : Tabularize /:
        " change the : with the needed char to align
        Plug 'godlygeek/tabular'

    " Remove trailling whitespace on save {{{2
        " http://vim.wikia.com/wiki/Remove_unwanted_spaces
        " However, this is a very dangerous autocmd to have as it will always strip trailing whitespace from every file a user saves. Sometimes, trailing whitespace is desired, or even essential in a file so be careful when implementing this autocmd.
        autocmd BufWritePre * %s/\s\+$//e

    " Line length {{{2

        "http://vim.wikia.com/wiki/Disable_automatic_comment_insertion This sets up an auto command that fires after any filetype-specific plugin; the command removes the three flags from the 'formatoptions' option that control the automatic insertion of comments. With this in your vimrc, a comment character will not be automatically inserted in the next line under any situation.
        autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

        " http://vi.stackexchange.com/questions/5511/showing-a-different-background-color-or-layout-beyond-80-column-using-spf13
        set textwidth=80
        " fo-=t otherwise break line automatically
        autocmd BufNewFile,BufReadPost *.md set filetype=markdown fo-=t
        set fo-=t

        autocmd BufWinEnter,WinEnter set fo-=t

    " Reselect visual block after indentation {{{2
        vnoremap > >gv
        vnoremap < <gv

    " Shortcut add empty line {{{2
        noremap <Leader>o o<Esc>k
        noremap <Leader>O O<Esc>

    " Tab {{{2

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
        set expandtab
        " Do not tab expand on Makefile
        autocmd FileType make set noexpandtab shiftwidth=2 softtabstop=0
        " Detection de l'indentation
        set cindent


" Search / replace / exploration {{{1

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



    "  nvim-tree.lua {{{2
        " A file explorer tree for neovim written in lua
        " https://neovimcraft.com/plugin/kyazdani42/nvim-tree.lua
        Plug 'kyazdani42/nvim-tree.lua'

        command! -n=? -complete=dir -bar NERDTreeOpen :NvimTreeFindFile


    " Telescope {{{2
        " https://github.com/nvim-telescope/telescope.nvim
        " Find, Filter, Preview, Pick. All lua, all the time.
        Plug 'nvim-telescope/telescope.nvim'


    " vim-abolish {{{2
        " abolish.vim: Work with several variants of a word at once
        " `%S/toto/titi`
        " https://github.com/tpope/vim-abolish
        Plug 'tpope/vim-abolish'

    " Text search and replace {{{2
        " http://asktherelic.com/2011/04/02/on-easily-replacing-text-in-vim/
        vmap <Leader>r "sy:%s/<C-R>=substitute(@s,"\n",'\\n','g')<CR>/
        vmap <Leader>rr "sy:%s/<C-R>=substitute(@s,"\n",'\\n','g')<CR>/<C-R>=substitute(@s,"\n",'\\n','g')<CR>

    " Text search {{{2
        " Recherche en minuscule -> indépendante de la casse, {{{4
        " une majuscule -> stricte
        set smartcase
        " Ne jamais respecter la casse {{{4
        " (attention totalement indépendant du précédent mais de priorité plus faible)
        set ignorecase
        " Met en évidence TOUS les résultats d'une recherche, {{{4
        " A consommer avec modération
        set hlsearch
        " Déplacer le curseur quand on écrit un (){}[] {{{4
        " (attention il ne s'agit pas du highlight
        set showmatch

        " From http://lambdalisue.hatenablog.com/entry/2013/06/23/071344
        nnoremap n nzz
        nnoremap N Nzz
        nnoremap * *zz
        nnoremap # #zz
        nnoremap g* g*zz
        nnoremap g# g#zz

        noremap <leader>3 *N
        " Planck Keyboard
        noremap <leader>e *N

        " ATTENTION, IL FAUT BIEN METTRE NNOREMAP, SINON, QUAND ON ENTRE EN VISUAL BLOCK, ÇA PLANTE QUAND ON VEUT REPASSER directement EN MODE INSERTION ^^
        nnoremap i :noh<CR>i
        nnoremap I :noh<CR>I
        nnoremap a :noh<CR>a
        nnoremap A :noh<CR>A


" Vim display {{{1

    " kanagawa.nvim {{{2
        " NeoVim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai.
        " https://github.com/rebelot/kanagawa.nvim
        Plug 'rebelot/kanagawa.nvim'
        set background=dark

        " Can't be put here. Declared after end of Plug
        " colorscheme kanagawa

    " VimAirline {{{2
        " lean & mean status/tabline for vim that's light as air
        " https://github.com/bling/vim-airline
        Plug 'bling/vim-airline'
        let g:airline#extensions#tabline#enabled = 1
        " See https://github.com/ryanoasis/vim-devicons
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#tabline#fnametruncate = 0


    " Devicons {{{2
        " https://github.com/kyazdani42/nvim-web-devicons
        " lua `fork` of vim-web-devicons for neovim
        Plug 'kyazdani42/nvim-web-devicons'

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
        " TODO see https://neovimcraft.com/plugin/HiPhish/rainbow-delimiters.nvim

    " nvim-colorize {{{2
        " https://github.com/NvChad/nvim-colorizer.lua
        " https://neovimcraft.com/plugin/NvChad/nvim-colorizer.lua
        " Maintained fork of the fastest Neovim colorizer
        Plug 'NvChad/nvim-colorizer.lua'

    " Misc {{{2
        " Folding
        " @TODO: Do not change status on :w keep state fold saved.
        " I like some folding ideas from :
        " http://dougblack.io/words/a-good-vimrc.html#colors
        set foldmethod=marker
        " Then we want it to close every fold by default so that we have this high level
        " view when we open our vimrc.
        set foldlevel=0

        " Show command (useful for leader)
        set showcmd

        " STATUS
        " Show editing mode
        set showmode

        " VISUAL BELL
        " Error bells are displayed visually.
        set visualbell

        " DIFF
        " Affiche toujours les diffs en vertical
        set diffopt=vertical

        " Split
        " Set the split below the active region.
        set splitbelow
        " https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
        set splitright


        " Display cmd mod
        " Indiquer le nombre de modification lorsqu'il y en a plus de 0
        " suite à une commande
        set report=0

        " Title
        " This is nice if you have something
        " that reset the title of you term at
        " each command, othersize it's annoying ...
        set title
        " See https://github.com/neovim/neovim/issues/7678#issuecomment-349228286
        autocmd TermOpen * setlocal nornu nonu statusline=%{b:term_title}

        " Show Special Char
        " show tabs / nbsp ' ' / trailing spaces
        if has("Win32")
            set listchars=tab:--
        else
            set listchars=nbsp:¬,tab:··,trail:¤,extends:▷,precedes:◁
        endif

        set list

        " LINE NUMBER
        set number
        " Show number relative from the cursor
        set relativenumber

        "
        " SESSION
        " Récupération de la position du curseur entre 2 ouvertures de fichiers
        if has("autocmd")
            au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                        \| exe "normal g'\"" | endif
        endif


        let g:terminal_scrollback_buffer_size = 100000

        " When on a buffer becomes hidden when it is |abandon|ed
        set hidden

    " Gvim {{{2
        "————
        "http://vim.wikia.com/wiki/Restore_missing_gvim_menu_bar_under_GNOME See also help 'guioptions'
        set guioptions-=T
        set guioptions-=r

        "http://vim.wikia.com/wiki/Hide_toolbar_or_menus_to_see_more_text
        set guioptions-=m  "remove menu bar
        set guioptions-=T  "remove toolbar

        "http://stackoverflow.com/questions/12448179/how-to-maximize-vims-windows-on-startup-with-vimrc
        au GUIEnter * call system('wmctrl -i -b add,fullscreen -r '.v:windowid)

    " Neovide {{{2

        " https://neovide.dev/faq.html
        " Not compatible with cmatrix
        " https://github.com/neovide/neovide/issues/1656
        let g:neovide_scale_factor=0.5

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

" Version Control System {{{1

    " Undotree {{{2
        " The undo history visualizer for VIM
        " https://github.com/mbbill/undotree
        Plug 'mbbill/undotree'

    " Recover.vim {{{2
        " chrisbra/Recover.vim
        " A Plugin to show a diff, whenever recovering a buffer
        " http://www.vim.org/scripts/script.php?script_id=3068
        Plug 'chrisbra/Recover.vim'

    " Vim magit {{{2
        " https://github.com/jreybert/vimagit
        " Ease your git workflow within Vim
        Plug 'jreybert/vimagit'
        let g:magit_default_fold_level = 2
        let g:magit_discard_untracked_do_delete=1
        let g:magit_auto_foldopen = 1
        let g:magit_warning_max_lines=500
        let g:magit_default_show_all_files=2
        " TODO test Neogit

    " gitsigns.nvim {{{2
        " https://github.com/lewis6991/gitsigns.nvim
        " Git integration for buffers
        Plug 'lewis6991/gitsigns.nvim'

    " Fugitive {{{2
        " fugitive.vim: a Git wrapper so awesome, it should be illegal
        " https://github.com/tpope/vim-fugitive
        Plug 'tpope/vim-fugitive'

    " Fugitive gitlinker {{{2
        " A lua neovim plugin to generate shareable file permalinks (with line ranges) for several git web frontend hosts. Inspired by tpope/vim-fugitive's :GBrowse
        " https://github.com/ruifm/gitlinker.nvim
        Plug 'ruifm/gitlinker.nvim'

    " diffchar.vim {{{2
        " https://github.com/rickhowe/diffchar.vim
        " Highlight the exact differences, based on characters and words
        " See also https://github.com/neovim/neovim/pull/14537
        Plug 'rickhowe/diffchar.vim'

    " Diffview.nvim {{{2
        " https://github.com/sindrets/diffview.nvim
        " Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
        Plug 'sindrets/diffview.nvim'

    " Vim-autoread {{{2
        " https://github.com/djoshea/vim-autoread
        " Have Vim automatically reload a file that has changed externally
        Plug 'djoshea/vim-autoread'

    " Backup {{{2

        " Swap {{{3
            " Modif tmp
            set swapfile
            " Modif tmp
            let g:dotvim_backup=expand('$HOME') . '/.vim/backup'
            if ! isdirectory(g:dotvim_backup)
                call mkdir(g:dotvim_backup, "p")
            endif
            set directory=~/.vim/backup

        " Backups with persistent undos {{{3
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

" Plug End {{{1
call plug#end()

" Could not be put above
colorscheme kanagawa
" Split and tab management {{{1

    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l

    cnoremap sv vert belowright sb<Space>

    nnoremap <leader>wwww :w<CR>:b#<CR><C-\><C-n>:bw#<CR>i

    nnoremap <leader><leader>t :tabnew<SPACE><CR>:
    nnoremap <leader><leader>v :vs<SPACE>
    nnoremap <leader><leader>e :e<SPACE>
    nnoremap <leader><leader>b :b<SPACE>

    nnoremap <leader><leader>q :bd<CR>
    nnoremap <leader><leader>d :bd#<CR>
    nnoremap <leader><leader><leader>t :tabnew<CR>:terminal<CR>a
    nnoremap <leader><leader><leader>v :vs!<CR>:terminal<CR><C-w><<C-w>>a
    nnoremap <leader><leader><leader>p :sp!<CR>:terminal<CR><C-w>-<C-w>+a
    tnoremap <F5> <C-\><C-n>
    if has('nvim')
        tnoremap <A-h> <C-\><C-n><C-w>h
        tnoremap <A-j> <C-\><C-n><C-w>j
        tnoremap <A-k> <C-\><C-n><C-w>k
        tnoremap <A-l> <C-\><C-n><C-w>l
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
        tnoremap <leader><leader><leader>t <C-\><C-n>:tabnew<CR>:terminal<CR>a
        tnoremap <leader><leader><leader>v <C-\><C-n>:vs<CR><C-\><C-n><C-w><<C-w>>:terminal<CR><C-w><<C-w>>a
        tnoremap <leader><leader><leader>p <C-\><C-n>:sp<CR><C-\><C-n><C-w>-<C-w>+:terminal<CR><C-w>-<C-w>+a
    endif

    " spare one VimGolf point (and a Shift press) on :q, :w, :e, :x
    " Inspired from https://github.com/fabi1cazenave/dotFiles/blob/e599871252171a424a5fd50f30b3ee6c28c08e29/config/nvim/mappings.vim#L49
    noremap <Leader>q :q<CR>
    noremap <Leader>w :w<CR>

" lua {{{1

" https://neovim.io/doc/user/starting.html#load-plugins
runtime! lua/init.lua
