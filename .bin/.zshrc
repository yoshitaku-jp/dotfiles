#------------------------------
# General Settings
# ------------------------------

# 環境変数
export LANG=ja_JP.UTF-8

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

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
autoload colors
zstyle ':completion:*' list-colors ''

# コマンドのスペルを訂正
setopt correct
# ビープ音を鳴らさない
setopt no_beep

# ディレクトリスタック
DIRSTACKSIZE=100
setopt AUTO_PUSHD

# git
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

# プロンプトカスタマイズ
PROMPT='
[%B%F{red}%n@%m%f%b:%F{green}%~%f]%F{cyan}$vcs_info_msg_0_%f
%F{yellow}$%f '

# ------------------------------
# env Settings
# ------------------------------

# Load rbenv
if [ -e "$HOME/.rbenv" ]; then
    export PATH="$HOME/.rbenv/shims:$PATH"
    eval "$(rbenv init - zsh)"
fi

# Load nodenv
if [ -e "$HOME/.nodenv" ]; then
    export PATH="$HOME/.nodenv/bin:$PATH"
    export PATH="$HOME/.nodenv/shims:$PATH"
    eval "$(nodenv init - zsh)"
fi

# Load pyenv
if [ -e "$HOME/.pyenv" ]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init - zsh)"
fi

# ------------------------------
# Other Settings
# ------------------------------

alias g="git"

# cdコマンド実行後、lsを実行する
function cd() {
   builtin cd $@ && ls;
}

function pecofind() { # find コマンドの出力結果をpeco する
  if [ $# -eq 0 ]; then
    find . | peco
  else
    find $1 | peco
  fi
}
function pecofindd() { # find コマンドの出力結果をpeco する。 ファイルが選ばれたら1つ手前のディレクトリを返す
  if [ $# -eq 0 ]; then
    finded=`find . | peco`
  else
    finded=`find $1 | peco`
  fi
  if [ -f $finded ]; then
    echo $finded | perl -pe 's/\/[^\/]*$/\n/g'
  else
    echo $finded
  fi
}
function cdp() {
  dir=$(pecofindd $1)
  echo "\e[32;1mcd\e[m \e[32;1;4m$dir\e[m"
  cd $dir
}
function lsp() {
  file=$(pecofind $1)
  echo "\e[32;1mls\e[m \e[32;1;4m$file\e[m"
  ls $file
}
function rmp() {
  file=$(pecofind $1)
  echo "\e[32;1mrm\e[m \e[32;1;4m$file\e[m"
  rm $file
}
function treep() {
  file=$(pecofind $1)
  echo "\e[32;1mtree\e[m \e[32;1;4m$file\e[m"
  tree $file
}
function catp() {
  file=$(pecofind $1)
  echo "\e[32;1mcat\e[m \e[32;1;4m$file\e[m"
  cat $file
}
function vimp() {
  file=$(pecofind $1)
  echo "\e[32;1mvim\e[m \e[32;1;4m$file\e[m"
  vim $file
}

# ------------------------------
# GitHub Settings
# ------------------------------

# コマンドの履歴を表示し選択
function peco-select-history() {
    # historyを番号なし、逆順、最初から表示。
    # 順番を保持して重複を削除。
    # カーソルの左側の文字列をクエリにしてpecoを起動
    # \nを改行に変換
    BUFFER="$(history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
    CURSOR=$#BUFFER             # カーソルを文末に移動
    zle -R -c                   # refresh
}
zle -N peco-select-history
bindkey '^R' peco-select-history

# リポジトリを選択して移動
function peco-src () {
    local repo=$(ghq list | peco --query "$LBUFFER" --initial-filter=Fuzzy)
    if [ -n "$repo" ]; then
        repo=$(ghq list --full-path --exact $repo)
        BUFFER="cd ${repo}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# PRを選択してチェックアウト
function peco-checkout-pull-request () {
    local selected_pr_id=$(gh pr list | peco | awk '{ print $1 }')
    if [ -n "$selected_pr_id" ]; then
        BUFFER="gh pr checkout ${selected_pr_id}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-checkout-pull-request
bindkey "^g^p" peco-checkout-pull-request

# PRを選択してブラウザで表示
function peco-view-pull-request () {
    local selected_pr_id=$(gh pr list | peco | awk '{ print $1 }')
    if [ -n "$selected_pr_id" ]; then
        BUFFER="gh pr view --web ${selected_pr_id}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-view-pull-request
bindkey "^g^v" peco-view-pull-request
