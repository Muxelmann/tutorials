#!/bin/zsh
print -P "%F{green}Starting Pandocer%f"
docker run --name pandocer -it -v ${PWD}/data:/data pandocer