# VIMCONTROL
bindkey -v
export EDITOR='vim'

HIST_IGNORE_SPACE=true

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"
plugins=(
  brew brew-cask dirhistory torrent git git-remote-branch 
  battery colored-man colorize
)
# cd ~/.oh-my-zsh && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/oh-my-zsh.sh

setopt CORRECT
COMPLETION_WAITING_DOTS=true
DISABLE_UPDATE_PROMPT=true

# sets the title
case $TERM in
  xterm*)
  precmd () {print -Pn "\e]0;%n@%m: %~\a"}
  ;;
esac

# Loads J
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# changes pwd of $HOME to ~
function collapse_pwd {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

# sets prompt character
function prompt_char {
  git branch >/dev/null 2>/dev/null && echo '±' && return
  hg root >/dev/null 2>/dev/null && echo '☿' && return
  echo '>'
}

# echoes hostname
function virtualenv_info {
  [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

# constructs the prompt
ZSH_THEME_GIT_PROMPT_PREFIX="on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""
function prompt_user { echo "%{$fg[magenta]%}%n%{$reset_color%}" }
function prompt_machine { echo "%{$fg[yellow]%}%m%{$reset_color%}" }
function prompt_dir { echo "%{$fg_bold[green]%}$(collapse_pwd)%{$reset_color%}" }

PROMPT='
$(prompt_user) at $(prompt_machine) in $(prompt_dir) $(git_prompt_info)
$(virtualenv_info)$(prompt_char) '

RPROMPT='$(battery_pct_remaining 2>/dev/null)'

function passgen
{
  if hash xclip 2>/dev/null; then
    head -c $1 /dev/urandom | base64 - | xclip -i;
  elif hash pbcopy 2>/dev/null; then
    head -c $1 /dev/urandom | base64 - | pbcopy;
  elif hash gpm 2>/dev/null; then
    head -c $1 /dev/urandom | base64 - | gpm;
  fi
}

alias reload='source ~/.zshrc'
alias gap='git add --patch'
alias ios='open /Applications/Xcode.app/Contents/Developer/Applications/iOS\ Simulator.app'
alias i='npm install';
alias t='npm test';
alias s='npm start';
alias tw='npm run testwatch';
alias gco='git checkout';
alias gcob='git checkout -b';
alias emptytrash='sudo rm -Rf ~/.Trash/*';
alias shrug='echo "¯\_(ツ)_/¯"';
alias p='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend';
