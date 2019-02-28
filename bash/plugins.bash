# dircolors
if [[ $- == *i* ]]; then
    if [[ "$(tput colors)" == "256" ]]; then
        eval "$(dircolors ~/.shell/plugins/dircolors-solarized/dircolors.256dark)"
    fi
fi