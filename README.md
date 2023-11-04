## Nvim

```sh
git clone https://github.com/JulioJu/vimrc ~/.vim
cd .config && ln -s ../.vim nvim
```

* Install Vim Plug https://github.com/junegunn/vim-plug

* Launch Neovim

## Zplug

```sh
ln -s ~/.vim/dotFilesOtherSoftwareVimCompliant/zshrc ~/.zshrc
```

Install zplug
https://github.com/zplug/zplug

## Installation with `git clone`

If you install zplug with `git clone`
```sh
chmod -R 755 .zplug
```

Into your .zshrc
```sh
source ~/.zplug/init.sh
```

After the end of the installation launch a new instance of `zsh`. If you have
launched zplug before steps above, remove `.zplug` directory.

## tig


```sh
ln -s ~/.vim/dotFilesOtherSoftwareVimCompliant/tigrc ~/.tigrc
```

## FZF

For ubuntu, do not install FZF via package manager. It is outdated.
 https://github.com/junegunn/fzf/issues/2996#issuecomment-1285834257


 Install it thanks git. Currently, in our .zshrc file, it's the fzf installed on
 ~/.fzf that is used.

## Licence
The project is under MIT License
