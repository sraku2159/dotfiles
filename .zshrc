# git
autoload -Uz compinit && compinit
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '[%b]'

function left-prompt {
  name_t='064m%}'      # user name text clolr
  name_b='000m%}'    # user name background color
  path_t='166m%}'
  path_b='000m%}'
  branch_t='075m%}'     # path text clolr
  branch_b='000m%}'   # path background color
  arrow='087m%}'   # arrow color
  text_color='%{\e[38;5;'    # set text color
  back_color='%{\e[30;48;5;' # set background color
  reset='%{\e[0m%}'   # reset

  #user="${back_color}${name_b}${text_color}${name_t}"
  #path="${back_color}${path_b}${text_color}${path_t}"
  #branch="${back_color}${branch_b}${text_color}${branch_t}%%\$vcs_info_msg_0_${reset}"
  user="${text_color}${name_t}"
  path="${text_color}${path_t}"
  branch="${text_color}${branch_t}%%\$vcs_info_msg_0_${reset}"

  echo -e "${user}%n%#@%m:${reset}${path} %~${reset}${branch}\n${text_color}${arrow}>${reset} "
}

PROMPT=`left-prompt`

# alias
alias pub="cat ~/.ssh/id_rsa.pub"
alias ping="/sbin/ping"
alias dp='docker compose'
alias now="date '+%Y%m%d%H%M%S'"
alias tf='terraform'

#utility
function command_not_found_handler(){
    echo -e     "\033[31m                          __                __ \n" \
                ".-.-.-. .---.-. .-----. |  |_. .-----. .--|  |\n" \
                "| | | | |  _  | |__ --| |   _| |  -__| |  _  |\n" \
                "|_____| |___._| |_____| |____| |_____| |_____|\n"
}

function docker-build-with-log() {
  docker build --progress=plain $@ &> build.log
}

ansi () {
	echo "echo -e \"following sentence\" or printf 'following sentence'"
        echo 'Example: \\(e or 033)[XXm string \\(e or 33)[0m'
        for ((i = 1; i <= 7; i++)) do
                printf '\e[%dm%d\e[m ' $i $i
        done
        echo
        echo 'Example: \\(e or 033)[XXm string \\(e or 33)[0m'
        for ((i = 30; i <= 37; i++)) do
                printf '\e[%dm%d\e[m ' $i $i
        done
        for ((i = 40; i <= 47; i++)) do
                printf '\e[%dm%d\e[m ' $i $i
        done
        echo
        echo 'Example: \\(e or 033)[38;5;XXm string \\(e or 33)[0m'
        for ((i = 0; i < 16; i++)) do
                for ((j = 0; j < 16; j++)) do
                        hex=$(($i*16 + $j)) 
                        printf '\e[38;5;%dm%03d\e[m ' $hex $hex
                done
                echo ""
        done
}

function base64url() {
    echo -n $1 | base64 | tr "+/" "-_" | tr -d "="
}


#export

# 1: path
# 2: true if prepend
function add_to_path() {
  [[ $PATH == *":$1:"* ]] && return

  if [[ $2 ]]; then
    export PATH="$1:$PATH"
  else
    export PATH="$PATH:$1"
  fi
}

if [[ "$(uname)" == "Darwin" ]]; then
  # export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
  export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
  add_to_path "/usr/local/opt/llvm/bin" true
  add_to_path "/opt/homebrew/bin" true
  add_to_path "/opt/homebrew/opt/llvm/bin" true
  add_to_path "/opt/homebrew/var/nodebrew/current/bin" true
fi

[[ -d ~/.flutter ]] && add_to_path "$HOME/.flutter/bin"
[[ -d ~/.pub-cache ]] && add_to_path "$HOME/.pub-cache/biin"
[[ -d ~/.nvm ]] && export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias bi='bundle config set --local path .bundle && bundle install'
export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix zstd)/lib/


if [[ -d "$HOME/.goenv" ]]; then
  export GOENV_ROOT="$HOME/.goenv"
  export PATH="$GOENV_ROOT/bin:$PATH"
  eval "$(goenv init -)"
  export PATH="$GOROOT/bin:$PATH"
  export PATH="$PATH:$GOPATH/bin"
fi

add_to_path $HOME/.nodebrew/current/bin true

# setting terraform
autoload -U +X bashcompinit && bashcompinit
source $HOME/.tenv.completion.zsh
# complete -o nospace -C /opt/homebrew/bin/terraform terraform

# sdkman
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -f "$HOME/.sdkman/bin/sdkman-init.sh" && -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# setting ruby
# 最後に追加する

[[ -d ~/.rbenv && "$PATH" = *"/usr/bin"*"$HOME/.rbenv/shims"* ]] && export PATH=$( echo $PATH | sed "s/${HOME//\//\\/}\/.rbenv\/shims://g" )
[[ -d ~/.rbenv && "$PATH" != *":$HOME/.rbenv/shims:"* ]] && eval "$(rbenv init - zsh)"
add_to_path "$HOME/ctags/bin"
