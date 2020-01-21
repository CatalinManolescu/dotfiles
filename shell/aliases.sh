# Use colors in coreutils utilities output
alias ls='ls --color=auto'
alias grep='grep --color'

# ls aliases
alias ll='ls -lah'

# Aliases to protect against overwriting
alias cp='cp -i'
alias mv='mv -i'

# Mirror a website
alias mirrorsite='wget -m -k -K -E -e robots=off'

dtags () {
 
  if [ $# -lt 1 ]; then
    echo " 
    List tags for a docker image available on Docker hub 
    
    dtags <image> \"[<filter-key>[|<filter-key>[..]]]\" 
    
    Eg.
    - list all tags for nodejs
      /> dtags node
    
    - list all tags for nodejs that contain the key 'alpine' or 'slim'
      /> dtags node \"alpine|slim\""
  else
    local image="$1"
    local tags=`curl -s https://registry.hub.docker.com/v1/repositories/${image}/tags | jq -r ".[]".name`
    
    if [ -n "$2" ]; then
      tags=`echo -n "$tags" | grep -E "$2"`
    fi

    echo "$tags"
  fi
}

