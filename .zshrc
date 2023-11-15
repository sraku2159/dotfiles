# Add RVM to PATH for scripting. Make sure this is the last PATH variable change

#export SDKROOT="$(xcrun --show-sdk-path)"
PROMPT="%F{green}%n@%m %1~ %# %f"

# alias
alias pub="cat ~/.ssh/id_rsa.pub"
alias ping="/sbin/ping"
alias gcc=clang

#utility
function command_not_found_handler(){
    echo -e     "\033[31m                          __                __ \n" \
                ".-.-.-. .---.-. .-----. |  |_. .-----. .--|  |\n" \
                "| | | | |  _  | |__ --| |   _| |  -__| |  _  |\n" \
                "|_____| |___._| |_____| |____| |_____| |_____|\n"
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
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export PATH="/usr/local/opt/llvm/bin:/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/var/nodebrew/current/bin:/opt/homebrew/opt/llvm/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# setting ruby
[[ -d ~/.rbenv  ]] && eval "$(~/.rbenv/bin/rbenv init - zsh)"
