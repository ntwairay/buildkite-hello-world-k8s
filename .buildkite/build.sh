#!/bin/bash

set -e

echo ${BUILDKITE_BRANCH}

if [ ${BUILDKITE_BRANCH} == "master" ]
then
  TAG=latest
else
  TAG=${BUILDKITE_COMMIT::8}
fi

mkdir ./tmp

#  clone repo
git clone ${BUILDKITE_REPO} ./tmp/${BUILDKITE_PIPELINE_SLUG}

# cd to pulled repo folder
cd ./tmp/${BUILDKITE_PIPELINE_SLUG}

# build docker image
echo -e "\n--- Building :docker: image ${IMAGE}:${TAG}"
docker build -t ${IMAGE}:${TAG} .

# cleaning up repo folder
echo "--- Cleaning up git repo folder ${BUILDKITE_PIPELINE_SLUG}"
rm -rf /tmp/${BUILDKITE_PIPELINE_SLUG}

# tag docker image
docker tag ${IMAGE}:${TAG} ${DOCKER_REPO}/${IMAGE}:${TAG}

# push to repository
echo "--- Pushing :docker: image ${DOCKER_REPO}/${IMAGE}:${TAG} to registry"
docker push ${DOCKER_REPO}/${IMAGE}:${TAG}

# local clean up
echo "--- Cleaning up :docker: image ${DOCKER_REPO}/${IMAGE}:${TAG}"
docker rmi -f $(docker images -a -q)
