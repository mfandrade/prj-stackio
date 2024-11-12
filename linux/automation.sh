#/usr/bin/env bash
#
# Script for provision of stackio setup as solution for the challenge.
#
# Requirements: git, bash, make, minikube, kubectl, terraform
#
PROJECT_ROOT=$(realpath "$(dirname $0)/../")

VER=$(date +'%s')
IMAGENAME=mfandrade/stackio-webserver:$VER

if [ ! -d $PROJECT_ROOT/dockerize ]; then
  echo "ERROR: The 'dockerize' folder does not exist in $PROJECT_ROOT" >/dev/stderr
  exit 1
fi

cd $PROJECT_ROOT/dockerize &&
  docker compose build && docker tag mfandrade/stackio-webserver:latest $IMAGENAME

cd $PROJECT_ROOT/linux &&
  sed -i.out "s,MY_NEW_IMAGE,$IMAGENAME," script.yaml && mv script.yaml.out new-app.yaml &&
  kubectl diff -f new-app.yaml
