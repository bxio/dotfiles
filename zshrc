HISTFILE="~/.zsh_history"
# Set pure theme
ZSH_THEME=""
autoload -U promptinit; promptinit
prompt pure
# set aliases
source ~/.aliases

# fuzzy matching
CASE_SENSITIVE="false"

# enable zsh syntax highlighting and autosuggestions
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
# add zsh funtions path
fpath=(/usr/local/Homebrew/completions/zsh/ $fpath)
fpath=(/usr/local/share/zsh-completions $fpath)
# Add homebrew python to the path
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"

# define plugins
plugins=(git colored-man colorize pip python brew osx zsh-autosuggestions zsh-syntax-highlighting history-substring-search)
