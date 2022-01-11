#!/bin/zsh
print -P "%F{green}Building Pandocer%f"
tar -czf src.tgz --exclude=".DS_Store" src
docker build -t pandocer .
rm src.tgz