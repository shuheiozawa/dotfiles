export LANG=ja_JP.UTF-8
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case'
export PATH=$PATH:$HOME/.rbenv/bin
export PATH=$PATH:~/Downloads/nand2tetris/tools
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:~/google-cloud-sdk/bin
export PATH=$PATH:~/CAWORK/01_work/cycloud_Darwin_x86_64/
export LESSCHARSET=utf-8
export LESS='--no-init --shift 4 --LONG-PROMPT --RAW-CONTROL-CHARS --quit-if-one-screen'
export PATH=$HOME/.nodebrew/current/bin:$PATH

eval "$(rbenv init -)"
eval "$(direnv hook zsh)"

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
HIST_STAMPS="mm/dd/yyyy"

autoload -Uz vcs_info
autoload -U compinit && compinit
autoload -U colors;colors

PROMPT='[%*][%F{magenta}%n%f@%F{green}%U%m%u%f:%F{blue}%B%d%f%b]'
PROMPT2="%{${fg[yellow]}%} %_ > %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r ? [n,y,a,e] %{${reset_color}%}"

# ls
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'

# 補完候補もLS_COLORSに合わせて色が付くようにする
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# 大文字と小文字を同一視して補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# フルパスの時でも今のディレクトリを外す場合の設定
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:processes' command 'ps x -o pid,args'

# alias
alias d='cd'
alias ..='cd ..'

alias ls='ls -F -G'
alias la='ls -a'
alias ll='ls -l'
alias ks='ls'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias sudo='sudo '
alias -g L='| less'
alias -g G='| grep'
alias q='exit'
alias ipv4='ifconfig eth0 | egrep -o "([0-9]{1,3}\.){3}[0-9]{1,3}" | sed -n 1p'
alias ipv6='ifconfig eth0 | egrep -o "([[:xdigit:]]{0,4}[:]){7}[[:xdigit:]]{0,4}" | sed -n 1p'
alias mac='ifconfig eth0 | egrep -o "([[:xdigit:]]{2}[:]){5}[[:xdigit:]]{2}"'
alias nocaps='setxkbmap -option ctrl:nocaps'
alias trl='tr "A-Z" "a-z"'
alias tru='tr "a-z" "A-Z"'
alias socat='(){socat TCP-LISTEN:$1,,reuseaddr,fork EXEC:$2&}'
alias irb='irb --simple-prompt'
alias k='kubectl'

# function
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


#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
#export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then source '$HOME/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then source '$HOME/google-cloud-sdk/completion.zsh.inc'; fi

source ~/.bash_profile
