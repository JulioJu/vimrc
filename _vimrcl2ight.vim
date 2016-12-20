" http://usevim.com http://blog.benjaminperrin.fr/index.php/aide-memoire-vi http://ftp.traduc.org/doc-vf/gazette-linux/html/2008/152/lg152-C.html Introduction quelque peu avancée à Vim, intéressant.Pour l'historique et les backup, voir http://armaklan.org/blog/vim-et-la-configuration.html
"https://github.com/romainl/dotvim/wiki/Mon-.vimrc-en-d%C3%A9tails
"SUPER INTÉRESSANT : http://www.vim-fr.org/index.php/Astuces
set nocompatible "forcez la désactivation de cette compatibilité (en tout début de fichier, car ça change les options).
filetype plugin indent on

"REMAPAGE
"————————
"————————
"————————
set encoding=utf-8						 " toujours utiliser l'UTF8


let mapleader = ','
"Ici, je défini la valeur de mapleader à , car la valeur par défaut, \ est loin d’être pratique.
noremap \ ,

noremap <Leader>W :w !sudo tee % > /dev/null
noremap <Leader>o o<Esc>k
noremap <Leader>O O<Esc>j

augroup filetype_c
	autocmd!
	autocmd filetype c nnoremap <buffer> <Leader>à i#include <stdlib.h><CR>#include <stdio.h><CR><CR><ESC>
	autocmd filetype c nnoremap <buffer> <Leader>mai iint main (int argc, char *argv[]) {<CR><CR><CR>printf ("\n\n*********************************\n\n");<CR><CR><CR>printf ("\n\n*********************************\n\n");<CR>return 0;<CR>}<ESC>kkkkkki    <ESC>
	autocmd filetype p* nnoremap <buffer> <Leader>à i#!/usr/sbin/python3.4<CR># -*-coding:Utf-8 -*<CR><CR><ESC>
augroup end

nnoremap <leader>t :tabnew

"http://asktherelic.com/2011/04/02/on-easily-replacing-text-in-vim/
vmap <Leader>r "sy:%s/<C-R>=substitute(@s,"\n",'\\n','g')<CR>/
"Quand le texte est « wrappé » j et k ne fonctionnent que sur les lignes logiques : il faut donc utiliser gj et gk pour naviguer correctement dans une ligne « wrappée ». Comme gj et gk sont exactement équivalents à j et k même sans « wrap » on décide globalement que j et k font gj et gk.
noremap j gj
noremap k gk
noremap 0 g0
noremap $ g$

