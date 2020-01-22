path_remove() {
    PATH=$(echo -n $PATH | awk -v RS=: -v ORS=: '$0 != "'$1'"' |sed 's/:$//')
}

path_append() {
    path_remove "$1"
    PATH="${PATH:+"$PATH:"}$1"
}

path_prepend() {
    path_remove "$1"
    PATH="$1${PATH:+":$PATH"}"
}

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
    local tags=`curl -s https://registry.hub.docker.com/v1/repositories/${image}/tags | jq -r '.[].name'`
    
    if [ -n "$2" ]; then
      tags=`echo -n "$tags" | grep -E "$2"`
    fi

    echo "$tags"
  fi
}

dptags () {
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
    local tags=`curl -s https://registry.hub.docker.com/v2/repositories/${image}/tags | jq -r '["tags","size"],["====","===="],(.results[] | [.name,(.images[].size/1024/1024)]) | @tsv' | awk 'BEGIN{ FS=OFS="\t" }NR>2{ $2=sprintf("%.2f",$2) }1'`
    
    if [ -n "$2" ]; then
      tags=`echo -n "$tags" | grep -E "$2"`
    fi

    echo "$tags"
  fi
}
