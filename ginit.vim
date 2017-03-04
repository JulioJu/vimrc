Guifont DejaVu Sans Mono:h9

" set background=light
" highlight Normal guibg=white
" SyntasticToggleMode
let g:solarized_nvimqt_termtrans = 1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme solarized_nvimqt
" Change le colorsheme en mode diff
if &diff
    colorscheme solarized_nvimqt
endif

highlight Normal guibg=black
