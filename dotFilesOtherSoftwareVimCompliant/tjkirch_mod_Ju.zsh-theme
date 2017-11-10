ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
# As neovim isn't UTF clean, actually we should use a standard caracter (@) and
# not a weird caracter (⚡) as in offical tjkirch theme. Offical theme cause
# bug with the cursor in a git folder with files not staged.
# See https://github.com/neovim/neovim/issues/5992
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}@"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function prompt_char {
	if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo $; fi
}

PROMPT='%(?,,%{$fg[red]%}FAIL : $?%{$reset_color%}
)%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%} : %{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info) %_$(prompt_char) %{$fg[green]%}[%*]%{$reset_color%} '

# RPROMPT. Right Prompt.
# Dosn't work because in normal vi mode I display (cmd) on the right.
# RPROMPT='%{$fg[green]%}[%*]%{$reset_color%}'

# vim: ft=zsh
