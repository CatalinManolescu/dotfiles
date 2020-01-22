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

dtags_help() {
  echo " 
    List tags for a docker image available on Docker hub 
    
    dtags <image> [<filter-key>[+<filter-key>[..]]] 
    
    Eg.
    - list all tags for nodejs
      /> dtags node
    
    - list all tags for nodejs that contain the key 'alpine' and 'lts'
      /> dtags node alpine+lts
  "
}

dtags_filter() {
  local filter=""

  OIFS=$IFS
  IFS='+'
  
  for filter_value in $1
  do
    if [ -n "$filter" ]; then
    filter=$filter" and "
    fi
    filter=$filter"contains(\"${filter_value}\")"
  done

  if [ -n "$filter" ]; then
    filter=" | select(.name | $filter )"
  fi

  IFS=$OIFS
  echo "$filter"
}

dtags() {
  if [ $# -lt 1 ]; then
    dtags_help
  else
    local image="$1"
    local filter=`dtags_filter $2`
    
    curl -s https://registry.hub.docker.com/v1/repositories/${image}/tags | jq -r ".[]${filter}.name"
  fi
}

dptags () {
  if [ $# -lt 1 ]; then
    dtags_help
  else
    local image="$1"
    local filter=`dtags_filter $2`

    curl -s https://registry.hub.docker.com/v2/repositories/${image}/tags | jq -r "[\"tags\",\"size\"],[\"====\",\"====\"],(.results[]${filter} | [.name,(.images[].size/1024/1024)]) | @tsv" | awk 'BEGIN{ FS=OFS="\t" }NR>2{ $2=sprintf("%.2f",$2) }1'
  fi
}
