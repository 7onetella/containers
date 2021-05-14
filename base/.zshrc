# .zshrc

export GOPATH=~/go
export GOROOT=/usr/local/go
export PATH=$PATH:.:/usr/local/go/bin:~/bin:$GOPATH/bin
export NOMAD_ADDR=http://nomad.7onetella.net:4646

fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure