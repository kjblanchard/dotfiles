# Supergoon IDE

## To do it

    $ git clone --bare <git-repo-url> $HOME/.dotfiles
    $ alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
    $ dotfiles checkout
    $ dotfiles config --local status.showUntrackedFiles no

- make an alias in your rc file dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
- [Arch wiki](https://wiki.archlinux.org/title/Dotfiles#Tracking_dotfiles_directly_with_Git)


run this command:

- git submodule update --init --recursive


## Install COC stuff
- need to run npm -ci inside of the coc vim extension folder

## Installed Language Servers (with install commands)

### C / C++ — clangd

- install: sudo apt install clangd
- CoC extension: :CocInstall coc-clangd

### CMake — cmake-language-server

    Install: pip install cmake-language-server

Python — jedi-language-server

    CoC extension: :CocInstall coc-pyright

YAML — yaml-language-server

    Install: sudo npm install -g yaml-language-server

    CoC extension: :CocInstall coc-yaml

JSON — vscode-json-language-server

    Install (included with HTML/CSS LS): sudo npm install -g vscode-langservers-extracted

    CoC extension: :CocInstall coc-json

HTML — vscode-html-language-server

    Install: sudo npm install -g vscode-langservers-extracted

    CoC extension: :CocInstall coc-html

CSS — vscode-css-language-server

    Install: sudo npm install -g vscode-langservers-extracted

    CoC extension: :CocInstall coc-css

Lua — lua-language-server

    Install: sudo npm install -g lua-language-server

    CoC extension: :CocInstall coc-sumneko-lua

Terraform — terraform-ls

    Install: sudo apt install terraform-ls

    CoC extension: :CocInstall coc-terraform

Bash — bash-language-server

    Install: sudo npm install -g bash-language-server

    CoC extension: :CocInstall coc-sh
