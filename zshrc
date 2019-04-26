# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# 直前のコマンドの重複を削除
setopt hist_ignore_dups
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# 同時に起動したzshの間でヒストリを共有
setopt share_history

# 補完機能を有効にする
autoload -Uz compinit
compinit -u
if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完候補を詰めて表示
setopt list_packed
# 補完候補一覧をカラー表示
zstyle ':completion:*' list-colors ''

# コマンドのスペルを訂正
setopt correct
# ビープ音を鳴らさない
setopt no_beep

unsetopt auto_menu
setopt auto_pushd # cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
setopt auto_cd # ディレクトリ名を入力するだけでcdできるようにする
setopt interactive_comments

# key
autoload history-search-end
zle -N history-beginning-search-forward-end history-search-end
zle -N history-beginning-search-backward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# alias
alias tree2='tree -L 2'
alias rm='trash-put' # rm -> trash commands
alias mecab='/usr/bin/mecab'
alias vim="nvim -c 'AirlineTheme solarized'"
alias tark="tar -zxvf"
alias tara="tar -zcvf"
alias bat="/usr/local/bat/bat"
alias cat="/usr/local/bat/bat"

# cd config
#[ -z "$ENHANCD_ROOT" ] && function chpwd { tree -L 1 } # enhancdがない場合
#[ -z "$ENHANCD_ROOT" ] || export ENHANCD_HOOK_AFTER_CD="tree -L 1" # enhancdがあるときはそのHook機構を使う
[ -z "$ENHANCD_ROOT" ] && function chpwd { ls } # enhancdがない場合
[ -z "$ENHANCD_ROOT" ] || export ENHANCD_HOOK_AFTER_CD="ls" # enhancdがあるときはそのHook機構を使う

# powerline-shell
function powerline_precmd() {
    PS1="$(~/.local/bin/powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() { 
    for s in "${precmd_functions[@]}"; do 
        if [ "$s" = "powerline_precmd" ]; then 
            return
        fi
    done
    precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi

export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
export STANFORD_MODELS=$HOME/nltk_data/tokenizers/stanford-segmenter-2018-02-27/data/pku.gz
export STANFORD_SEGMENTER=$HOME/nltk_data/tokenizers/stanford-segmenter-2018-02-27
export FZF_DEFAULT_OPTS="--height 70% --border --preview 'head -40 {}'"

# protobuf & cmake
export PROTOBUF=/usr
export PROTOC="$PROTOBUF/bin/protoc"
export PROTOBUF_LIBS="-L$PROTOBUF/lib64 -lprotobuf -D_THREAD_SAFE"
export PROTOBUF_CFLAGS="-I$PROTOBUF/include -D_THREAD_SAFE"
export CMAKE_ROOT=/usr/local/bin/cmake

eval "$(pyenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# preview https://qiita.com/Sa2Knight/items/6635af9fc648a5431685
# bat https://github.com/sharkdp/bat/blob/master/doc/README-ja.md
vimf() {
  files=$(ls) &&
  selected_files=$(echo "$files" | fzf -m --preview '/usr/local/bat/bat --color=always --style=header,grid {}') &&
  nvim $selected_files
}

#zplug https://blog.dais0n.net/zsh_like_fish/
source $HOME/.zplug/init.zsh
zplug 'zsh-users/zsh-syntax-highlighting'
zplug 'zsh-users/zsh-autosuggestions'
# プラグインがまだインストールされてないならインストールするか聞く
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load --verbose
