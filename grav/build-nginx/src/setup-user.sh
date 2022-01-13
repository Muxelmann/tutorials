#!/bin/bash
shopt -s dotglob nullglob

echo "Resetting / Setting up user files for version $GRAV_VERSION"

# Delete user directory if not empty
if [ -d $USER_DIR -a "$(ls $USER_DIR)" ]; then
    echo "Clearing user files"
    rm -rf $USER_DIR/*
fi

if [ ! $GRAV_VERSION -o $GRAV_VERSION = "latest" ]; then
    GRAV_VERSION=$(curl --silent "https://api.github.com/repos/getgrav/grav/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
fi

if [ $GRAV_ADMIN = "YES" ]; then
    GRAV_ROOT="grav-admin"
else
    GRAV_ROOT="grav"
fi

wget -q https://github.com/getgrav/grav/releases/download/$GRAV_VERSION/$GRAV_ROOT-v$GRAV_VERSION.zip -O $GRAV_ROOT.zip

echo "Extracting Grav archive"
unzip -q $GRAV_ROOT.zip

echo "Copying default user files"
mv $GRAV_ROOT/user/* $USER_DIR

echo "Amending privileges"
chown www-data:www-data -R $USER_DIR

rm -rf $GRAV_ROOT*