""« REMAPAGE CLAVIER BÉPO FROM http://bepo.fr/wiki/Vim
""" ———————————————————————————————————————————————————
""" ———————————————————————————————————————————————————
""
""" Remappage des touches
""" —————————————————————
""" HJKL -> CTSR
""" Quand on appuie sur la touche du clavier bépo « c », c'est comme si on appuyait sur la touche « h » en azerty. Donc, si dans une notice ils demandent d'appuyer sur h, en réalité faut appuyer sur la touche « c » de mon clavier bépo.
"" noremap c h
"" noremap r l
"""Quand le texte est « wrappé » j et k ne fonctionnent que sur les lignes logiques : il faut donc utiliser gj et gk pour naviguer correctement dans une ligne « wrappée ». Comme gj et gk sont exactement équivalents à j et k même sans « wrap » on décide globalement que j et k font gj et gk.
"" noremap t gj
"" noremap s gk
"" noremap 0 g0
"" noremap $ g$
"" noremap C H
"" noremap R L
"" noremap T J
"" noremap S K
""" HJKL <- CTSR
"" noremap j t
"" noremap J T
"" " {C} = « Change »             (c = attend un mvt, C = jusqu'à la fin de ligne)
"" noremap l c
"" noremap L C
"" " {R} = « Remplace »           (r = un caractère slt, R = reste en « Remplace »)
"" noremap h r
"" noremap H R
"" " {S} = « Substitue »          (s = caractère, S = ligne)
"" noremap k s
"" noremap K S
"" " Corollaire : correction orthographique
"" noremap ]k ]s
"" noremap [k [s
""
"""É remplace W (mot suivant), le W étant beaucoup trop loin en bépo ;
"""W est utilisé comme Ctrl+W pour faciliter les manipulations de fenêtre.
""" {W} -> [É]
""" ——————————
""" On remappe W sur É :
""noremap é w
""noremap É W
""noremap aé aw
""noremap aÉ aW
""noremap ié iw
""noremap iÉ iW
""" Corollaire: on remplace les text objects aw, aW, iw et iW
""" pour effacer/remplacer un mot quand on n’est pas au début (daé / laé).
""onoremap aé aw
""onoremap aÉ aW
""onoremap ié iw
""onoremap iÉ iW
""" Pour faciliter les manipulations de fenêtres, on utilise {W} comme un Ctrl+W :
""noremap w <C-w>
""noremap W <C-w><C-w>
""
""
""" Désambiguation de {g}
""" —————————————————————
""" ligne écran précédente / suivante (à l'intérieur d'une phrase)
"""noremap gs gk
"""noremap gt gj
""" onglet précédant / suivant
""noremap gb gT
""noremap gé gt
""" optionnel : {gB} / {gÉ} pour aller au premier / dernier onglet
""noremap gB :exe "silent! tabfirst"<CR>
""noremap gÉ :exe "silent! tablast"<CR>
""" optionnel : {g"} pour aller au début de la ligne écran
"""noremap g" g0
""
""" <> en direct
""" ————————————
""noremap « <
""noremap » >
""
""" Remaper la gestion des fenêtres
""" ———————————————————————————————
"""Voir aussi http://vimcasts.org/episodes/working-with-windows/, ou http://vimdoc.sourceforge.net/htmldoc/windows.html
""noremap wt <C-w>j
""noremap ws <C-w>k
""noremap wc <C-w>h
""noremap wr <C-w>l
"""noremap wd <C-w>c
"""ctrl+w c, je ne sais pas à quoi ça sert.
"""noremap wo <C-w>s
"""ctrl+w s split the current window horizontally, loading the same file in the new window
"""noremap wp <C-w>o
"""Make the current window the only one on the screen.  All other windows are closed.
"""noremap w<SPACE> :split<CR>
"""ou :sp
"""noremap w<CR> :vsplit<CR>
""
"""
"""" Chiffres en accès direct
"""" ————————————————————————
"""noremap " 1
"""noremap 1 "
"""noremap « 2
"""noremap 2 <
"""noremap » 3
"""noremap 3 >
"""noremap ( 4
"""noremap 4 (
"""noremap ) 5
"""noremap 5 )
"""noremap @ 6
"""noremap 6 @
"""noremap + 7
"""noremap 7 +
"""noremap - 8
"""noremap 8 -
"""noremap / 9
"""noremap 9 /
"""noremap * 0
"""noremap 0 *
""
"""Perso
"""—————
""noremap ' `
""noremap ` '
"""See http://vim.wikia.com/wiki/Using_marks
""
"""j -> ; et réciproquement
""noremap j ;
""noremap ; j
""
""inoremap <C-é> <ESC>dwi
""inoremap <C-Del> <C-o>db

"INDENTATION"
"————————————
"————————————
set autoindent								 " indentation auto
set backspace=indent,eol,start " indenter lors du retour chariot
set smartindent "Indentation intelligents

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
"http://vim.wikia.com/wiki/Disable_automatic_comment_insertion This sets up an auto command that fires after any filetype-specific plugin; the command removes the three flags from the 'formatoptions' option that control the automatic insertion of comments. With this in your vimrc, a comment character will not be automatically inserted in the next line under any situation.

set shiftwidth=4 "Number of spaces to use for each step of (auto)indent.  Used for |'cindent'|(Enables automatic C program indenting), |>>|, |<<|, etc.
set softtabstop=4							 " Quand on appuie sur tab, y'a décallage de x espaces. Quand expandtab est activé, seule cette valeur est importante. Quand expandtab n'est pas activée, dans ces x espaces s'y loge des tabulations d'une taille tabstop.
set tabstop=4									 " tab = 2 espaces. Une tabulation a pour taille 2 espaces
"set expandtab                   "Permet de toujours activer l'indentation en espace.
au BufNew,BufRead,BufEnter *.xml,*.sh,*.c,*.cc,*.cpp,*.h set expandtab "Remplace les tab par des blancs en C

set lbr												 " wrap on whitespaces (retour à la ligne logique (à l'affichage) sur les espaces et non pas au milieu du mot)
" COPIER COLLER PROBLÈMES
" ——————————————————————
" ——————————————————————
set pastetoggle=<f5>
"« Vim can be compiled with or without support for X11 clipboard integration. (p. 149)
"
"« Besides Vim's Built-in put commands, we can sometimes use the system paste command. However, using this can occasionally produce unexpected results running Vim inside a terminal. » (p. 154)
"
"Finally, we'll need to copy the following code into the system clipboard. Copying code listings from a PDF can produce strange results, so I recommend downloading the sample code and then opening it in another text editor (or a web browser) and using the system command.  (p. 154)
"
"** Ci après, un des problèmes que j'ai eu (mais pas le seul), et que je viens tout juste de résoudre) **
"When the 'autoindent' option is enabled, Vim preserves the same level of indentation each time we creat a new line. The leading whitspace at the start of each line in the clipboard is added on top of the automatic indent, and the result is that each line wanders further and further to the right.  (…) The 'paste' option allows use to manually warm Vim that we're about to use the system past command.  (…)(p.155)
"
"That means switching back to Normal mode and then runnin the Ex command :set past!. (…) we can assign a key to 'pastetoggle' option :set pastetoggle=<f5> (…) It should work both in Insert and Normal modes.
"
"Neil Drew,  Tim Pope, Practical Vim: edit text at the speed of thought, Kay Keppler, Dallas, 2012.

" Enable mouse use in all modes
 set mouse=a


"RECHERCHE
"———————————
"———————————
set  incsearch "Le curseur se déplace dans les résultats au fur et à mesure de la saisie (comme sous Firefox). Autrement appelée recherche incrémentielle
set hlsearch  "   active ou désactive la recherche en surbrillance.
set ignorecase              "Ignore la casse lors de recherche

"Stop the highlighting for the 'hlsearch' option.  It is automatically turned back on when using a search command, or setting the 'hlsearch' option. ATTENTION ICI J'AI FAIT UNE GROSSE BOULETTE, IL FAUT BIEN METTRE NNOREMAP, SINON, QUAND ON ENTRE EN VISUAL BLOCK, ÇA PLANTE QUAND ON VEUT REPASSER directement EN MODE INSERTION ^^
nnoremap i :noh<CR>i
nnoremap I :noh<CR>I
nnoremap a :noh<CR>a
nnoremap A :noh<CR>A


"OPTIONS D'AFFICHAGES
"———————————————————
"———————————————————
"———————————————————
"———————————————
"———————————————————
"———————————————————
"———————————————————

"
""affiche la barre de titre
"set laststatus=2
""The advantage of having the status line displayed always is, you can see the current mode, file name, file status, ruler, etc.
"
set number
set showmode "affiche le mode d'édition
set ruler "affiche les coordonnés du curseur
set showcmd "affiche les commandes incomplète en bas de l'écran.
set showmatch " https://ensiwiki.ensimag.fr/index.php/Vimrc_minimal Lorsque l'on tape ), vim éclairera la ( correspondante ; fonctionne aussi pour les < > lors de l'édition HTML/XML, les { }, etc : tous les délimiteurs de tous les languages, lorsque c'est pertinent... Cette option est utile pour repérer les parenthèses non fermées (vim les colorie en blanc) et les parenthèses en trop (en rouge).
se visualbell   "Evite les biiiiiips
" set viminfo="NONE" " If you exit Vim and later start it again, you would normally lose a lot of information.  The viminfo file can be used to remember that information, which enables you to continue where you left off.http://vimdoc.sourceforge.net/htmldoc/starting.html#viminfo-file
"set scrolloff=1000 "Permet d'avoir constamment la ligne courante au centre de l'écran.

" Pour aller à la ligne suiv/préc quand on arrive à la fin/début
set whichwrap+=h,l

"http://www.vim-fr.org/index.php/Correction_orthographique
map <silent> <F7> "<Esc>:silent setlocal spell! spelllang=fr<CR>"
autocmd BufNew,BufRead,BufEnter *.txt,*.tmp setlocal spell spelllang=fr
set showtabline=0 " If you want to see the tab bar all the time http://www.linux.com/learn/tutorials/442422-vim-tips-using-tabs

"Function DeleteEmptyBuffers See http://stackoverflow.com/questions/6552295/deleting-all-empty-buffers-in-vim

" COLORATION
"————————————
"————————————
syntax on
" set background=dark colorise autrement (j'aime pas).
" colorise les nbsp
" set listchars=nbsp:¤,tab:>-,trail:¤,extends:>,precedes:<
" set list " Visualiser les caractères spéciaux (tabulations, fins de lignes etc.)
"http://bepo.fr/wiki/Vim http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight NbSp ctermbg=lightgray guibg=lightred
match NbSp /\%xa0/
"http://gvallver.perso.univ-pau.fr/?p=283

"colorscheme murphy
"colorscheme tango "https://github.com/Arkham/vim-tango/blob/master/colors/tango.vim

hi SpellBad ctermbg=202
highlight Search ctermbg=178
highlight IncSearch ctermbg=118
"GVIM
"————
"http://vim.wikia.com/wiki/Restore_missing_gvim_menu_bar_under_GNOME See also help 'guioptions'
set guioptions-=T
set guioptions-=r
set guifont=Monospace\ 14

"http://vim.wikia.com/wiki/Hide_toolbar_or_menus_to_see_more_text
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar

"http://stackoverflow.com/questions/12448179/how-to-maximize-vims-windows-on-startup-with-vimrc
au GUIEnter * call system('wmctrl -i -b add,fullscreen -r '.v:windowid)

highlight Normal guifg=White guibg=Black


" Vim-plug
call plug#begin('~/.vim/plugged')
 " My Bundles here:


" Stupid-EasyMotion
" A dumbed down version of EasyMotion
" that aids navigation on the current line
" We use the global leader
" <Leader><Leader>w  - make every word a target
" <Leader><Leader>W  - make every space separated word a target
" <Leader><Leader>fx - make every character x in the line a target
Plug 'joequery/Stupid-EasyMotion'
Plug 'ap/vim-css-color'
Plug 'junegunn/rainbow_parentheses.vim'
call plug#end()

let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
au BufEnter * RainbowParentheses

 " Required:
 filetype plugin indent on
