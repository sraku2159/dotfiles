#!/bin/bash
# ~/.bashrc: executed by bash for non-login shells.

if [ -z "$PS1" ]; then
    return
fi 

# ===== 基本設定 =====
# ヒストリーサイズの設定
HISTSIZE=10000
HISTFILESIZE=20000
# 重複するコマンドを履歴に残さない
HISTCONTROL=ignoreboth:erasedups
# 履歴にタイムスタンプを追加
HISTTIMEFORMAT="%F %T "
# 複数行のコマンドを1行として履歴に保存
shopt -s cmdhist
# ディレクトリ名だけでcdする
shopt -s autocd
# 補完時に大文字小文字を区別しない
bind "set completion-ignore-case on"
# 補完候補を表示するときに、可能なら1回目から色を付ける
bind "set colored-completion-prefix on"
# 補完候補を表示するときに、可能なら1回目から色を付ける
bind "set colored-stats on"
# 補完候補をソートして表示
bind "set completion-prefix-display-length 2"
# 補完候補を一覧表示
bind "set show-all-if-ambiguous on"
# 補完候補を一覧表示
bind "set show-all-if-unmodified on"
# 補完候補をファイルタイプ別に色分け
bind "set visible-stats on"

# ===== プロンプト設定 =====
# Gitブランチ情報を取得する関数
git_branch() {
  local branch
  branch=$(git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
  if [ -n "$branch" ]; then
    echo "[$branch]"
  fi
}

# プロンプトの色設定
PS1_setup() {
  # リセット
  local RESET="\[\e[0m\]"
  
  # テキスト色
  local USER_COLOR="\[\e[38;5;064m\]"
  local PATH_COLOR="\[\e[38;5;166m\]"
  local BRANCH_COLOR="\[\e[38;5;075m\]"
  local ARROW_COLOR="\[\e[38;5;087m\]"
  
  # 背景色
  # local USER_BG="\[\e[30;48;5;000m\]"
  # local PATH_BG="\[\e[30;48;5;000m\]"
  # local BRANCH_BG="\[\e[30;48;5;000m\]"
  
  # プロンプト構築
  local USER_PART="${USER_BG}${USER_COLOR}\u@\h:${RESET}"
  local PATH_PART="${PATH_BG}${PATH_COLOR}\w${RESET}"
  local BRANCH_PART="${BRANCH_BG}${BRANCH_COLOR}\$(git_branch)${RESET}"
  local ARROW_PART="\n${ARROW_COLOR}>${RESET} "
  
  echo "${USER_PART}${PATH_PART}${BRANCH_PART}${ARROW_PART}"
}

# プロンプト設定を適用
PS1=$(PS1_setup)

# ===== エイリアス設定 =====
# OSに応じたエイリアス設定
if [[ "$(uname)" == "Darwin" ]]; then
  # macOS用エイリアス
  alias ls='ls -G'
else
  # Linux用エイリアス
  alias ls='ls --color=auto'
fi

# 共通エイリアス
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# 便利なエイリアス
alias pub="cat ~/.ssh/id_rsa.pub"
alias ping="/sbin/ping"
alias dp='docker compose'
alias now="date '+%Y%m%d%H%M%S'"
alias tf='terraform'
alias g='git'
alias bi='bundle config set --local path .bundle && bundle install'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias h='history'
alias path='echo -e ${PATH//:/\\n}'
alias ports='netstat -tulanp'
alias mkdir='mkdir -p'
alias df='df -h'
alias du='du -h'

# ===== ユーティリティ関数 =====
# コマンドが見つからない時のメッセージ
command_not_found_handle() {
  echo -e "\033[31m                          __                __ \n" \
          ".-.-.-. .---.-. .-----. |  |_. .-----. .--|  |\n" \
          "| | | | |  _  | |__ --| |   _| |  -__| |  _  |\n" \
          "|_____| |___._| |_____| |____| |_____| |_____|\n"
  return 127
}

# Dockerビルドをログに記録
docker-build-with-log() {
  docker build --progress=plain "$@" &> build.log
}

# ANSIカラーコードを表示
ansi() {
  echo "echo -e \"following sentence\" or printf 'following sentence'"
  echo 'Example: \\(e or 033)[XXm string \\(e or 33)[0m'
  for ((i = 1; i <= 7; i++)); do
    printf '\e[%dm%d\e[m ' $i $i
  done
  echo
  echo 'Example: \\(e or 033)[XXm string \\(e or 33)[0m'
  for ((i = 30; i <= 37; i++)); do
    printf '\e[%dm%d\e[m ' $i $i
  done
  for ((i = 40; i <= 47; i++)); do
    printf '\e[%dm%d\e[m ' $i $i
  done
  echo
  echo 'Example: \\(e or 033)[38;5;XXm string \\(e or 33)[0m'
  for ((i = 0; i < 16; i++)); do
    for ((j = 0; j < 16; j++)); do
      hex=$(($i*16 + $j))
      printf '\e[38;5;%dm%03d\e[m ' $hex $hex
    done
    echo ""
  done
}

# Base64 URL エンコード
base64url() {
  echo -n "$1" | base64 | tr "+/" "-_" | tr -d "="
}

# ディレクトリ作成と移動を同時に行う
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# ファイルを検索して編集
fe() {
  local file
  file=$(find . -type f -name "*$1*" | fzf -0 -1)
  if [ -n "$file" ]; then
    ${EDITOR:-vim} "$file"
  fi
}

# プロセスを検索して表示
psg() {
  ps aux | grep -v grep | grep "$1"
}

# 圧縮ファイルを自動的に展開
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar e "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# ===== 環境変数とPATH設定 =====
# PATH追加関数
add_to_path() {
  if [[ ":$PATH:" != *":$1:"* ]]; then
    if [ "$2" = "true" ]; then
      export PATH="$1:$PATH"
    else
      export PATH="$PATH:$1"
    fi
  fi
}

# OS特有の設定
if [[ "$(uname)" == "Darwin" ]]; then
  # macOS特有の設定
  export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
  add_to_path "/usr/local/opt/llvm/bin" true
  add_to_path "/opt/homebrew/bin" true
  add_to_path "/opt/homebrew/opt/llvm/bin" true
  add_to_path "/opt/homebrew/var/nodebrew/current/bin" true
  
  # Homebrewがインストールされている場合
  if command -v brew &> /dev/null; then
    export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix zstd)/lib/
  fi
  
  # macOS用のコマンド補完
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

