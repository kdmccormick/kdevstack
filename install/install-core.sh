#/bin/sh
# Run this from the root of the directory in which
# you want to install modstack

DEFAULT_ROOT=https://raw.githubusercontent.com/kdmccormick/modstack/master
ROOT=${MODSTACK_URL:-$DEFAULT_ROOT}

curl $ROOT/.env > .env
echo >> .env
echo "# Overrides from .override.env are below this comment"
echo >> .env
cat .override.env >> .env || true

curl $ROOT/service-bases.yml > service-bases.yml
curl $ROOT/docker-compose.core.yml > docker-compose.yml
