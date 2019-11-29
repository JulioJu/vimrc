" My VIMRC File :
" ---------------
" @Author   : Juanes Espinel (juanes0890@gmail.com)
" @Forked version from https://github.com/GuillaumeSeren/vimrc on the 16/10/2015 (Lot of modifications).
" @AUTHOR       : Guillaume Seren ( http://guillaumeseren.com)
" @LICENSE      : www.opensource.org/licenses/bsd-license.php
    " @Link         : https://github.com/juanes10/vimrc
    " ---------------

    " Summary
    " ===========
        " Let's try to split this file into several clear part
        " - Startup config
        " - Plugins List
        " - Tweaking Plugins
        " - Vim core
        " - Vim Display
        " - AutoCmd
        " - Functions
        " - Input

        " Startup config {{{1
        " ===========
        " We can export some config in modular files like :
        " Change the default mode of vim.
        if has('vim_starting')
            " Be iMproved
            set nocompatible
        endif

        " Auto load / install plugin manager
        if !1 | finish | endif

        " auto-install vim-plug
        if empty(glob('~/.vim/autoload/plug.vim'))
            echo "Installing VimPlug..."
            silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            autocmd VimEnter * PlugInstall
        endif

        " " Load Python for
        " if has('nvim')
        " runtime! plugin/python_setup.vim
        " endif

        " VimPlug
        call plug#begin('~/.vim/plugged')

        " Default plugins {{{1


        " === Plugins non installés par Guillaume {{{2
        "}}}


        " DelimitMate {{{2
        " https://github.com/Raimondi/delimitMate
        " Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc.
        " if has('nvim')
            Plug ('Raimondi/delimitMate')
            autocmd BufReadPost markdown DelimtMateOff

            augroup delimitMateGroup
                " TODO
                " Follow https://github.com/w0rp/ale/pull/2121
                " Fix 1996 - Add eclipse LSP support.
                autocmd FileType *
                            \ if (
                            \ expand('<amatch>') != 'markdown'
                            \ )
                            \ | call plug#load('delimitMate')
                            \ | execute 'autocmd! delimitMateGroup'
                            \ | endif
            augroup END
        " endif

        " " SuperTab {{{2
        " " https://github.com/ervandew/supertab
        " " Perform all your vim insert mode completions with Tab
        " Plug 'ervandew/supertab'


        " IndentLine {{{2
        " A vim plugin to display the indention levels with thin vertical lines A vim plugin to display the indention levels with thin vertical lines u
        " https://github.com/Yggdroot/indentLine
        Plug 'Yggdroot/indentLine'

        "" Numbers {{{2
        "" numbers.vim is a vim plugin for better line numbers
        "" https://github.com/myusuf3/numbers.vim
        "" Plug 'myusuf3/numbers.vim'
        "" ==> bug when enter in terminal

        " Rainbow_parentheses.vim {{{2
        " https://github.com/kien/rainbow_parentheses.vim
        " Better Rainbow Parentheses
        Plug 'junegunn/rainbow_parentheses.vim'

        " Vim Visual Increment {{{2
        " visual-increment.vim - use CTRL+A/X to create increasing sequence of numbers or letters via visual mode
        " https://github.com/triglav/vim-visual-increment
        Plug 'triglav/vim-visual-increment'
        "" On peut aussi utiliser « '<,'>!seq -s ", " » 1 5 pour générer sur une seule ligne avec des « , ». À vois aussi avec awk.

        "" VisIncr {{{2
        "" https://github.com/vim-scripts/VisIncr
        "" Produce increasing/decreasing columns of numbers, dates, or daynames
        "Plug 'vim-scripts/VisIncr'

        " Ulti-Snip {{{2
        " UltiSnips - The ultimate snippet solution for Vim. Send pull requests to SirVer/ultisnips!
        " https://github.com/SirVer/ultisnips
        Plug 'SirVer/ultisnips'

        " Vim-snippets {{{2
        " vim-snipmate default snippets (Previously snipmate-snippets)
        " https://github.com/honza/vim-snippets
        Plug 'honza/vim-snippets'

        " Language Client Neovim {{{2
        " https://github.com/autozimu/LanguageClient-neovim
        " Language Server Protocol (LSP) support for vim and neovim.
        Plug 'autozimu/LanguageClient-neovim', {
                    \ 'branch': 'next',
                    \ 'do': 'bash install.sh',
                    \ }

        " " Deoplete {{{2
        " " https://github.com/Shougo/deoplete.nvim
        " " Dark powered asynchronous completion framework for neovim
        " if has('nvim')
        "    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        "    " See https://github.com/Shougo/deoplete.nvim/issues/133
        "    " https://github.com/Shougo/deoplete.nvim/issues/578
        "    Plug 'Shougo/context_filetype.vim'
        " endif

        " Vim Autotag {{{2
        " https://github.com/craigemery/vim-autotag
        " Automatically discover and "properly" update ctags files on save
        Plug 'craigemery/vim-autotag', {'for': ['sh', 'c', 'zsh', 'bash']}

        " ALE {{{2
        " Asynchronous Lint Engine
        " https://github.com/w0rp/ale
        Plug 'w0rp/ale', { 'for': [] }
        " https://github.com/junegunn/vim-plug/issues/63
        augroup aleGroup
            " TODO
            " Follow https://github.com/w0rp/ale/pull/2121
            " Fix 1996 - Add eclipse LSP support.
            autocmd FileType *
                        \ if (
                                \ expand('<amatch>') != 'typescript'
                                \ && expand('<amatch>') != 'javascript'
                                \ && expand('<amatch>') != 'json'
                                \ && expand('<amatch>') != 'css'
                            \ )
                        \ | call plug#load('ale')
                        \ | execute 'autocmd! aleGroup'
                        \ | endif
        augroup END

        " Coc.nvim {{{2
        " Intellisense engine for vim8 & neovim, full language server protocol support as VSCode
        Plug 'neoclide/coc.nvim', {
                    \ 'branch': 'release',
                    \ 'for': [
                        \ 'typescript',
                        \'javascript',
                        \'json',
                        \'css',
                        \'java'
                    \ ]
                    \ }

        function! CocNvimHighlight()
            highlight CocErrorHighlight ctermfg=Red  guifg=#ff0000
            highlight CocWarningHighlight ctermfg=Red  guifg=#ff0000
            highlight CocInfoHighlight ctermfg=Red  guifg=#ff0000
            highlight CocHintHighlight ctermfg=Red  guifg=#ff0000
            highlight CocErrorLine ctermbg=lightblue  guibg=lightblue
            highlight CocWarningLine ctermbg=lightblue  guibg=lightblue
            highlight CocInfoLine ctermbg=lightblue  guibg=lightblue
            highlight CocHintLine ctermbg=lightblue  guibg=lightblue
            highlight CocHighlightText  guibg=#111111 ctermbg=223
        endfunction

        function! CocNvimCustomization()
            command! -nargs=0 CocDetail :call CocAction('diagnosticInfo')
            let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
            let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

            " https://github.com/neoclide/coc.nvim/issues/236
            nmap <silent> ]c <Plug>(coc-diagnostic-next)

            " https://github.com/neoclide/coc-highlight/issues/8
            call CocNvimHighlight()

            nmap <leader>qf  <Plug>(coc-fix-current)
            nmap <leader>rn <Plug>(coc-rename)


            nmap <silent> gd <Plug>(coc-definition)
            nmap <silent> gy <Plug>(coc-type-definition)
            nmap <silent> gi <Plug>(coc-implementation)
            nmap <silent> gr <Plug>(coc-references)
        endfunction

        autocmd! user coc.nvim call CocNvimCustomization()

        " " nvim - typescript {{{2
        " " Typescript tooling for Neovim
        " " https://github.com/mhartington/nvim-typescript
        " " It works with Deoplete, and not with YCM. It's concurrent of Tsuquyomi
        " if has('nvim')
        "    Plug 'mhartington/nvim-typescript', {'for': 'typescript'} " Doesn't work
        " endif

        "  Indent object {{{2
        " https://github.com/michaeljsmith/vim-indent-object
        " Vim plugin that defines a new text object representing lines of code at the same indent level. Useful for python/vim scripts, etc. (better method for Python, it's for txt) !
        Plug 'michaeljsmith/vim-indent-object'

        " " Restore_view {{{2
        " " vim-scripts/restore_view.vim
        " " A plugin for automatically restoring file's cursor position and foldingu
        " " https://github.com/vim-scripts/restore_view.vim
        " Plug 'vim-scripts/restore_view.vim'
        " Bug in when launch several buffers from differents path : change path.

"        " Vim multiple cursors {{{2
"        " True Sublime Text style multiple selections for Vim
"        " https://github.com/terryma/vim-multiple-cursors
"        Plug 'terryma/vim-multiple-cursors'
"
        "" NerdCommenter {{{2
        "" BUG FOR JS (not) « /** */
        "" Vim plugin for intensely orgasmic commenting
        "" https://github.com/scrooloose/nerdcommenter
        """ Plug 'scrooloose/nerdcommenter'

        " TComment {{{2
        " An extensible & universal comment vim-plugin that also handles embedded filetypes http://www.vim.org/scripts/script.php?script_id=1173
        " https://github.com/tomtom/tcomment_vim
        Plug 'tomtom/tcomment_vim'

        " " Vim Autoformat {{{2
        " " https://github.com/Chiel92/vim-autoformat
        " " Provide easy code formatting in Vim by integrating existing code formatters.
        " " USE COMMAND « :Autoformat »
        " " Removed because less updated than Neoformat. We could also use ALE
        " Plug 'Chiel92/vim-autoformat'

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

        " Ripgrep {{{2
        " Use RipGrep in Vim and display results in a quickfix list
        " https://github.com/jremmen/vim-ripgrep
        Plug 'jremmen/vim-ripgrep'

        " Vim ranger {{{2
        " Plug 'francoiscabrol/ranger.vim'
        " https://github.com/francoiscabrol/ranger.vim
        Plug 'francoiscabrol/ranger.vim'

        " Vim bclose (dependancy for ranger) {{{2
        " https://github.com/rbgrouleff/bclose.vim
        " The BClose Vim plugin for deleting a buffer without closing the window http://vim.wikia.com/wiki/Deleting_a_…
        Plug 'rbgrouleff/bclose.vim'


        " NERDTree {{{2
        " A tree explorer plugin for vim.
        " https://github.com/scrooloose/nerdtree
        Plug 'scrooloose/nerdtree'

        " nerdtree-git-plugin {{{2
        " A plugin of NERDTree showing git status
        " https://github.com/Xuyuanp/nerdtree-git-plugin
        Plug 'Xuyuanp/nerdtree-git-plugin'

        " Vim buffergator {{2
        " Vim plugin to list, select and switch between buffers.
        " https://github.com/jeetsukumaran/vim-buffergator
        Plug 'jeetsukumaran/vim-buffergator'

        " Vim tabber {{{2
        " A Vim plugin for labeling tabs, styled after Powerline, with additional tab management utilities.
        " https://github.com/fweep/vim-tabber
        Plug 'fweep/vim-tabber'

        " Undotree
        " The undo history visualizer for VIM
        " https://github.com/mbbill/undotree
        Plug 'mbbill/undotree'

        " " Coloresque {{{2
        " " css/less/sass/html color preview for vim
        " " https://github.com/gorodinskiy/vim-coloresque
        Plug 'gorodinskiy/vim-coloresque'
        " Not maintained

        " Better indent support for php with html {{{2
        " This script allows you to indent HTML sections in PHP files
        " https://github.com/captbaritone/better-indent-support-for-php-with-html
        Plug 'captbaritone/better-indent-support-for-php-with-html'
        " @WARNING don't put this plugin in NeoBundleLayz
        " NeoBundleLazy 'maxrolon/better-indent-support-for-php-with-html', {
        " \ 'autoload': {
        " \     'filetypes':['php', 'html']
        " \ }}

        " " YouCompleteMe {{{2
        " " A code-completion engine for Vim
        " " https://github.com/Valloric/YouCompleteMe
        " " Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
        " function! BuildYCM(info)
        " " info is a dictionary with 3 fields
        " " - name:   name of the plugin
        " " - status: 'installed', 'updated', or 'unchanged'
        " " - force:  set on PlugInstall! or PlugUpdate!
        " if a:info.status == 'installed' || a:info.force
        "     !./install.py --tern-completer
        " endif
        " endfunction
        "
        " Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
        " " See also http://elblogdedually.blogspot.fr/2015/03/arch-linux-neovim-with-vim.html
        " " Plugin disable in txt (AutoPairs) {{{2
        " if !has('nvim')
        " "    autocmd FileType * call PluginDisableInTxt()
        " "
        " "     function! PluginDisableInTxt()
        " "       if (&ft!='text')
        " "           NeoBundleSource auto-pairs
        " "       endif
        " "     endfunction
        " "
        " "         " Auto-pairs
        " "         " https://github.com/jiangmiao/auto-pairs
        " "         " Vim plugin, insert or delete brackets, parens, quotes in pair
        " "         " WARNING : MY VERSION OF AUTO-PAIRS IS CUSTOMIZED
        " "         NeoBundleLazy 'jiangmiao/auto-pairs'
        " Plug 'jiangmiao/auto-pairs', {'for' : ['java', 'c', 'py', 'javascript', 'php', 'css']}
        " endif
        "
        " Vim-autoread {{{2
        " https://github.com/djoshea/vim-autoread
        " Have Vim automatically reload a file that has changed externally
        Plug 'djoshea/vim-autoread'

        " REST VIM {{{2

        " See my comments at https://github.com/JulioJu/scholarProjectWebSemantic

        " Roast (on Python)
        " https://github.com/sharat87/roast.vim
        " An HTTP client for ViM, that can also be used as a REST client.
        Plug 'sharat87/roast.vim'

        " vim-rest-console (on CURL)
        " https://github.com/diepm/vim-rest-console
        " A REST console for Vim.
        Plug 'diepm/vim-rest-console'
        let g:vrc_include_response_header = 1

        " html5-vim {{{2
        " http://vimawesome.com/plugin/html5-vim
        " HTML5 omnicomplete and syntax
        Plug 'othree/html5.vim', {'for ' : ['html', 'php', 'jsp']}

        " MatchTagAlways {{{2
        " https://github.com/Valloric/MatchTagAlways
        " A Vim plugin that always highlights the enclosing html/xml tags
        Plug 'Valloric/MatchTagAlways', {'for ' : ['html', 'php', 'jsp', 'xml', 'xsd', 'dtd', 'xsl']}

        " Emmet {{{2
        "  emmet for vim: http://emmet.io/
        "  http://mattn.github.io/emmet-vim
        Plug 'mattn/emmet-vim', { 'for' : ['html', 'php', 'jsp', 'xml', 'dtd', 'xsd', 'xsl', 'xhtml']}

        " " Neomake {{{2
        " " A plugin for asynchronous :make using Neovim's job-control functionality
        " " https://github.com/benekastah/neomake
        " Plug 'benekastah/neomake', { 'for' : ['c']}

        " " Vim browser reload plugin {{{2
        " " vim plugin to reload your browser, Linux version
        " " https://github.com/lordm/vim-browser-reload-linux
        " Plug 'lordm/vim-browser-reload-linux', { 'for': ['html', 'php', 'javascript', 'typescript']}


        " " Vim Eclim {{{2
        " " https://github.com/starcraftman/vim-eclim
        " " A repo to use with vim plugin managers.
        " " Plug 'starcraftman/vim-eclim'
        " " source /usr/share/vim/vimfiles/plugin/eclim.vim -- « Unable to determine eclim basedir.  Please report this issue on the eclim user mailing list. ».
        " " Plug '/usr/share/vim/vimfiles/pluginEclim' // Doesn't work
        " " NeoBundleLocal seems to be for an other thing https://github.com/Shougo/neobundle.vim/issues/171.
        " " Doesn't work
        " " NeoBundleLocal '~/.nvim/pluginEclim'
        " " Maybe, you can also simply use https://github.com/zowens/vim-eclim, with the current Eclim.
        " "if has('nvim')
        " "  Plug 'juanes852/Eclim-for-Neovim'
        " "endif
        " " Voir aussi : https://github.com/ervandew/eclim/issues/385, et https://github.com/juanes852/Eclim-for-Neovim.
        "
        " " https://github.com/dansomething/vim-eclim
        " "  Mirror of the VIM files from https://github.com/ervandew/eclim to support installation via various plugin managers. http://eclim.org
        " " PLEASE SEE https://github.com/dansomething/vim-eclim/issues/2
        " " AND https://github.com/Shougo/deoplete.nvim/issues/709
        " Plug 'dansomething/vim-eclim', { 'for': ['java', 'xml'], 'do': './install.sh --eclipse=/usr/lib/eclipse --plugins=jdt' }

        " Vim Javacomplete 2 {{{2
        " Updated javacomplete plugin for vim.
        " https://github.com/artur-shaik/vim-javacomplete2
        " So cool to generate getter / setter, etc.
        Plug 'artur-shaik/vim-javacomplete2' , { 'for': ['java'] }

        " " Vim refactor {{{2
        " " Generic Refactoring Plugin for Vim
        " " https://github.com/luchermitte/vim-refactor
        " " So cool plugin: TODO, test it

        " Java LSP COC {{{2
        " Language Server Protocol (LSP) support for vim & neovim, featured as VSCode
        " See https://github.com/neoclide/coc.nvim
        " Note: don't work well with Android Projects
        " https://github.com/redhat-developer/vscode-java/issues/10#issuecomment-268834749

        " OmniSharp {{{2
        " https://github.com/OmniSharp/omnisharp-vim
        " Vim omnicompletion (intellisense) and more for c# http://www.omnisharp.net

        Plug 'OmniSharp/omnisharp-vim', { 'for': ['cs', 'cshtml.html'] }

        " CSComment {{{2
        " https://github.com/vim-scripts/cscomment.vim
        " Automates creation of /// comments for C# methods
        " CAUSE CONFLICTS WITH DELIMITEMATE
        " Plug 'vim-scripts/cscomment.vim', { 'for': ['cs'] }

        " Vim csharp {{{2
        " https://github.com/oranget/vim-csharp
        " Enhancement's to Vim's C-Sharp Functionality
        Plug 'oranget/vim-csharp', { 'for': ['cs'] }

        " SQL Server Syntax {{{2
        " Syntax file for SQL Server 2005/2008
        " https://github.com/vim-scripts/sqlserver.vim
        Plug 'vim-scripts/sqlserver.vim'

        " Interesting link to JS {{{2
        " https://davidosomething.com/blog/vim-for-javascript/


        " Vim JavaScript {{{2
        " Vastly improved Javascript indentation and syntax support in Vim.
        " https://github.com/pangloss/vim-javascript
        Plug 'pangloss/vim-javascript', { 'for': ['javascript']}

        " YAJS {{{2
        " See below

        " Vim Js Indent {{{2
        " JavaScript indentation for VIM
        " https://github.com/gavocanov/vim-js-indent
        Plug 'gavocanov/vim-js-indent', { 'for': ['javascript', 'php', 'html', 'typescript']}

        " Javascript librairies {{{2
        " Syntax for JavaScript libraries
        " https://github.com/othree/javascript-libraries-syntax.vim
        " Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript']} # Issue
        if (&ft=='javascript')
            Plug 'othree/javascript-libraries-syntax.vim'
        endif

        " " Vim angular {{{2
        " " AngularJS with Vim
        " " https://github.com/burnettk/vim-angular
        " Plug 'burnettk/vim-angular', { 'for': ['javascript']}

        " " Bootstrap 3 snippets {{{2
        " " Twitter Bootstrap 3 Snippets for Vim
        " " https://github.com/chrisgillis/vim-bootstrap3-snippets
        " Plug 'chrisgillis/vim-bootstrap3-snippets', { 'for': ['javascript', 'html']}

        " Bootstrap 4 snippets {{{2
        " Bootstrap 4 markup snippets for Vim
        " https://github.com/jvanja/vim-bootstrap4-snippets
        Plug 'jvanja/vim-bootstrap4-snippets', { 'for': ['javascript', 'html']}

        " VIMPROC {{{2
        " Recommended to install
        " original repos on github
        " After install, turn shell ~/.vim/bundle/vimproc,
        " (n,g)make -f your_machines_makefile

        " Seems not work
        " Plug 'Shougo/vimproc', {
        " \ 'build' : {
        " \     'windows' : 'tools\\update-dll-mingw',
        " \     'cygwin'  : 'make -f make_cygwin.mak',
        " \     'mac'     : 'make -f make_mac.mak',
        " \     'linux'   : 'make',
        " \     'unix'    : 'gmake',
        " \    },
        " \ }
        "
        Plug 'Shougo/vimproc', { 'do': 'make'}

        " Vim Typscript support  {{{2
        " Typescript syntax files for Vim
        " https://github.com/Microsoft/TypeScript/wiki/TypeScript-Editor-Support#vim
        " Notes: With YouCompleteMe, as in an IDE, Tsuquyomi is lauching every time
        " one word is writing, and not only on « :wq » as with Syntastic. Doesn't
        " work with Deoplete.

        " Syntax
        Plug 'leafgarland/typescript-vim', { 'for': ['typescript']}
        Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript']}

        " Do not use Tsuquyomi and Syntaxic. Use ALE instead.
        " See https://github.com/Quramy/tsuquyomi/issues/82
        " Plug 'Quramy/tsuquyomi', { 'for': ['typescript']}
        " Not needed with ALE. Cause problems with ALE.
        " Plug 'clausreinke/typescript-tools.vim', { 'for': ['typescript']}

        " " vim-js-pretty-template {{{2
        " " highlights JavaScript's Template Strings in other FileType syntax rule http://www.vim.org/scripts/script.php…
        " " https://github.com/Quramy/vim-js-pretty-template
        " " Cause troubles with neovim-remote . `nvr --remote-tab ./index.js` does not open the tab
        " Plug 'Quramy/vim-js-pretty-template'

        " Vim-jsdoc {{{2
        " Generate JSDoc to your JavaScript code.
        " https://github.com/heavenshell/vim-jsdoc
        Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript', 'php', 'html', 'typescript']}

        " Tern for vim {{{2
        " Tern plugin for Vim
        " https://github.com/ternjs/tern_for_vim
        Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'php', 'html']}

        " vim-better-javascript-completion {{{2
        " An expansion of Vim's current JavaScript syntax file.
        " https://github.com/1995eaton/vim-better-javascript-completion
        Plug '1995eaton/vim-better-javascript-completion', { 'for': ['javascript', 'php', 'html']}

        " vim jsx {{{2
        " React JSX syntax highlighting and indenting for vim.
        " https://github.com/mxw/vim-jsx
        Plug 'mxw/vim-jsx'

        " Vim ejs {{{2
        " Vim syntax highlighting for javascript EJS html templates
        " https://github.com/nikvdp/ejs-syntax
        Plug 'nikvdp/ejs-syntax'

        " " Vim jst {{{2
        " " A vim plugin for highlighting and indenting JST/EJS syntax
        " " https://github.com/briancollins/vim-jst
        " Plug 'briancollins/vim-jst'

        " Vim mustache {{{2
        " Mustache template system for VIMScript
        " https://github.com/tobyS/vmustache
        Plug 'tobyS/vmustache', { 'for': ['php']}

        " PDV {{{2
        " PHP Documentor for VIM - Generates PHP docblocks
        " https://github.com/tobyS/pdv
        Plug 'tobyS/pdv' , { 'for' : ['php']}

        " Vim-perl {{{2
        " Support for Perl 5 and Perl 6 in Vim
        " https://github.com/vim-perl/vim-perl
        Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }

        " Perl support {{{2
        " https://github.com/vim-scripts/perl-support.vim
        Plug 'vim-scripts/perl-support.vim', { 'for' : ['perl'] }

        " Perldoc {{{ 2
        " Perldoc plugin for vim
        " https://github.com/hotchpotch/perldoc-vim
        Plug 'hotchpotch/perldoc-vim', { 'for' : ['perl'] }

        " " vim-superman {{{2
        " " https://github.com/jez/vim-superman
        " " Read Unix man pages faster than a speeding bullet! https://blog.jez.io/2014/12/20/vim-as-a-man-page-viewer/
        " Plug 'jez/vim-superman'

        " Neoman {{{2
        " A modern man page plugin for vim
        " https://github.com/nhooyr/neoman.vim
        Plug 'nhooyr/neoman.vim'

        " Zeal Vim {{{ 2
        " Zeal for Vim
        " https://github.com/KabbAmine/zeavim.vim
        Plug 'KabbAmine/zeavim.vim', {'on': [
                    \   'Zeavim', 'Docset',
                    \   '<Plug>Zeavim',
                    \   '<Plug>ZVVisSelection',
                    \   '<Plug>ZVKeyDocset',
                    \   '<Plug>ZVMotion'
                    \ ]}

        " vim-ipmotion {{{2
        " Improved paragraph motion http://www.vim.org/scripts/script.php?script_id=3952
        " https://github.com/justinmk/vim-ipmotion
        Plug 'justinmk/vim-ipmotion'

        " vim-abolish {{{2
        " https://github.com/tpope/vim-abolish
        Plug 'tpope/vim-abolish'

        " Vim Pager {{{2
        " Use Vim as PAGER http://www.vim.org/scripts/script.php…
        " https://github.com/rkitover/vimpager
        Plug 'rkitover/vimpager'


        " Vim ipmotion {{{2
        " https://github.com/terryma/vim-expand-region
        " Vim plugin that allows you to visually select increasingly larger regions of text using the same key combination.
        " Plug 'justinmk/vim-ipmotion'

        " Vim Grammalecte {{{2
        " https://github.com/dpelle/vim-Grammalecte
        " A vim plugin for the Grammalecte French grammar checker
        Plug 'dpelle/vim-Grammalecte'

        " Vim polyglot (distro) {{{2
        " https://github.com/sheerun/vim-polyglot
        " A solid language pack for Vim.
        Plug 'sheerun/vim-polyglot', { 'for': ['markdown']}
        " Form markdown, use https://github.com/gabrielelana/vim-markdown/issues/60
        " under the hood

        "" spaceneovim (distro) {{{2
        "" https://github.com/Tehnix/spaceneovim
        "" Spacemacs for Neovim

        " " Vim Peekaboo {{{2
        " " 👀 " / @ / CTRL-R
        " " https://github.com/occupytheweb/vim-peekaboo
        " Plug 'junegunn/vim-peekaboo'

        " Vim magit {{{2
        " https://github.com/jreybert/vimagit
        " Ease your git workflow within Vim
        Plug 'jreybert/vimagit'

        " Vim Gutter {{{2
        " https://github.com/airblade/vim-gitgutter
        " A Vim plugin which shows a git diff in the gutter (sign column) and stages/undoes hunks.
        Plug 'airblade/vim-gitgutter'

        " Vim sparql {{{2
        " Vim syntax file for SPARQL http://www.vim.org/scripts/script.php…
        Plug 'rvesse/vim-sparql'

        " Vim startify {{{2
        " The fancy start screen for Vim.
        " https://github.com/mhinz/vim-startify
        let g:startify_change_to_dir = 0
        " let g:startify_change_to_vcs_root = 1

        Plug 'mhinz/vim-startify'

        " vim-plugin-AnsiEs {{{2
        " https://github.com/powerman/vim-plugin-AnsiEsc
        " ansi escape sequences concealed, but highlighted as specified (conceal) http://www.vim.org/scripts/script.php…
        Plug 'powerman/vim-plugin-AnsiEsc'

        " === Fin plugins non installés par Guillaume {{{2

        "" UNITE {{{2
        "" Unite and create user interfaces
        "" http://www.vim.org/scripts/script.php?script_id=3396
        "" https://github.com/Shougo/unite.vim
        "Plug 'Shougo/unite.vim.git'
        "
        "     " NeoComplete {{{2
        " if !has('nvim')
        "     " https://github.com/Shougo/neocomplete.vim
        "     " Next generation completion framework after neocomplcache
        "     Plug 'Shougo/neocomplete'
        " endif


        " " NeoSnippet {{{2
        " " https://github.com/Shougo/neosnippet.vim
        " " neo-snippet plugin contains neocomplcache snippets source
        " Plug 'Shougo/neosnippet'

        " " NeoSnippet-snippets {{{2
        " " https://github.com/Shougo/neosnippet-snippets
        " " The standard snippets repository for neosnippet
        " Plug 'Shougo/neosnippet-snippets'

        "" unite-outline {{{2
        "" outline source for unite.vim
        "" https://github.com/h1mesuke/unite-outline
        "" http://d.hatena.ne.jp/h1mesuke/20101107/p1
        "" Call it with :unite outline
        "Plug 'h1mesuke/unite-outline'
        "
        "" unite-colorscheme {{{2
        "" https://github.com/ujihisa/unite-colorscheme
        "" A unite.vim plugin
        "Plug 'ujihisa/unite-colorscheme'
        "


        " " SYNTASTIC {{{2
        " " Syntax checking hacks for vim
        " " https://github.com/scroolose/syntastic
        " Plug 'scrooloose/syntastic'

        " Sensible {{{2
        " sensible.vim: Defaults everyone can agree on
        " http://www.vim.org/scripts/script.php?script_id=4391
        Plug 'tpope/vim-sensible'

        " Fugitive {{{2
        " fugitive.vim: a Git wrapper so awesome, it should be illegal
        " https://github.com/tpope/vim-fugitive
        Plug 'tpope/vim-fugitive'
        "
        "" Committia {{{2
        "" A Vim plugin for more pleasant editing on commit messages
        "Plug 'rhysd/committia.vim'
        "
        "" VimSession {{{2
        "" Extended session management for Vim (:mksession on steroids)
        "" https://github.com/xolox/vim-session
        "Plug 'xolox/vim-session.git', {
        "\ 'depends' : 'xolox/vim-misc.git'
        "\ }
        "
        " Repeat {{{2
        " repeat.vim: enable repeating supported plugin maps with "."
        " http://www.vim.org/scripts/script.php?script_id=2136
        " https://github.com/tpope/vim-repeat
        Plug 'tpope/vim-repeat'

        "" SpeedDating {{{2
        "" speeddating.vim: use CTRL-A/CTRL-X to increment dates, times, and more
        "" https://github.com/tpope/vim-speeddating
        "Plug 'tpope/vim-speeddating.git'

        "" EditorConfig {{{2
        "" EditorConfig plugin for Vim http://editorconfig.org
        "Plug 'editorconfig/editorconfig-vim'
        "
        "" Vinegar {{{2
        "" vinegar.vim: combine with netrw to create a delicious salad dressing
        "" https://github.com/tpope/vim-vinegar
        "Plug 'tpope/vim-vinegar.git'

        "" vim-eunuch {{{2
        "" tpope/vim-eunuch
        "" eunuch.vim: helpers for UNIX
        "" http://www.vim.org/scripts/script.php?script_id=4300
        "" https://github.com/tpope/vim-eunuch
        "Plug 'tpope/vim-eunuch'

        " Recover.vim {{{2
        " chrisbra/Recover.vim
        " A Plugin to show a diff, whenever recovering a buffer
        " http://www.vim.org/scripts/script.php?script_id=3068
        Plug 'chrisbra/Recover.vim'

        "" SearchParty {{{2
        "" Extended search commands and maps for Vim
        "Plug 'dahu/SearchParty'
        "
        " Surround {{{2
        " surround.vim: quoting/parenthesizing made simple
        " https://github.com/tpope/vim-surround
        Plug 'tpope/vim-surround'

        "" Vim-commentary {{{2
        "" http://www.vim.org/scripts/script.php?script_id=3695
        "" tpope/vim-commentary
        "" commentary.vim: comment stuff out
        "Plug 'tpope/vim-commentary'
        "
        " VimAirline {{{2
        " lean & mean status/tabline for vim that's light as air
        " https://github.com/bling/vim-airline
        Plug 'bling/vim-airline'

        "" vimwiki {{{2
        "" Personal Wiki for Vim
        "" https://github.com/vimwiki/vimwiki
        "" Key bindings
        "" see :h vimwiki-mappings
        "" normal mode:
        "" <Leader>ww -- Open default wiki index file.
        "" <Leader>wt -- Open default wiki index file in a new tab.
        "" <Leader>ws -- Select and open wiki index file.
        "" <Leader>wd -- Delete wiki file you are in.
        "" <Leader>wr -- Rename wiki file you are in.
        "" <Enter> -- Folow/Create wiki link
        "" <Shift-Enter> -- Split and folow/create wiki link
        "" <Ctrl-Enter> -- Vertical split and folow/create wiki link
        "" <Backspace> -- Go back to parent(previous) wiki link
        "" <Tab> -- Find next wiki link
        "" <Shift-Tab> -- Find previous wiki link
        "Plug 'vimwiki/vimwiki'
        "

        " Vim Quickscokp {{{2
        " Lightning fast left-right movement in Vim
        " https://github.com/unblevable/quick-scope
        Plug 'unblevable/quick-scope'

        " EasyMotion {{{2
        " Vim motions on speed!
        " https://github.com/Lokaltog/vim-easymotion
        Plug 'Lokaltog/vim-easymotion'
        "
        " Stupid-EasyMotion {{{2
        " A dumbed down version of EasyMotion
        " that aids navigation on the current line
        " We use the global leader
        " <Leader><Leader>w  - make every word a target
        " <Leader><Leader>W  - make every space separated word a target
        " <Leader><Leader>fx - make every character x in the line a target
        " Plug 'joequery/Stupid-EasyMotion'

        " Incsearch {{{2
        " Improved incremental searching for Vim
        " https://github.com/haya14busa/incsearch.vim
        Plug 'haya14busa/incsearch.vim'

        " " Incsearch easymotion {{{2
        " " https://github.com/haya14busa/incsearch-easymotion.vim
        " Plug 'haya14busa/incsearch-easymotion.vim'

        "" quickfixsigns {{{2
        "" Mark quickfix & location list items with signs
        "" http://www.vim.org/scripts/script.php?script_id=2584
        "" Plug 'vim-scripts/quickfixsigns'
        "Plug 'tomtom/quickfixsigns_vim'
        "
        "" VCSCOMMAND {{{2
        "" http://www.vim.org/scripts/script.php?script_id=90
        "" https://code.google.com/p/vcscommand/
        "Plug 'vcscommand.vim'
        "
        "" vDebug {{{2
        "" On remplace Xdebug par Vdebug apparement plus performant
        "" http://www.vim.org/scripts/script.php?script_id=4170
        "" https://github.com/joonty/vdebug
        "" Multi-language DBGP debugger client for Vim (PHP, Python, Perl, Ruby, etc.)
        "Plug 'joonty/vdebug.git'
        "
        "" AG.VIM {{{2
        "" https://github.com/rking/ag.vim
        "" Vim plugin for the_silver_searcher, 'ag', a replacement for the Perl module /
        "" CLI script 'ack'
        "Plug 'rking/ag.vim'
        "
        "" undotree.vim
        "" The ultimate undo history visualizer for VIM
        "" https://github.com/mbbill/undotree
        "Plug 'mbbill/undotree'
        "
        "" SUCKLESS {{{2
        "" https://github.com/fabi1cazenave/suckless.vim
        "" This plugin emulates the excellent wmii <http://wmii.suckless.org/> window
        "" manager in Vim.
        "Plug 'fabi1cazenave/suckless.vim'
        "
        " Tabularize ! {{{2
        " https://github.com/godlygeek/tabular
        " Vim script for text filtering and alignment
        " one  : 1
        " two  : 2
        " tree : 3
        " select text in visual mode, then hit : Tabularize /:
        " change the : with the needed char to align
        Plug 'godlygeek/tabular'

        " Mardwown {{{2
        " https://github.com/plasticboy/vim-markdown
        " Markdown Vim Mode http://plasticboy.com/markdown-vim-mode/
        " Plug 'plasticboy/vim-markdown', { 'for': ['markdown']}
        " COMPLELTY BUGGY ON LONG DOCUMENT!!
        " USE IT IN CONTEXT ON VIM POLYGLOT

        " " Mardown {{{2
        " " https://github.com/gabrielelana/vim-markdown
        " "  Markdown for Vim: a complete environment to create Markdown files
        " "  with a syntax highlight that doesn't suck!
        " " https://github.com/gabrielelana/vim-markdown/issues/60
        " TOO SLOW, USE VIM POLYGLOT INSTEAD
        " " https://github.com/gabrielelana/vim-markdown/issues/60
        " Plug 'gabrielelana/vim-markdown', { 'for': ['markdown'] }
        " let g:markdown_enable_conceal = 0
        " let g:markdown_mapping_switch_status = ''

        " Vim Markdown TOC {{{2
        " A vim 7.4+ plugin to generate table of contents for Markdown files.
        " https://github.com/mzlogin/vim-markdown-toc
        Plug 'mzlogin/vim-markdown-toc', { 'for': ['markdown']}

        " Markdown 2 Ctags {{{2
        " Generate ctags-compatible tags files for Markdown documents.
        " https://github.com/jszakmeister/markdown2ctags
        " Note: not a Vim Plugin
        Plug 'jszakmeister/markdown2ctags', { 'for': ['markdown']}

        " " Pandoc {{{2
        " " No updated, I use markdown-vim-mode
        " " Plug 'vim-pandoc/vim-pandoc', { 'for': ['md']}

        " " Not very usefull
        " " Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': ['md']}

        " Vim instant markdown {{{2
        " https://github.com/suan/vim-instant-markdown
        " Instant Markdown previews from VIm!
        Plug 'suan/vim-instant-markdown', { 'for': ['markdown']}
        let g:instant_markdown_slow = 1
        let g:instant_markdown_autostart = 0

        "" Characterize {{{2
        "" tpope/vim-characterize
        "" characterize.vim:
        "" Unicode character metadata
        "" http://www.vim.org/scripts/script.php?script_id=4410
        "Plug 'tpope/vim-characterize'
        "
        " Vim-DevIcons {{{2
        " https://github.com/ryanoasis/vim-devicons#installation
        " adds font icons (glyphs ★♨☢) to programming languages, libraries, and web
        " developer filetypes for: NERDTree, powerline, vim-airline, ctrlp, unite,
        " lightline.vim, vimfiler, and flagship
        Plug 'ryanoasis/vim-devicons'
        "
        "" goyo {{{2
        "" Distraction-free writing in Vim
        "" https://github.com/junegunn/goyo.vim
        "Plug 'junegunn/goyo.vim'
        "
        " vim-colors-solarized {{{2
        " precision colorscheme for the vim text editor
        " http://ethanschoonover.com/solarized
        " https://github.com/altercation/vim-colors-solarized
        Plug 'altercation/vim-colors-solarized'

        " " neovim-colors-solarized-truecolor-only {{{2
        " " https://github.com/frankier/neovim-colors-solarized-truecolor-only
        " " precision colorscheme for the vim text editor http://ethanschoonover.com/solarized
        " Plug 'frankier/neovim-colors-solarized-truecolor-only'

        " neovim-colors-solarized-truecolor-only {{{2
        " https://github.com/JulioJu/neovim-qt-colors-solarized-truecolor-only
        " precision colorscheme for the vim text editor http://ethanschoonover.com/solarized
        " precision colorscheme for the neovim qt text editor http://ethanschoonover.com/solarized
        Plug 'JulioJu/neovim-qt-colors-solarized-truecolor-only'

        "" Vividchalk {{{2
        "" a colorscheme strangely reminiscent of Vibrant Ink for a
        "" certain OS X editor
        "" https://github.com/tpope/vim-vividchalk
        "" http://www.vim.org/scripts/script.php?script_id=1891
        "Plug 'tpope/vim-vividchalk.git'
        "
        "" jellybeans.vim {{{2
        "" A colorful, dark color scheme for Vim.
        "" http://www.vim.org/scripts/script.php?script_id=2555
        "" https://github.com/nanotech/jellybeans.vim
        "Plug 'nanotech/jellybeans.vim'
        "
        " TagBar {{{2
        " Vim plugin that displays tags in a window, ordered by class etc.
        " https://github.com/majutsushi/tagbar
        Plug 'majutsushi/tagbar'

        "" guyzmo/notmuch {{{2
        "Plug 'guyzmo/notmuch-abook'
        "
        " Lazy specific plugins and others bundles {{{1

        "" a.vim {{{2
        "" A few of quick commands to swtich between source files and header files
        "" quickly.
        " Plug 'vim-scripts/a.vim', { 'for': ['c', 'h'] }

        "" Vim-OrgMode {{{2
        "" Text outlining and task management for Vim based on Emacs' Org-Mode
        "" https://github.com/jceb/vim-orgmode
        "Plug 'jceb/vim-orgmode', { 'for': 'org' } | Plug 'vim-scripts/utl.vim'

        " " Rails {{{2
        " " rails.vim: Ruby on Rails power tools
        " " https://github.com/tpope/vim-rails
        " Plug 'tpope/vim-rails', { 'for': 'ruby' }

        " lua-ftplugin {{{2
        " Lua file type plug-in for the Vim text editor
        " http://peterodding.com/code/vim/lua-ftplugin
        " https://github.com/xolox/vim-lua-ftplugin
        Plug 'xolox/vim-lua-ftplugin' , { 'for': 'lua' } | Plug 'xolox/vim-misc'

        " moonscript-vim {{{2
        " leafo/moonscript-vim
        " MoonScript support for vim http://moonscript.org
        Plug 'leafo/moonscript-vim' , { 'for': 'moon' }

        " elzr: json {{{2
        " A better JSON for Vim: distinct highlighting of keywords vs values,
        " JSON-specific (non-JS) warnings, quote concealing. Pathogen-friendly.
        " https://github.com/elzr/vim-json
        Plug 'elzr/vim-json', { 'for': ['javascript', 'json'] }

        " yaml {{{2
        Plug 'avakhov/vim-yaml', { 'for': ['python', 'yaml'] }

        " vim-systemd-syntax {{{2
        Plug 'Matt-Deacalion/vim-systemd-syntax', { 'for': 'systemd' }

        " php.vim {{{2
        " old::
        " Plug 'php.vim'
        " 20141028: Change to new StanAngeloff
        " https://github.com/StanAngeloff/php.vim
        Plug 'StanAngeloff/php.vim', { 'for': 'php' }

        " Better PHP indent {{{2
        " The official VIm indent script for PHP
        " http://www.2072productions.com/to/phpindent.txt
        " https://github.com/2072/PHP-Indenting-for-VIm
        Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }

        " PHP Getter / Setter {{{2
        " php_getset.vim
        " Automatically add getter/setters for PHP4 properties.
        " Commands:
        "  :InsertGetterSetter
        "      Inserts a getter/setter for the property on the current line, or
        "      the range of properties specified via a visual block or x,y range
        "      notation.  The user is prompted to determine what type of method
        "      to insert.
        "
        "  :InsertGetterOnly
        "      Inserts a getter for the property on the current line, or the
        "      range of properties specified via a visual block or x,y range
        "      notation.  The user is not prompted.
        "
        "  :InsertSetterOnly
        "      Inserts a setter for the property on the current line, or the
        "      range of properties specified via a visual block or x,y range
        "      notation.  The user is not prompted.
        "
        "  :InsertBothGetterSetter
        "      Inserts a getter and setter for the property on the current line,
        "      or the range of properties specified via a visual block or x,y
        "      range notation.  The user is not prompted.
        Plug 'vim-scripts/php_getset.vim', { 'for': 'php' }

        " CSS color {{{2
        " Highlight colors in css files
        " Plug 'skammer/vim-css-color'
        " http://ap.github.io/vim-css-color/
        " Plug 'ap/vim-css-color', { 'for': 'css' }
        " (useful for all languages)
        " Plug 'ap/vim-css-color'

        " css.vim {{{2
        " css.vim
        " Cutting-edge vim css syntax file
        " http://www.vim.org
        Plug 'JulesWang/css.vim', { 'for': ['css', 'sass', 'less', 'scss'] }

        " vim-css3-syntax {{{2
        " Add CSS3 syntax support to vim's built-in `syntax/css.vim`.
        " https://github.com/hail2u/vim-css3-syntax
        Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'sass', 'less', 'scss'] }


        " scss-syntax.vim {{{2
        " https://github.com/cakebaker/scss-syntax.vim
        " Vim syntax file for scss (Sassy CSS)
        Plug 'cakebaker/scss-syntax.vim', { 'for': ['sass', 'scss'] }

        " tpope/vim-haml {{{2
        " https://github.com/tpope/vim-haml
        " Vim runtime files for Haml, Sass, and SCSS
        Plug 'tpope/vim-haml', { 'for' : ['sass', 'scss', 'halm']}

        " html5.vim
        " TML5 omnicomplete and syntax
        " https://github.com/othree/html5.vim
        Plug 'othree/html5.vim', { 'for': ['html', 'xhtml', 'jsp'] }

        " YAJS.vim
        " Yet Another JavaScript Syntax for Vim
        " https://github.com/othree/yajs.vim
        Plug 'othree/yajs.vim', { 'for': ['javascript', 'html', 'php'] }

        " " sparkup {{{2
        " " A parser for a condensed HTML format
        " " https://github.com/rstacruz/sparkup
        " Same ase Emmet
        " Plug 'rstacruz/sparkup', { 'for': ['html', 'php', 'jsp', 'xml', 'dtd', 'xsd', 'xsl', 'xhtml'] }

        " ragtag {{{2
        " ragtag.vim: ghetto HTML/XML mappings (formerly allml.vim)
        Plug 'tpope/vim-ragtag', { 'for': ['html', 'php', 'jsp', 'xml', 'dtd', 'xsd', 'xsl', 'xhtml'] }

        " vim-latex {{{2
        " lervag/vim-latex
        " https://github.com/lervag/vim-latex
        " A simple and lightweight vim-plugin for editing LaTeX files.
        Plug 'lervag/vim-latex', { 'for': 'tex' }

        " BashSupport {{{2
        " BASH IDE -- Write and run BASH-scripts using menus and hotkeys.
        " https://github.com/vim-scripts/bash-support.vim
        Plug 'vim-scripts/bash-support.vim', { 'for': ['sh', 'bash', 'zsh'] }

        "" Bundle samples {{{2
        "" non github repos{{{3
        "" CommandT :     ================
        ""Bundle 'git://git.wincent.com/command-t.git'
        "" git repos on your local machine (ie. when working on your own plugin)
        ""Bundle 'file:///Users/gmarik/path/to/plugin'
        "" Just for ex of multi repo {{{3
        ""NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}
        "

        " NeoBundle end() {{{2
        " call neobundle#end()
        call plug#end()
        " Required
        filetype plugin indent on
        " If there are uninstalled bundles found on startup,
        " this will conveniently prompt you to install them.
        " NeoBundleCheck

        " Tweaking Plugins {{{1

        " === Plugin non installés par Guillaume {{{2
        "=== }}}
        " " SuperTab {{{2
        " " https://github.com/ervandew/supertab
        " " Perform all your vim insert mode completions with Tab
        " Useful for YCM
        " let g:SuperTabDefaultCompletionType = "context"
        " let g:SuperTabContextDefaultCompletionType = "<c-n>"

        " " Restore_view {{{2
        " " vim-scripts/restore_view.vim
        " " A plugin for automatically restoring file's cursor position and foldingu
        " " https://github.com/vim-scripts/restore_view.vim
        " set viewoptions=cursor

        " Vim buffergator {{2
        " Vim plugin to list, select and switch between buffers.
        " https://github.com/jeetsukumaran/vim-buffergator
        let g:buffergator_suppress_keymaps = 1

        " Vim Quickscokp {{{2
        " Lightning fast left-right movement in Vim
        " https://github.com/unblevable/quick-scope
        let g:qs_highlight_on_keys = ['f', 'F']

        " Vim tabber {{{2
        " A Vim plugin for labeling tabs, styled after Powerline, with additional tab management utilities.
        " https://github.com/fweep/vim-tabber
        set tabline=%!tabber#TabLine()

        " DelimitMate {{{2
        " https://github.com/Raimondi/delimitMate
        " Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc.
        " if has('nvim')
            let delimitMate_expand_cr = 1
        " endif

        " " Auto-pairs {{{2
        "
        " if !has('nvim')
        "     " https://github.com/jiangmiao/auto-pairs
        "     " Vim plugin, insert or delete brackets, parens, quotes in pair
        "     " WARNING : MY VERSION OF AUTO-PAIRS IS CUSTOMIZED
        "     au Filetype vim let b:AutoPairs = {"(": ")"}
        " endif

        " IndentLine {{{2
        " A vim plugin to display the indention levels with thin vertical lines A vim plugin to display the indention levels with thin vertical lines u
        " https://github.com/Yggdroot/indentLine
        " vertical line indentation (see config http://www.lucianofiandesio.com/vim-configuration-for-happy-java-coding)
        let g:indentLine_color_term = 239
        let g:indentLine_color_gui = '#09AA08'
        let g:indentLine_char = '│'

        " fzf {{{2
        " A command-line fuzzy finder written in Go
        " https://github.com/junegunn/fzf
        " https://github.com/junegunn/fzf.vim

        " https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
        command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

        let $FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude '.git' --exclude 'node_modules'"

        " Problems with Ctrl-{R,T} in Neovim terminal
        " https://github.com/junegunn/fzf/issues/809
        " Fixed
        " let $FZF_DEFAULT_OPTS .= ' --no-height'

        " Floating Windows Support From Neovim
        " Use nvim 0.4 +
        " https://github.com/junegunn/fzf.vim/issues/664
        " https://github.com/neoclide/coc.nvim/wiki/F.A.Q#how-to-make-preview-window-shown-aside-with-pum
        " `:echo exists('##CompleteChanged')` ==> 0 in nvim of april
        if has('nvim') && exists('##CompleteChanged')
            let $FZF_DEFAULT_OPTS='--layout=reverse'
            let g:fzf_layout = { 'window': 'call FloatingFZF()' }

            function! FloatingFZF()
            let buf = nvim_create_buf(v:false, v:true)
            call setbufvar(buf, '&signcolumn', 'no')

            let height = &lines - 3
            let width = float2nr(&columns - (&columns * 2 / 10))
            let col = float2nr((&columns - width) / 2)

            let opts = {
                    \ 'relative': 'editor',
                    \ 'row': 1,
                    \ 'col': col,
                    \ 'width': width,
                    \ 'height': height
                    \ }

            call nvim_open_win(buf, v:true, opts)
            endfunction
        endif

        " TComment {{{2
        " An extensible & universal comment vim-plugin that also handles embedded filetypes http://www.vim.org/scripts/script.php?script_id=1173
        " https://github.com/tomtom/tcomment_vim
        " Si on remet le remapage ici, ça plante. Du coup je l'ai mis plus bas @FIXME.

        " Vim ranger {{{2
        " Plug 'francoiscabrol/ranger.vim'
        " https://github.com/francoiscabrol/ranger.vim
        let g:ranger_map_keys = 0

        " " Deoplete {{{2
        " " https://github.com/Shougo/deoplete.nvim
        " " Dark powered asynchronous completion framework for neovim
        "
        " if has('nvim')
        "     " " Eclim support
        "     " " See https://www.reddit.com/r/vim/comments/5xspok/trouble_with_eclim_and_deoplete/
        "     " let g:deoplete#omni#input_patterns = {}
        "     " let g:deoplete#omni#input_patterns.java = '[^. *\t]\.\w*'
        "
        "     " Autoclose preview windows
        "     " https://github.com/Shougo/deoplete.nvim/issues/115
        "     autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
        "
        "     " https://github.com/Shougo/deoplete.nvim/issues/100
        "     " use tab to forward cycle
        "     inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
        "     " use tab to backward cycle
        "     inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
        "
        "     " Lazy load Deoplete to reduce statuptime
        "     " See manpage
        "     " Enable deoplete when InsertEnter.
        "     let g:deoplete#enable_at_startup = 0
        "     autocmd InsertEnter * call deoplete#enable()
        "
        "     " Context filetype
        "     " https://github.com/Shougo/deoplete.nvim/issues/133
        "     " See :help g:context_filetype#same_filetypes
        "     " And https://github.com/Shougo/deoplete.nvim/issues/578#issuecomment-344122258
        "     " let g:context_filetype#same_filetypes = 1
        " endif

        " Tagbar {{{2
        " https://github.com/majutsushi/tagbar
        " Vim plugin that displays tags in a window, ordered by scope http://majutsushi.github.io/tagbar/
        " Default definition are at
        " https://github.com/majutsushi/tagbar/blob/master/autoload/tagbar/types/uctags.vim
        " Below overwrite default definition.
        let g:tagbar_type_sh = {
                    \ 'ctagstype' : 'sh',
                    \ 'kinds' : [
                        \ 'f:functions',
                        \ 'e:exportvars',
                        \ 'V:varglobal',
                        \ 'a:alisases' ,
                        \ 's:script files'
                    \ ],
                    \ }

        let g:tagbar_show_linenumbers=2
        let g:tagbar_autofocus = 1

        " Add support for markdown files in tagbar.
        let g:tagbar_type_markdown = {
            \ 'ctagstype': 'markdown',
            \ 'ctagsbin' : '~/.vim/plugged/markdown2ctags/markdown2ctags.py',
            \ 'ctagsargs' : '-f - --sort=yes',
            \ 'kinds' : [
                \ 's:sections',
                \ 'i:images'
            \ ],
            \ 'sro' : '|',
            \ 'kind2scope' : {
                \ 's' : 'section',
            \ },
            \ 'sort': 0,
        \ }

        " ALE {{{2
        " Asynchronous Lint Engine
        " https://github.com/w0rp/ale

        " Use only Eclim
        " let g:ale_linters = {
        " \   'java': [''],
        " \}

        " Typescript
        " =======
        "  Set g:ale_lint_on_text_changed to never or normal. You won't get as
        "  frequent error checking, but ALE shouldn't block your ability to edit a
        "  document after you save a file, so the asynchronous nature of the plugin
        "  will still be an advantage.
        " TSserver seems only like continuous checking.
        " let g:ale_lint_on_text_changed = "never"
        " Set this. Airline will handle the rest.
        let g:airline#extensions#ale#enabled = 1
        " https://github.com/w0rp/ale/issues/1285
        " Enable completion where available.
        let g:ale_completion_enabled = 1
        " let g:ale_typescript_tslint_config_path = '../tslint.yaml'

        let g:ale_linters = {
                    \ 'cs': ['OmniSharp'],
                    \ 'cshtml.html': ['OmniSharp'],
                    \ 'java': ['checkstyle', 'google-java-format', 'pmd'],
                    \}
                    " \ 'javascript': ['eslint', 'tslint', 'tsserver'],
                    " \ 'css': ['csslint']

        " OmniSharp {{{2
        " https://github.com/OmniSharp/omnisharp-vim
        " Vim omnicompletion (intellisense) and more for c# http://www.omnisharp.net
        " https://github.com/OmniSharp/omnisharp-vim

        " See above
        " let g:ale_linters = {
        "             \ 'cs': ['OmniSharp']
        "             \}

        let g:OmniSharp_timeout = 5
        let g:OmniSharp_proc_debug = 1
        " see https://github.com/OmniSharp/omnisharp-vim/issues/427
        " let g:OmniSharp_server_path = '/media/data/home/omnisharp-roslyn/bin/Debug/OmniSharp.Http.Driver/net461/OmniSharp.exe'
        " let g:OmniSharp_server_path = '/media/data/home/omnisharp-roslyn/artifacts/publish/OmniSharp.Http.Driver/mono/OmniSharp.exe'
        " let g:OmniSharp_server_path = '/media/data/home/omnisharpBin9b5e3ebb/OmniSharp.exe'
        " let g:OmniSharp_server_use_mono = 1
        let g:OmniSharp_loglevel = 'debug'

"        let g:omnicomplete_fetch_full_documentation = 1

        " " YCM {{{2
        " " A code-completion engine for Vim
        " " https://github.com/Valloric/YouCompleteMe
        " " @TODO for every YCM update, delete in
        " " ~/.vim/plugged/YouCompleteMe/autoload/youcompleteme.vim :
        " " See https://github.com/Valloric/YouCompleteMe/pull/1415
        " " \ getbufvar( a:buffer, '&buftype' ) ==# 'nofile' ||
        "
        " " autocmd CompleteDone * pclose
        " let g:ycm_server_python_interpreter="/usr/bin/python3"
        "
        " " Support for TypeScript
        " " https://github.com/Microsoft/TypeScript/wiki/TypeScript-Editor-Support#vim
        " if !exists("g:ycm_semantic_triggers")
        "     let g:ycm_semantic_triggers = {}
        " endif
        " let g:ycm_semantic_triggers['typescript'] = ['.']
        "
        " let g:ycm_collect_identifiers_from_comments_and_strings = 1
        " let g:ycm_complete_in_comments = 1
        " let g:ycm_cache_omnifunc=0
        " let g:ycm_autoclose_preview_window_after_completion = 1

        " Ulti-Snip {{{2
        " UltiSnips - The ultimate snippet solution for Vim. Send pull requests to SirVer/ultisnips!
        " https://github.com/SirVer/ultisnips
        let g:UltiSnipsExpandTrigger="<leader>k"
        let g:UltiSnipsJumpForwardTrigger="<leader>j"
        let g:UltiSnipsJumpBackwardTrigger="<leader>z"
        let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippetsCustom"]

        " Vim Autoformat {{{2
        " https://github.com/Chiel92/vim-autoformat
        " Provide easy code formatting in Vim by integrating existing code formatters.
        " USE COMMAND « :Autoformat »
        let g:autoformat_verbosemode=1
        let g:formatdef_my_custom_php = '"html-beautify -f - -s ".shiftwidth()'
        let g:formatters_php = ['my_custom_php']
        let g:formatters_xml = ['my_custom_php']
        let g:formatters_xhtml = ['my_custom_php']
        let g:formatters_xsd = ['my_custom_php']

        " " Eclim {{{2
        " " http://eclim.org/
        " let g:EclimCompletionMethod = 'omnifunc'
        " let g:EclimJavascriptValidate = 0
        " let g:airline#extensions#eclim#enabled = 1

        " VisIncr {{{2
        " https://github.com/vim-scripts/VisIncr
        " Produce increasing/decreasing columns of numbers, dates, or daynames
        " See also « :norm 5 <C-X><c-A> »
        vnoremap <C-a> :I<CR>
        vnoremap <C-x> :I -1<CR>

        " PDV {{{2
        " PHP Documentor for VIM - Generates PHP docblocks
        " https://github.com/tobyS/pdv
        let g:pdv_template_dir = $HOME ."/.vim/plugged/pdv/templates_snip"
        nnoremap <buffer> <C-p> :call pdv#DocumentWithSnip()<CR>

        " " vim-js-pretty-template {{{2
        " " highlights JavaScript's Template Strings in other FileType syntax rule http://www.vim.org/scripts/script.php…
        " " https://github.com/Quramy/vim-js-pretty-template

        " " Cause troubles with neovim-remote . `nvr --remote-tab ./index.js` does not open the tab
        " autocmd FileType javascript JsPreTmpl html

        " " Cause some crashes.
        " " autocmd FileType typescript JsPreTmpl html

        " autocmd FileType typescript syn clear foldBraces " For leafgarland/typescript-vim users only. Please see #1 for details.

        " Vim-jsdoc {{{2
        " Generate JSDoc to your JavaScript code.
        " https://github.com/heavenshell/vim-jsdoc
        let g:jsdoc_allow_input_prompt=1
        let g:jsdoc_input_description=1
        let g:jsdoc_additional_descriptions=1

        " Javascript librairies {{{2
        " Syntax for JavaScript libraries
        " https://github.com/othree/javascript-libraries-syntax.vim
        " let g:used_javascript_libs = 'angularjs'
        " let g:used_javascript_libs = 'jquery'

        " Tern for vim {{{2
        " Tern plugin for Vim
        " https://github.com/ternjs/tern_for_vim
        let g:tern_show_argument_hints='on_hold'
        let g:tern_map_keys=1

        " " Vim JavaScript {{{2
        " " Vastly improved Javascript indentation and syntax support in Vim.
        " https://github.com/pangloss/vim-javascript
        let g:javascript_enable_domhtmlcss = 1
        let g:javascript_ignore_javaScriptdoc = 1

        " vim-better-javascript-completion {{{2
        " An expansion of Vim's current JavaScript syntax file.
        " https://github.com/1995eaton/vim-better-javascript-completion
        let g:vimjs#casesensistive = 1
        " Enabled by default. flip the value to make completion matches case insensitive
        let g:vimjs#smartcomplete = 0
        " Disabled by default. Enabling this will let vim complete matches at any location
        " e.g. typing 'ocument' will suggest 'document' if enabled.
        let g:vimjs#chromeapis = 0
        " Disabled by default. Toggling this will enable completion for a number of Chrome's JavaScript extension APIs

        " Emmet {{{2
        "  emmet for vim: http://emmet.io/
        "  http://mattn.github.io/emmet-vim
        let g:user_emmet_settings = {
        \    'html': {
        \        'empty_element_suffix': ' />',
        \    },
        \}

        " Vim Pager {{{2
        " Use Vim as PAGER http://www.vim.org/scripts/script.php…
        " https://github.com/rkitover/vimpager
        let g:vimpager = {}
        let g:less     = {}
        let g:vimpager.passthrough = 0
        let g:less.enabled = 0

        " Vim magit {{{2
        " https://github.com/jreybert/vimagit
        " Ease your git workflow within Vim
        " let g:magit_default_show_all_files = 0
        let g:magit_default_fold_level = 2
        let g:magit_discard_untracked_do_delete=1
        let g:magit_auto_foldopen = 1
        let g:magit_warning_max_lines=500

        " === Fin  Plugin non installés par Guillaume {{{2
        " }}}
        "" AG {{{2
        "" if available use ag
        "" From: http://robots.thoughtbot.com/faster-grepping-in-vim
        "" The Silver Searcher
        "if executable('ag')
        "  " Use ag over grep
        "  set grepprg=ag\ --nogroup\ --nocolor
        "endif
        "
        "" Unite {{{2
        "" Unite and create user interfaces
        "" http://www.vim.org/scripts/script.php?script_id=3396
        "" https://github.com/Shougo/unite.vim
        "" interresting :
        "" http://www.reddit.com/r/vim/comments/1fpti5/unitevim_the_plugin_you_didnt_know_you_need/
        "" http://bling.github.io/blog/2013/06/02/unite-dot-vim-the-plugin-you-didnt-know-you-need/
        "" nnoremap <C-p> :Unite file_rec/async<cr>
        "" Unite functions {{{3
        "" Function unite_settings()
        "" add distinct action to be used in a unite buffer
        "function! s:unite_settings()
        "    " To keep ?
        "    " seem's to overide supertab to not be used in unite,
        "    " not sure to want it.
        "    let b:SuperTabDisabled=1
        "    " original up j / down k
        "    " ctrl+t : Move down in the list
        "    imap <buffer> <C-t>   <Plug>(unite_select_next_line)
        "    " ctrl+s : Move up in the list
        "    imap <buffer> <C-s>   <Plug>(unite_select_previous_line)
        "    " ctrl+x : Open file in a new split
        "    imap <silent><buffer><expr> <C-x> unite#do_action('split')
        "    " ctrl+v : Open file in a new vertical split
        "    imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
        "    " ctrl+t : Open file in a new tab
        "    imap <silent><buffer><expr> <C-g> unite#do_action('tabopen')
        "    " Quit on escape
        "    nmap <buffer> <ESC> <Plug>(unite_exit)
        "endfunction
        "
        "" Unite Config {{{3
        "" Use ag for search
        "if executable('ag')
        "  let g:unite_source_grep_command = 'ag'
        "  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
        "  let g:unite_source_grep_recursive_opt = ''
        "endif
        "
        ""let g:unite_data_directory=s:get_cache_dir('unite')
        "let g:unite_source_history_yank_enable=1
        "let g:unite_source_rec_max_cache_files=5000
        "let g:unite_force_overwrite_statusline = 0
        "let g:unite_winheight = 10
        "
        "" Default filters :
        "" https://github.com/bling/dotvim/blob/master/vimrc
        "call unite#filters#matcher_default#use(['matcher_fuzzy'])
        "call unite#filters#sorter_default#use(['sorter_rank'])
        "" Custom source :
        "call unite#custom#source('line,outline','matchers','matcher_fuzzy')
        "" 20150121: old conf:
        "" http://eblundell.com/thoughts/2013/08/15/Vim-CtrlP-behaviour-with-Unite.html
        ""call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
        ""    \ 'ignore_pattern', join([
        ""    \ '\.git/',
        ""    \ ], '\|'))
        ""function! s:get_cache_dir(suffix)
        ""    return resolve(expand(s:cache_dir . '/' . a:suffix))
        ""endfunction
        "" Format the unite output to better
        "call unite#custom#profile('default', 'context', {
        "    \ 'start_insert': 1,
        "    \ 'direction': 'botright',
        "    \ })
        "
        "" Keep actions shortcut in distinct function: s:unite_settings()
        "autocmd FileType unite call s:unite_settings()
        "
        "" Unite mappings {{{3
        "" Unite grep
        "nnoremap <space>/ :Unite grep:.<cr>
        "let g:unite_source_history_yank_enable = 1
        "" Unite history / Yank
        "nnoremap <space>y :Unite history/yank<cr>
        "" Unite in buffer
        "nnoremap <space>s :Unite -quick-match buffer<cr>
        "" Show mapping
        "nnoremap <space>m :Unite mapping<cr>
        "" Show Syntastic error
        "nnoremap <space>x :Error<cr>
        "
        "" Emulate ctrl-p behavior quite general unite (all type)
        "nnoremap <C-P> :<C-u>Unite  -buffer-name=files   -start-insert buffer file_rec/async:!<cr>
        "

        " " NeoComplete {{{2
        " if !has('nvim')
        "     "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
        "     " Disable AutoComplPop.
        "     let g:acp_enableAtStartup = 0
        "     " Use neocomplete.
        "     let g:neocomplete#enable_at_startup = 1
        "     " Use smartcase.
        "     let g:neocomplete#enable_smart_case = 1
        "     " Set minimum syntax keyword length.
        "     let g:neocomplete#sources#syntax#min_keyword_length = 3
        "     let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
        "
        "     " Define dictionary.
        "     "@todo: find new dictionary
        "     let g:neocomplete#sources#dictionary#dictionaries = {
        "         \ 'default'  : '',
        "         \ 'vimshell' : $HOME.'/.vimshell_hist',
        "         \ 'scheme'   : $HOME.'/.gosh_completions'
        "         \ }
        "     let g:neocomplcache_disabled_sources_list = {'_' : ['dictionary_complete']}
        "     " Define keyword.
        "     " je fais esprét de me trompait
        "
        "     if !exists('g:neocomplete#keyword_patterns')
        "         let g:neocomplete#keyword_patterns = {}
        "     endif
        "     let g:neocomplete#keyword_patterns['default'] = '\h\w*'
        "
        "     " Plugin key-mappings.
        "     inoremap <expr><C-g>     neocomplete#undo_completion()
        "     inoremap <expr><C-l>     neocomplete#complete_common_string()
        "
        "     " Recommended key-mappings.
        "     " <CR>: close popup and save indent.
        "     inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
        "     function! s:my_cr_function()
        "         return neocomplete#close_popup() . "\<CR>"
        "         " For no inserting <CR> key.
        "         "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
        "     endfunction
        "     " <TAB>: completion.
        "     inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        "     " <C-h>, <BS>: close popup and delete backword char.
        "     inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
        "     inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
        "     " Conflict with emmet
        "     " inoremap <expr><C-y>  neocomplete#close_popup()
        "     inoremap <expr><C-e>  neocomplete#cancel_popup()
        "
        "     " Close popup by <Space>.
        "     "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
        "
        "     " For cursor moving in insert mode(Not recommended)
        "     "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
        "     "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
        "     "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
        "     "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
        "     " Or set this.
        "     "let g:neocomplete#enable_cursor_hold_i = 1
        "     " Or set this.
        "     "let g:neocomplete#enable_insert_char_pre = 1
        "
        "     " AutoComplPop like behavior.
        "     "let g:neocomplete#enable_auto_select = 1
        "
        "     " Shell like behavior(not recommended).
        "     "set completeopt+=longest
        "     "let g:neocomplete#enable_auto_select = 1
        "     "let g:neocomplete#disable_auto_complete = 1
        "     "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
        "
        "     " Enable omni completion.
        "     autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        "     autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        "     autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        "     autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        "     autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
        "
        "     " Enable heavy omni completion.
        "     if !exists('g:neocomplete#sources#omni#input_patterns')
        "         let g:neocomplete#sources#omni#input_patterns = {}
        "     endif
        "
        "     " For perlomni.vim setting.
        "     " https://github.com/c9s/perlomni.vim
        "     let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
        " endif

        " " NeoSnippet {{{2
        " " Plugin key-mappings.
        " imap <C-k>     <Plug>(neosnippet_expand_or_jump)
        " smap <C-k>     <Plug>(neosnippet_expand_or_jump)
        " xmap <C-k>     <Plug>(neosnippet_expand_target)
        "
        " " SuperTab like snippets behavior.
        " imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        "     \ "\<Plug>(neosnippet_expand_or_jump)"
        "     \: pumvisible() ? "\<C-n>" : "\<TAB>"
        " smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        "     \ "\<Plug>(neosnippet_expand_or_jump)"
        "     \: "\<TAB>"
        "
        " " For snippet_complete marker.
        " if has('conceal')
        "   set conceallevel=2 concealcursor=i
        " endif

        " " SYNTASTIC {{{2
        " " Syntax checking hacks for vim
        " " https://github.com/scrooloose/syntastic
        " let g:syntastic_always_populate_loc_list                              = 1
        " let g:syntastic_check_on_open                                         = 1
        " let g:syntastic_check_on_wq                                           = 0
        " let g:syntastic_enable_signs                                          = 1
        " let g:syntastic_aggregate_errors                                      = 1
        " let g:tsuquyomi_disable_quickfix                                      = 0
        " let g:syntastic_typescript_checkers                                   = [ 'tsuquyomi' ]
        " " let g:syntastic_typescript_checkers                                 = ['tslint', 'eslint', 'tsuquyomi' ]
        " let g:syntastic_php_checkers                                          = ['php', 'phpcs', 'phpmd']
        " " let g:syntastic_xsd_checkers                                        = ['xmllint'] " doesn't work, needs arguments, use eclim
        " " let g:syntastic_jsp_checkers                                        = ['xmllint'] " doesn't work, not very useful I think
        " let b:syntastic_mode                                                  = "active"
        " " from : https://github.com/scrooloose/syntastic/wiki/PHP%3A---phpcs
        " let g:syntastic_php_phpcs_args                                        = "--encoding=utf-8 --tab-width=4 --standard=PSR2"
        " let g:syntastic_html_tidy_exec                                        = '/usr/sbin/tidy'
        " set statusline+=%#warningmsg#
        " set statusline+=%{SyntasticStatuslineFlag()}
        " set statusline+=%*
        " let g:syntastic_c_checkers                                            = ['make','splint']
        " " let g:syntastic_auto_jump                                           = 3
        " " https://github.com/scrooloose/syntastic/issues/1041
        " " let g:syntastic_php_checkers                                        = ['php', 'tidy']
        " let g:syntastic_php_checkers                                          = ["php", "phpmd"]
        " " let g:syntastic_html_checkers                                       = ['tidy', 'jshint']
        " let g:syntastic_html_checkers                                         = ['tidy']
        " let g:syntastic_aggregate_errors                                      = 1
        " au BufEnter *.php set ft=php.html
        " let g:syntastic_enable_perl_checker                                   = 0
        " " let g:syntastic_perl_checkers                                         = ["perl"]
        " let g:syntastic_html_tidy_blocklevel_tags                             = ["medical-practice", "add-patient", "button-add-patient"]
        " " md, multiple, layout and minlength are for https://material.angularjs.org/latest/demo/input
        " " let g:syntastic_html_tidy_ignore_errors                               = [" proprietary attribute \"ng-",
        " "                                                                         \" proprietary attribute \"md-",
        " "                                                                         \" proprietary attribute \"flex-",
        " "                                                                         \" proprietary attribute \"flex",
        " "                                                                         \" proprietary attribute \"multiple",
        " "                                                                         \" proprietary attribute \"layout",
        " "                                                                         \" proprietary attribute \"minlength"
        " "                                                                         \ ]
        " let g:syntastic_javascript_checkers                                   = ['eslint']
        " " let g:syntastic_html_tidy_quiet_messages = {
        " "     \ "regex": [
        " "                 \ '^<md-.\+> is not recognized!$',
        " "                 \ '^discarding unexpected </md-.\+>$',
        " "                 \ '^discarding unexpected <md-.\+>$',
        " "                 \ '^<ng-.\+> is not recognized!$',
        " "                 \ '^discarding unexpected </ng-.\+>$',
        " "                 \ '^discarding unexpected <ng-.\+>$',
        " "                 \ '^<img> lacks "src" attribute$'
        " "                 \ ] }
        "

        " Language Client Neovim {{{2
        " https://github.com/autozimu/LanguageClient-neovim
        " Language Server Protocol (LSP) support for vim and neovim.

        " \ 'javascript': ['javascript-typescript-stdio'],
        " \ 'typescript': ['javascript-typescript-stdio'],
        " \ 'javascript.jsx': ['javascript-typescript-stdio'],
        let g:LanguageClient_serverCommands = {
                    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
                    \ 'sh': ['bash-language-server', 'start'],
                    \ }
        "

        function! LoadShortcutServerCommand()
            " nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
            " nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
            nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
            set completefunc=LanguageClient#complete
            set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
        endfunction

        autocmd FileType sh call LoadShortcutServerCommand()

        " Vim-Airline {{{2
        if &term=~'linux'
            let g:airline#extensions#tabline#enabled = 1
        elseif &term=~'screen'
            let g:airline#extensions#tabline#enabled = 1
            let g:airline_powerline_fonts = 1
        endif
        " See https://github.com/ryanoasis/vim-devicons
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#tabline#fnametruncate = 0
        " DBEXT {{{2
        " vim-scripts/dbext.vim
        " Provides database access to many dbms (Oracle, Sybase, Microsoft, MySQL,
        " DBI,..)
        " http://www.vim.org/scripts/script.php?script_id=356
        " https://github.com/vim-scripts/dbext.vim
        " help : ':h dbext-tutorial'
        " Default database (local)
        " MySQL
        let g:dbext_default_profile_mysql_local = 'type=MYSQL:user=root:passwd='':dbname=mysql'

        " CRA.vim {{{2
        " define cra filetype for lazy loading
        au BufRead,BufNewFile *.cra set filetype=cra

        "" VimSession {{{2
        "" Extended session management for Vim (:mksession on steroids)
        "" https://github.com/xolox/vim-session
        "let g:session_autoload = 'yes'
        "let g:session_autosave = 'yes'
        ""let g:session_autosave_periodic = 1

        " Mardwown {{{2
        " https://github.com/plasticboy/vim-markdown
        " Markdown Vim Mode http://plasticboy.com/markdown-vim-mode/
        " Plug 'plasticboy/vim-markdown', { 'for': ['markdown']}
        " COMPLELTY BUGGY ON LONG DOCUMENT!!
        " USE IT IN CONTEXT ON VIM POLYGLOT
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

        " PHP.vim {{{2
        " HighLight sql
        let php_sql_query = 1
        " HighLight HTML
        let php_htmlInStrings = 1
        " to highlight superglobals like $_GET, $_SERVER, etc.
        let php_special_vars = 1
        " to highlight functions with special behaviour
        let php_special_functions = 1
        " to highlight comparison operators in an alternate colour
        let php_alt_comparisons = 1
        " to highlight '=&' in '$foo =& $bar' in an alternate colour
        let php_alt_assignByReference = 1
        " syntax works out whether -> indicates a property or method
        let php_smart_members = 1
        " ... use a different color for '->' based on whether it is used
        " " for property access, method access, or dynamic access (using
        " " '->{...}')
        " " * requires php_smart_members
        let php_alt_properties = 1
        " ... 1: for folding classes and functions
        " 2: for folding all { } regions
        " 3: for folding only functions
        " TODO: documentation for php_folding_manual
        let php_folding = 3

        "" Committia {{{2
        "let g:committia_hooks = {}
        "function! g:committia_hooks.edit_open(info)
        "    " Additional settings
        "    " If no commit message, start with insert mode
        "    if a:info.vcs ==# 'git' && getline(1) ==# ''
        "        startinsert
        "    end
        "
        "    " Scroll the diff window from insert mode
        "    " Map <C-n> and <C-p>
        "    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
        "    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
        "
        "endfunction
        "
        "function! g:committia_hooks.diff_open(info)
        "    " No fold on the committia diff screen
        "    set nofoldenable
        "endfunction
        "
  " Vim core {{{1
  " Syntax {{{2
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
  set smartindent
  " https://georgebrock.github.io/talks/vim-completion/
  " Autocomplete with dictionary words when spell check is on
  set complete+=kspell

  " Modeline {{{2
  set modeline modelines=5

  "let g:git_modelines_allowed_items = [
  "    \ "textwidth",   "tw",
  "    \ "softtabstop", "sts",
  "    \ "tabstop",     "ts",
  "    \ "shiftwidth",  "sw",
  "    \ "expandtab",   "et",   "noexpandtab", "noet",
  "    \ "filetype",    "ft",
  "    \ "foldmethod",  "fdm",
  "    \ "readonly",    "ro",   "noreadonly", "noro",
  "    \ "rightleft",   "rl",   "norightleft", "norl",
  "    \ "cindent",     "cin",  "nocindent", "nocin",
  "    \ "smartindent", "si",   "nosmartindent", "nosi",
  "    \ "autoindent",  "ai",   "noautoindent", "noai",
  "    \ "spell",
  "    \ "spelllang"
  "    \ ]

  " TERM TYPE {{{2
  " Let's use screen-256
  " From: http://reyhan.org/2013/12/colours-on-vim-and-tmux.html
  "set term=screen-256color
  "set term=rxvt-unicode-256color
  " Just for vimShell
  "let g:vimshell_environment_term='rxvt-unicode-256color'

  "" Clipboard {{{2
  "" Set the clipboard if running inside X11
  "if has("X11")
  "    set clipboard=unnamedplus
  "else
  "    set clipboard=unnamed
  "endif
  "
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

  " PASTE / NOPASTE {{{2
  "@TODO: Not certain if really needed
  " A utiliser en live, paste désactive l'indentation automatique
  " (entre autre) et nopaste le contraire
  set nopaste

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

  "" Backups with persistent undos {{{2
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

  " " LINE WRAPPING {{{2
  " " Laisse les lignes déborder de l'écran si besoin
  " "set nowrap
  " " Ne laisse pas les ligne deborder de l'écran
  " " set si "Smart indent
  " if (&ft!='text' && &ft!='')
  "    set wrap "Wrap lines
  "    set linebreak
  "    set nolist
  "    " set formatoptions=a2wtqcj
  "    " Size of the linewrapping
  "    set textwidth=80
  "
  "
  "    " https://github.com/fabi1cazenave/dotFiles/blob/master/vim/vimrc
  "    " 80-character lines (= Mozilla guidelines)
  "    set textwidth=80         " line length above which to break a line
  "    set colorcolumn=+0       " highlight the textwidth limit
  "    " set nowrap
  "    " set nowrapscan
  "    " set linebreak
  "    " set formatoptions=wtcqj
  " endif

  " SPELL CHECKER {{{2
  " @TODO: Remap the mapping of the spell checker
  " @TOOD: Support auto detection of the sentence language,
  "        so it can support multi language fr / us / en / etc (jpn)
  " En live pour quand vous écrivez anglais (le fr est à trouver dans les méandres du net)
  " Chiant pour programmer, mais améliorable avec des dico
      " perso et par languages
  " set spell
  " [s / ]s : saute au prochain / précédant mot avec faute.
      " z= : affiche la liste de suggestion pour corriger.
  " set spelllang=fr,en
  "http://www.vim-fr.org/index.php/Correction_orthographique
  " MOVE CURSOR {{{2
  " Envoyer le curseur sur la ligne suivante/précédente après usage des flèches droite/gauche en bout de ligne :
  set whichwrap=<,>,[,]

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
  " set the background light or dark
  " set background=light
  set background=dark
  let g:solarized_termtrans = 1
  colorscheme solarized
  " Change le colorsheme en mode diff
  if &diff
      colorscheme solarized
  endif

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

  " Cursor {{{2
  " SHOW CURRENT LINE :
  set cursorline
  "SHOW CURRENT COLUMN :
  set cursorcolumn
  " SHOW CURSOR
  highlight Cursor  guifg=white guibg=black
  highlight iCursor guifg=white guibg=steelblue
  set guicursor=n-v-c:block-Cursor
  set guicursor+=i:ver100-iCursor
  set guicursor+=n-v-c:blinkon0
  set guicursor+=i:blinkwait10

  " LINE NUMBER {{{2
  " Show line number
  set number
  " Show number relative from the cursor
  set relativenumber

  " HighLighting {{{2
  augroup highlight
      " From «More Instantly Better Vim» - OSCON 2013
      " http://youtu.be/aHm36-na4-4
      " Highlight long lines
      autocmd ColorScheme * highlight OverLength ctermbg=darkblue ctermfg=white guibg=darkblue guibg=white
      autocmd ColorScheme * call matchadd('OverLength', '\%81v', 100)
      " Highlight TODO:
      autocmd ColorScheme * highlight todo ctermbg=darkcyan ctermfg=white guibg=darkcyan guibg=white
      autocmd ColorScheme * call matchadd('todo', 'TODO\|@TODO', 100)
      " Highlight MAIL:
      autocmd ColorScheme * call matchadd('todo', 'MAIL\|mail', 100)
      " Highlight WARNING:
      autocmd ColorScheme * call matchadd('todo', 'WARNING\|warning', 100)
      " Highlight misspelled word: errreur
      " autocmd ColorScheme * highlight SpellBad ctermfg=red guifg=red
      " Highlight BUGFIX / FIXME
      autocmd ColorScheme * highlight fix ctermbg=darkred ctermfg=white guibg=darkred guibg=white
      autocmd ColorScheme * call matchadd('fix', 'BUGFIX\|@BUGFIX\|bugfix\|FIXME\|@FIXME\|fixme', 100)
      " Highlight author
      autocmd ColorScheme * highlight author ctermfg=brown guibg=brown
      autocmd ColorScheme * call matchadd('author', 'author\|@author', 100)
      highlight NbSp ctermbg=015
      match NbSp /\%xa0/
  augroup END
      let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
      au BufEnter * RainbowParentheses
      " au Syntax * RainbowParenthesesLoadRound
      " au Syntax * RainbowParenthesesLoadSquare
      " au Syntax * RainbowParenthesesLoadBraces

  " AutoCmd {{{1
  " Fix filetype detection {{{2
  if has("autocmd")
      au BufRead            /var/log/kern.log set  ft=messages
      au BufRead            /var/log/syslog   setl ft=messages
      au BufNewFile,BufRead /etc/apache/*     setl ft=apache
      au BufNewFile,BufRead /etc/apache2/*    setl ft=apache
      au BufNewFile,BufRead /etc/nginx/*      setl ft=nginx
      au BufNewFile,BufRead /etc/exim4/*      setl ft=exim
      au BufNewFile,BufRead *.txt             setl ft=text
      " .tac files are used in twisted
      au BufNewFile,BufRead *.tac             setl ft=python
      " pygobject overrides
      au BufNewFile,BufRead *.override        setl ft=c
      " pygobject definitions
      au BufNewFile,BufRead *.defs            setl syntax=scheme et
      au BufNewFile,BufRead *.vala            setl ft=vala
      au BufNewFile,BufRead *.vapi            setl ft=vala
      au BufNewFile,BufRead *.qml             setl ft=javascript
      au BufNewFile,BufRead *.otl             setl ft=votl
      au BufNewFile,BufRead *.jeco            setl ft=eco
      au BufNewFile,BufRead *.glsl            setl ft=c
      au BufNewFile,BufRead *.html            setl ft=html
  endif

  "" AutoReLoad vimrc {{{2
  "" Auto apply modification to vimrc
  "if has("autocmd")
  "    autocmd bufwritepost ~/.vimrc     source ~/.vimrc
  "    autocmd bufwritepost ~/.vim/vimrc source ~/.vimrc
  "endif
  "
  " SESSION {{{2
  " Récupération de la position du curseur entre 2 ouvertures de fichiers
  if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                  \| exe "normal g'\"" | endif
  endif

  " Functions {{{1
  " AppendModeline() {{{2
  " Append modeline after last line in buffer.
  " Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
  " files.
  function! AppendModeline()
    let l:modeline = printf(" vim: set ft=%s ts=%d sw=%d tw=%d %set :",
          \ &filetype, &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    call append(line("$"), l:modeline)
  endfunction
  nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

  "" CLOSING {{{2
  "" ZZ now saves all files, creates a session and exits
  "function! AutocloseSession()
  "    wqall
  "endfunction
  "noremap <silent> ZZ :call AutocloseSession()<CR>


  " OpenTab and lcd to the file {{{2
  " Change local working dir upon tab creation
  function! TabNewWithCwD(newpath)
      :execute "tabnew " . a:newpath
      if isdirectory(a:newpath)
          :execute "lcd " . a:newpath
      else
          let dirname = fnamemodify(a:newpath, ":h")
          :execute "lcd " . dirname
      endif
  endfunction
  command! -nargs=1 -complete=file TabNew :call TabNewWithCwD("<args>")

  " Remove trailing whitespace {{{2
  function! CleanWhiteSpace()
      let l = line(".")
      let c = col(".")
      :%s/\s\+$//e
      let last_search_removed_from_history = histdel('s', -1)
      call cursor(l, c)
  endfunction()
  command! -nargs=0 CleanWhiteSpace :call CleanWhiteSpace()

  " Convert DOS line endings to UNIX line endings {{{2
  function! FromDos()
      %s/\r//e
  endfunction
  command! FromDos call FromDos()

  " Auto Chmod {{{2
  " Automatically give executable permissions if file begins with #! and
  " contains '/bin/' in the path
  function! MakeScriptExecuteable()
      if getline(1) =~ "^#!.*/bin/"
          silent !chmod +x <afile>
      endif
  endfunction

  " Mkdir Create missing directory {{{2
  " Used to create missing directories before writing a
  " buffer
  function! MkdirP()
      :!mkdir -p %:h
  endfunction
  command! MkdirP call MkdirP()

  " SHEBANG {{{2
  " shebang automatique lors de l'ouverture nouveau
  " d'un fichier *.py, *.sh (bash), modifier l'entête selon les besoins :
  " shell
  :autocmd BufNewFile *.sh,*.bash 0put =\"#!/bin/bash\<nl># -*- coding: UTF8 -*-\<nl>\<nl>\"|$
  " python
  :autocmd BufNewFile *.py 0put=\"#!/usr/bin/env python\"|1put=\"# -*- coding: UTF8 -*-\<nl>\<nl>\"|$
  " php
  :autocmd BufNewFile *.php 0put=\"<?php\<nl>// -*- coding: UTF8 -*-\<nl>\<nl>\"|$
  " perl
  :autocmd BufNewFile *.pl 0put=\"#!/usr/bin/env perl -w\"|1put=\"use strict;\"|2put=\"use feature qw(say switch evalbytes);\<nl>\<nl>\"|$

  nnoremap <space-a> :echom 'This is a Test !'<CR>

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

  "" VimSurround {{{2
  "let g:surround_no_mappings= 1
  "nmap ds  <Plug>Dsurround
  "nmap hs  <Plug>Csurround
  "nmap ys  <Plug>Ysurround
  "nmap yS  <Plug>YSurround
  "nmap yss <Plug>Yssurround
  "nmap ySs <Plug>YSsurround
  "nmap ySS <Plug>YSsurround

  "" vim-commentary {{{2
  "" remap for bépo
  "xmap gc  <Plug>Commentary
  "nmap gc  <Plug>Commentary
  "omap gc  <Plug>Commentary
  "nmap gcc <Plug>CommentaryLine
  "nmap hgc <Plug>ChangeCommentary
  "nmap gcu <Plug>Commentary<Plug>Commentary

  "" SearchParty {{{2
  "" Extended search commands and maps for Vim
  "" Remap * to #
  "" This is done to prevent error when remaping for bépo
  "nmap ^* <Plug>SearchPartyVisualFindNext
  "nmap ^l <Plug>SearchPartyHighlightClear

  "" SpeedDating {{{2
  "" Reselect after increment decrement
  "map <C-A> <Plug>SpeedDatingUpgv
  "map <C-X> <Plug>SpeedDatingDowngv
  "
  "" Vdebug tweak {{{2
  "let g:vdebug_keymap = {
  "\ "run"               : "<F5>",
  "\ "run_to_cursor"     : "<F1>",
  "\ "step_over"         : "<F2>",
  "\ "step_into"         : "<F3>",
  "\ "step_out"          : "<F4>",
  "\ "close"             : "<F6>",
  "\ "detach"            : "<F7>",
  "\ "set_breakpoint"    : "<F10>",
  "\ "get_context"       : "<F11>",
  "\ "eval_under_cursor" : "<F12>",
  "\ "eval_visual"       : "<Leader>e",
  "\ }
  "
  " EasyMotion {{{2
  " Vim motions on speed!
  " https://github.com/Lokaltog/vim-easymotion
   map <Leader> <Plug>(easymotion-prefix)
   nmap ,s <Plug>(easymotion-F)
   nmap ,f <Plug>(easymotion-f)
   nmap ,g <Plug>(easymotion-overwin-f2)
   let g:EasyMotion_keys = 'asdfghjklqwertyuiopzxcvbnm'
   let g:Easymotion_do_mapping=0

  " Incsearch {{{2
  " Improved incremental searching for Vim
  " https://github.com/haya14busa/incsearch.vim
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
  set hlsearch
  let g:incsearch#auto_nohlsearch = 0
  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)

  " " Incsearch easymotion {{{2
  " " https://github.com/haya14busa/incsearch-easymotion.vim
  "   map z/ <Plug>(incsearch-easymotion-/)
  "   map z? <Plug>(incsearch-easymotion-?)
  "   map zg/ <Plug>(incsearch-easymotion-stay)

  "" Disable Arrow in insert mode {{{2
  "ino <down>  <Nop>
  "ino <left>  <Nop>
  "ino <right> <Nop>
  "ino <up>    <Nop>
  "
  "" Disable Arrow in visual mode {{{2
  "vno <down>  <Nop>
  "vno <left>  <Nop>
  "vno <right> <Nop>
  "vno <up>    <Nop>
  "
  "" Remap Arrow Up/Down to move line {{{2
  "" Real Vimmer forget the cross
  "no <down>   ddp
  "no <up>     ddkP
  "
  "" Remap Arrow Right / Left to switch tab {{{2
  "no <left>   :tabprevious<CR>
  "no <right>  :tabnext<CR>
  "
  " " Remap netrw arrow {{{2
  " " From:
  " " http://unix.stackexchange.com/questions/31575/remapping-keys-in-vims-directory-view
  " augroup netrw_dvorak_fix
  "     autocmd!
  "     autocmd filetype netrw call Fix_netrw_maps_for_dvorak()
  " augroup END
  "
  " function! Fix_netrw_maps_for_dvorak()
  "     " {cr} = « gauche / droite »
  "     " @TODO: Remap to more vinegar related feature, like:
  "     " - c : Go back
  "     " - t : Preview (ranger inspired)
  "     noremap <buffer> c h
  "     noremap <buffer> r l
  "     " {ts} = « haut / bas »
  "     noremap <buffer> t j
  "     noremap <buffer> s k
  "     " noremap <buffer> d h
  "     " noremap <buffer> h gj
  "     " noremap <buffer> t gk
  "     " noremap <buffer> n l
  "     " noremap <buffer> e d
  "     " noremap <buffer> l n
  "     " and any others...
  " endfunction

  " Change default leader key {{{2
  let mapleader = ","

  "" Permet de sauvegarder par ctrl + s {{{2
  ":nmap <c-s> :w<CR>
  "" Fonctionne aussi en mode edition
  ":imap <c-s> <Esc>:w<CR>a
  ":imap <c-s> <Esc><c-s>

  " Completion avec ctrl + space {{{2
  inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
      \ "\<lt>C-n>" :
      \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
      \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
      \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
  imap <C-@> <C-Space>

  " " Est fait pour être utiliser seulement sur tout le document ;-). Du coup on serait obligé de faire forcément systématiquement « gg=G »
  " Tidy seems does not work with Vim in ArchLinux.
  augroup linterConfiguration
  "     autocmd FileType xml   setlocal  makeprg=xmllint\ -
  "     autocmd FileType xml   setlocal  equalprg=xmllint\ --format\ -
  "     " autocmd FileType html  setlocal  equalprg=tidy\ -q\ -i\ -w\ 80\ -utf8\ --quote-nbsp\ no\ --output-xhtml\ yes\ --show-warnings\ no\ --show-body-only\ auto\ --tidy-mark\ no\ -
  "     " For HTML5
  "     autocmd FileType html  setlocal  equalprg=tidy\ -q\ --show-errors\ 0\ --show-warnings\ 0\ --force-output\ --indent\ auto\ --indent-spaces
  " From https://stackoverflow.com/questions/815548/how-do-i-tidy-up-an-html-files-indentation-in-vi (but doesn't work, beacause html-beauty does not take into account of context. It considers first as the first line of the file!)
  " autocmd FileType html setlocal equalprg=tidy -config ~/.vim/tidyrc_html.txt
  " From https://github.com/wongyouth/vimfiles/blob/master/vimrc:
  " autocmd filetype html setlocal equalprg=html-beautify\ -f\ -\ -s\ 4 -l -1
  "     autocmd FileType xhtml setlocal  equalprg=tidy\ -q\ -i\ -w\ 80\ -utf8\ --quote-nbsp\ no\ --output-xhtml\ yes\ --show-warnings\ no\ --show-body-only\ auto\ --tidy-mark\ no\ -
  "     autocmd FileType json  setlocal  equalprg=python\ -mjson.tool
        autocmd FileType perl setlocal equalprg=perltidy\ -st
  augroup END

  " MOUSE {{{2
  " =======
  " Utilise la souris pour les terminaux qui le peuvent (tous ?)
  " pratique si on est habitué à coller sous la souris et pas sous le curseur,
  " attention fonctionnement inhabituel
  set mouse=a

  "
  " REMAP KEYBOARD for bépo {{{2
  " @FIXME: Detect keyboard layout (qwerty / bépo)
  " @TODO: Move it at the end, the config must not be layout dependant.
  " I use kind dvorak-fr the «bépo» layout on my keyboard.
  "source ~/.vim/vimrc.bepo
  "" remap number for direct access
  "" source ~/.vim/vimrc.num
  "
  "
  "noremap ' `
  "noremap ` '
  ""See http://vim.wikia.com/wiki/Using_marks
  "
  ""j -> ; et réciproquement
  "noremap j ;
  "noremap ; j


  " Remapage Kazé {{{2
  " https://github.com/fabi1cazenave/dotFiles/blob/master/config/nvim/mappings.vim#L32-L36
  " https://github.com/fabi1cazenave/dotFiles/blob/master/config/nvim/mappings.vim#L111-L120
  " https://github.com/fabi1cazenave/dotFiles/blob/master/config/nvim/init.vim#L131-L134

  source ~/.vim/mappings.vim

  "" Remapage perso {{{2
  "Ici, je défini la valeur de mapleader à , car la valeur par défaut, \ est loin d’être pratique.
  " let mapleader = ','
  noremap \ ,

  " Put in ~/.vim/ftplugin/java_mine.vim :   « noremap <Leader>w :wa<CR>:Java<CR><CR>G<C-w>w »

  noremap <Leader>w :w<CR>
  noremap <Leader>W :w !sudo tee % > /dev/null

  noremap <Leader>o o<Esc>k
  noremap <Leader>O O<Esc>

  augroup filetype_c
    autocmd!
    autocmd filetype c nnoremap <buffer> <Leader>à i#include <stdlib.h><CR>#include <stdio.h><CR><CR><ESC>
    autocmd filetype c nnoremap <buffer> <Leader>mai iint main (int argc, char *argv[]) {<CR><CR><CR>printf ("\n\n*********************************\n\n");<CR><CR><CR>printf ("\n\n*********************************\n\n");<CR>return 0;<CR>}<ESC>kkkkkki    <ESC>
    autocmd filetype p* nnoremap <buffer> <Leader>à i#!/usr/sbin/python3.4<CR># -*-coding:Utf-8 -*<CR><CR><ESC>
  augroup end

  nnoremap <leader><leader>t :tabnew<SPACE><CR>:
  nnoremap <leader><leader>v :vs<SPACE>
  nnoremap <leader><leader>e :e<SPACE>
  nnoremap <leader><leader>b :b<SPACE>
  nnoremap \t q:itabnew<SPACE>
  nnoremap \v q:ivs<SPACE>
  nnoremap \e q:ie<SPACE>
  nnoremap \\e :enew<CR>:bw#<CR>q:ie<SPACE>./

"http://asktherelic.com/2011/04/02/on-easily-replacing-text-in-vim/
" vmap <Leader>r "sy:%s/<C-R>=substitute(@s,"\n",'\\n','g')<CR>/
highlight NbSp ctermbg=015
match NbSp /\%xa0/

nnoremap <leader><leader>q :bd<CR>
nnoremap <leader><leader>d :bd#<CR>
  nnoremap <leader><leader><leader>t :tabnew<CR>:Terminal<CR>a
  nnoremap <leader><leader><leader>v :vs!<CR>:Terminal<CR><C-w><<C-w>>a
  nnoremap <leader><leader><leader>p :sp!<CR>:Terminal<CR><C-w>-<C-w>+a
  tnoremap <F5> <C-\><C-n>
  tnoremap <F4> <C-\><C-n><C-w>-<C-w>+<C-w><<C-w>>a
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
  tnoremap \t <C-\><C-n>q:itabnew<SPACE>
  tnoremap \v <C-\><C-n>q:ivs<SPACE>
  tnoremap \e <C-\><C-n>:enew!<CR>:bw!#<CR>q:ie<SPACE>
  set inccommand=split
else
  tnoremap <A-h> <C-w>h
  tnoremap <A-j> <C-w>j
  tnoremap <A-k> <C-w>k
  tnoremap <A-l> <C-w>l
  tnoremap <Leader>q <C-w>:bw!<CR>
  tnoremap <Leader>gt <C-w>gt<CR>
  tnoremap <Leader>gT <C-w>gT<CR>
  tnoremap <Leader>1gt <C-w>1gt<CR>
  tnoremap <Leader>2gt <C-w>2gt<CR>
  tnoremap <Leader>3gt <C-w>3gt<CR>
  tnoremap <Leader>4gt <C-w>4gt<CR>
  tnoremap <Leader>5gt <C-w>5gt<CR>
  tnoremap <Leader>6gt <C-w>6gt<CR>
  tnoremap <Leader>7gt <C-w>7gt<CR>
  tnoremap <Leader>8gt <C-w>8gt<CR>
  tnoremap <Leader>9gt <C-w>9gt<CR>
  tnoremap <leader><leader>t <C-w>:tabnew<SPACE>
  tnoremap <leader><leader>v <C-w>:vs<SPACE><CR><C-w><<C-w>>:enew<CR>:
  tnoremap <leader><leader>s <C-w>:sp<SPACE><CR><C-w>-<C-w>+:enew<CR>:
  tnoremap <leader><leader>b <C-w>:enew!<CR>:bw!#<CR>:b<SPACE>
  tnoremap <leader><leader>e <C-w>:enew!<CR>:bw!#<CR>:e<SPACE>
  tnoremap <leader><leader><leader>t <C-w>:tabnew<CR>:Terminal<CR>a
  tnoremap <leader><leader><leader>v <C-w>:vs<CR><C-w><<C-w>>:Terminal<CR>a
  tnoremap <leader><leader><leader>s <C-w>:sp<CR><C-w>-<C-w>+:Terminal<CR>a
  tnoremap \t <C-w>q:itabnew<SPACE>
  tnoremap \v <C-w>q:ivs<SPACE>
  tnoremap \e <C-w>:enew!<CR>:bw!#<CR>q:ie<SPACE>
endif
  nnoremap <leader>wwww :w<CR>:b#<CR><C-\><C-n>:bw#<CR>i
  " With Neovim 0.2.1 and 0.2.2 there is a bug with Terminal:
  " See https://github.com/neovim/neovim/issues/7677#issuecomment-348876942
" endif
nnoremap <leader>lll :mksession! /tmp/session.vim<CR>:!sed -i -e 's/urxvt-colours-solarized-dark/urxvt-colours-solarized-light/' ~/.vim/dotFilesOtherSoftwareVimCompliant/Xressources<CR>:!xrdb ~/.vim/dotFilesOtherSoftwareVimCompliant/Xressources<CR>:!sed -i -e 's/urxvt-colours-solarized-light/urxvt-colours-solarized-dark/' ~/.Xressources<CR>:qa<CR>
nnoremap <leader>uuu :source /tmp/session.vim<CR>:set highlight bg=light<CR><CR>
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Ajouts persos {{{1


"http://vim.wikia.com/wiki/Disable_automatic_comment_insertion This sets up an auto command that fires after any filetype-specific plugin; the command removes the three flags from the 'formatoptions' option that control the automatic insertion of comments. With this in your vimrc, a comment character will not be automatically inserted in the next line under any situation.
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" ColorScheme Julio
doautoall highlight ColorScheme
" "hi clear
" if has("gui_running")
"   set background=dark
"   colorscheme literal_tango "Supprimer le « hi clear » dans le colorshceme par défaut afin que ça n'écrase pas mes highlight persos. @TODO ou voir « help syntax-reset »
" else
"   set background=light "or put dark
" endif
" if has("unix")
"   hi SpellBad ctermbg=202
" endif
" " Pour les couleurs voir https://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg
" highlight Pmenu ctermbg=005 guibg=Purple
" highlight Search ctermbg=178
" highlight IncSearch ctermbg=118
" highlight visual ctermbg=249
hi CursorColumn ctermbg=239

map <silent> <F7> "<Esc>:silent setlocal spell! spelllang=fr,en<CR>"
autocmd BufNew,BufRead,BufEnter *.txt,*.md setlocal spell spelllang=fr,en
" let g:neosnippet#snippets_directory='~/.vim/neosnippet-snippets_customs/'
" Step the highlighting.
" ATTENTION, IL FAUT BIEN METTRE NNOREMAP, SINON, QUAND ON ENTRE EN VISUAL BLOCK, ÇA PLANTE QUAND ON VEUT REPASSER directement EN MODE INSERTION ^^
nnoremap i :noh<CR>i
nnoremap I :noh<CR>I
nnoremap a :noh<CR>a
nnoremap A :noh<CR>A

" Si on rement le remapage plus haut de TCOmment, à plante. Pourquoi ? @FIXME. J'ai essayé d'autres combinaisons, notamment de mettre des remapages vers <c-_>2<c-_>b, mais ça ne ça marche pas.
vnoremap <leader>c :call tcomment#SetOption("count", 2)<CR>gv:TCommentBlock<CR>
nnoremap <leader>c :TComment<CR>

" let g:neomake_c_gcc_maker = {
"     \ 'args': ['-o', '%<', '-Wall'],
"     \ }
" let g:neomake_c_enabled_makers = ['gcc']

noremap <leader>3 *N
nmap cp :let @" = expand("%<")<CR>p

noremap <Space> <C-d>zz
" http://stackoverflow.com/questions/23189568/control-space-vim-key-binding-in-normal-mode-does-not-work
noremap <NUL> <C-u>zz
" nnoremap <C-Space> <C-u>zz
" nnoremap <C-@> <C-Space>

set virtualedit=block

" Vim buffergator
" Vim plugin to list, select and switch between buffers.
" https://github.com/jeetsukumaran/vim-buffergator
" noremap <Leader>b :BuffergatorToggle<Cr>

" php.vim
" old::
" NeoBundle 'php.vim'
" 20141028: Change to new StanAngeloff
" https://github.com/StanAngeloff/php.vim
" PUT AT THE VERY END OF YOUR .VIMRC FILE.
function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END


" http://stackoverflow.com/questions/6453595/prevent-vim-from-clearing-the-clipboard-on-exit
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" Define word as word separator
" For it works in html, comment « "set isk+=. » in .vim/plugged/vim-colorsesque/after/syntax/css/vim-coloresque.vim:125.
" Or rather add
" if (&ft!='html')
"     :set isk+=.
" endif
" Doesn't work if we add « set isk-=. » at te end of .vim/plugged/vim-colorsesque/after/syntax/html.vim. Likewise if we add  it ~/.vim/syntax, not resolves it.
" Change ~/.vim/plugged/vim-coloresque/after/syntax/css/vim-coloresque.vim
autocmd FileType html,javascript,jsp set iskeyword-=.

" http://vim.wikia.com/wiki/Remove_unwanted_spaces
" However, this is a very dangerous autocmd to have as it will always strip trailing whitespace from every file a user saves. Sometimes, trailing whitespace is desired, or even essential in a file so be careful when implementing this autocmd.
autocmd BufWritePre * %s/\s\+$//e
" autocmd FileType c,cpp,java,php autocmd BufWritePre <buffer> %s/\s\+$//e

au BufRead,BufNewFile *.jsp set filetype=jsp.html

" http://vi.stackexchange.com/questions/5511/showing-a-different-background-color-or-layout-beyond-80-column-using-spf13
set textwidth=80
" fo-=t otherwise break line automatically
autocmd BufNewFile,BufReadPost *.md set filetype=markdown fo-=t
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
set fo-=t

" https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

cnoremap sv vert belowright sb<Space>

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

noremap <leader>z :FZF<CR>

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


" Autoread {{{2
" https://vi.stackexchange.com/questions/2702/how-can-i-make-vim-autoread-a-file-while-it-doesnt-have-focus

fun! AutoreadPython()
python << EOF
import time, vim
try: import thread
except ImportError: import _thread as thread # Py3

def autoread():
    vim.command('checktime')  # Run the 'checktime' command
    vim.command('redraw')     # Actually update the display

def autoread_loop():
    while True:
        time.sleep(1)
        autoread()

thread.start_new_thread(autoread_loop, ())
EOF
endfun

" Hightlight customization {{{2
let &colorcolumn="81,".join(range(81,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27
" highlight ColorColumn term=reverse ctermbg=1


" Headers {{{2

" https://www.tecmint.com/create-custom-header-template-for-shell-scripts-in-vim/
" https://www.thegeekstuff.com/2008/12/vi-and-vim-autocommand-3-steps-to-add-custom-header-to-your-file/

function! HeaderTypescript()
    0r ~/.vim/headers/typescript_headers.ts
    " so ~/.vim/headers/typescript_headers.ts
    " exe "1," . 6 . "g/File Name :.*/s//File Name : " .expand("%")
    exe "1," . 6 . "g/AUTHOR.*/s//AUTHOR: JulioJu/"
    exe "1," . 6 . "g#GITHUB.*#s##GITHUB: https://github.com/JulioJu"
    " exe "1," . 6 . "g/CREATED:.*/s//CREATED: " .strftime("%d-%m-%Y")
    exe "1," . 6 . "g/CREATED:.*/s//CREATED: " .strftime("%c")
endfunction
autocmd bufnewfile *.ts silent call HeaderTypescript()

function! UpdateModfiedDate()
    " let total_lines =  getfsize(expand(@%))
    let second_line = system("head -n 2 " . bufname("%") . " | tail -n 1")
    echom second_line
    if second_line =~ "AUTHOR: JulioJu"
        " See `:help keepjumps' for better examples
        keepjumps execute "1," . 6 . "g/MODIFIED:.*/s/MODIFIED:.*/MODIFIED: " .strftime("%c") | keepjumps execute "normal \<C-O>"
    endif
endfunction
autocmd Bufwritepre,filewritepre *.ts silent call UpdateModfiedDate()

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


if has('nvim')
    command! -nargs=0 Terminal :terminal
else
    " https://unix.stackexchange.com/questions/444682/opening-a-vertical-terminal-in-vim-8-1
    command! -nargs=0 Terminal :terminal ++curwin


    " https://vimrcfu.com/snippet/223
    " Use :ww instead of :WriteWithSudo
    cnoreabbrev terminal Terminal
    cnoreabbrev term Terminal
endif
