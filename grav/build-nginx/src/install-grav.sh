#!/bin/bash
shopt -s dotglob nullglob

echo "Instaling Grav version $GRAV_VERSION"

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

echo "Copying new HTML files"
cp -RT $GRAV_ROOT/ $HTML_DIR/

echo "Amending privileges"
chown $NGINX_RUN_USER:$NGINX_RUN_GROUP -R $HTML_DIR

rm -rf $GRAV_ROOT*