# 各種開発環境の設定
# Flutter
[[ -d ~/.flutter ]] && add_to_path "$HOME/.flutter/bin"
[[ -d ~/.pub-cache ]] && add_to_path "$HOME/.pub-cache/bin"

# Node.js (NVM)
if [[ -d ~/.nvm ]]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # NVMの読み込み
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # NVM補完の読み込み
fi

# Nodebrew
[[ -d ~/.nodebrew ]] && add_to_path "$HOME/.nodebrew/current/bin" true

# Go (Goenv)
if [[ -d "$HOME/.goenv" ]]; then
  export GOENV_ROOT="$HOME/.goenv"
  add_to_path "$GOENV_ROOT/bin" true
  eval "$(goenv init -)"
  export PATH="$GOROOT/bin:$PATH"
  export PATH="$PATH:$GOPATH/bin"
fi

# Terraform補完
if command -v terraform &> /dev/null; then
  complete -C "$(which terraform)" terraform
fi

# Ruby (rbenv)
if [[ -d ~/.rbenv ]]; then
  add_to_path "$HOME/.rbenv/bin" true
  eval "$(rbenv init -)"
fi

# ctags
[[ -d ~/ctags ]] && add_to_path "$HOME/ctags/bin"

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -f "$HOME/.sdkman/bin/sdkman-init.sh" && -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# ===== その他の設定 =====
# ファイル作成時のデフォルトパーミッション
umask 022

# ターミナルのタイトルを設定
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

# 補完の設定
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

# fzfが存在する場合は読み込む
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# ローカル設定があれば読み込む
[ -f ~/.bashrc.local ] && source ~/.bashrc.local

# ===== カスタム関数 =====
# 現在のGitリポジトリの状態を表示
git_status() {
  git status -s
}

# 簡易的なタイマー
timer() {
  local time=$1
  shift
  local message="$*"
  
  if [[ "$time" =~ ^[0-9]+$ ]]; then
    echo "タイマーを $time 秒に設定しました。"
    sleep "$time"
    echo -e "\a時間です！ $message"
    
    # macOSの場合は通知を表示
    if [[ "$(uname)" == "Darwin" ]] && command -v osascript &> /dev/null; then
      osascript -e "display notification \"$message\" with title \"タイマー終了\""
    fi
  else
    echo "使用法: timer [秒数] [メッセージ]"
  fi
}

# 天気を表示
weather() {
  local city="${1:-Tokyo}"
  curl -s "wttr.in/${city}?lang=ja&format=3"
}

# ディレクトリサイズを表示
dirsize() {
  du -sh "${1:-.}"/* | sort -hr
}

# IPアドレスを表示
myip() {
  # 内部IPアドレスの表示（OS別）
  if [[ "$(uname)" == "Darwin" ]]; then
    echo "内部IP: $(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}')"
  else
    echo "内部IP: $(hostname -I | awk '{print $1}')"
  fi
  
  # 外部IPアドレスの表示
  echo "外部IP: $(curl -s https://ipinfo.io/ip)"
}

# 簡易的なポモドーロタイマー
pomodoro() {
  local work_time=${1:-25}
  local break_time=${2:-5}
  
  echo "ポモドーロタイマーを開始します。"
  echo "作業時間: ${work_time}分, 休憩時間: ${break_time}分"
  
  timer $((work_time * 60)) "作業時間が終了しました。休憩しましょう！"
  timer $((break_time * 60)) "休憩時間が終了しました。作業を再開しましょう！"
}

# 簡易的なバックアップ
backup() {
  local src="$1"
  local dst="${2:-$HOME/backups}"
  local date=$(date +%Y%m%d-%H%M%S)
  
  if [ -z "$src" ]; then
    echo "使用法: backup [ソースパス] [バックアップ先(デフォルト:~/backups)]"
    return 1
  fi
  
  if [ ! -d "$dst" ]; then
    mkdir -p "$dst"
  fi
  
  local filename=$(basename "$src")
  local backup_file="${dst}/${filename}-${date}.tar.gz"
  
  tar -czf "$backup_file" "$src"
  echo "バックアップを作成しました: $backup_file"
}

# ===== 最後のメッセージ =====
echo "Bashの設定を読み込みました。便利なコマンド:"
echo "  ansi      - ANSIカラーコードを表示"
echo "  extract   - 圧縮ファイルを自動展開"
echo "  timer     - 簡易タイマー"
echo "  weather   - 天気を表示"
echo "  myip      - IPアドレスを表示"
echo "  pomodoro  - ポモドーロタイマー"
echo "  backup    - 簡易バックアップ"
