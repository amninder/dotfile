source ~/.bash_profile

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

complete -C /usr/local/bin/terraform terraform

# added by travis gem
[ ! -s /Users/anarota/.travis/travis.sh ] || source /Users/anarota/.travis/travis.sh

complete -C /usr/local/bin/vault vault

complete -C /usr/local/Cellar/tfenv/2.0.0/versions/0.13.3/terraform terraform
