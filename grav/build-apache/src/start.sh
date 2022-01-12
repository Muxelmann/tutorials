#!/bin/bash
shopt -s dotglob nullglob

# Check if user directory exists and
# if it does reset if empty

if [ ! -d $USER_DIR ]; then
    echo "Error: no user directory found"

elif [ ! "$(ls -A $USER_DIR)" ]; then
    ./setup-user.sh

else

    echo "Grav is set up and running"

fi

# Evaluate CMD
eval $@