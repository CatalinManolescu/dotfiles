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

random_char() {
  chars='@#$%&_+=!'
  echo -n ${chars:$((RANDOM % ${#chars})):1}
}

random_numbers() {
  echo -n $(< /dev/urandom LC_ALL=C tr -dc 0-9 | head -c${1:-1})
}

random_password() {
  # echo "$((${1:-3}-2))"
  echo -n $(LC_ALL=C tr -dc "[:upper:][:lower:]" < /dev/urandom | head -c $((${1:-3}-2)) | (echo -n "$(random_char)$(random_numbers 1)" && cat -) | fold -w1 | shuf | tr -d '\n')
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

dtags () {
  if [ $# -lt 1 ]; then
    dtags_help
  else
    local image="$1"
    local filter=`dtags_filter $2`

    curl -s https://registry.hub.docker.com/v2/repositories/${image}/tags | jq -r "[\"tags\",\"size\"],[\"====\",\"====\"],(.results[]${filter} | [.name,(.images[].size/1024/1024)]) | @tsv" | awk 'BEGIN{ FS=OFS="\t" }NR>2{ $2=sprintf("%.2f",$2) }1'
  fi
}

dns_to_ip() {
  for domain in "$@"; do
    for ip in `nslookup $domain | tail -n +3 | sed -n 's/Address:\s*//p'`;do
      echo -n "$ip "
    done
  done
}

azure_config_dir() {
  if [ -z "$1" ]; then
    echo $AZURE_CONFIG_DIR
  elif [ "$1" = "default" ]; then
    export AZURE_CONFIG_DIR=`realpath ~/.azure`
  else 
   export AZURE_CONFIG_DIR=$1
  fi
}

myip() {
  dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'"' '{ print $2}'
}
