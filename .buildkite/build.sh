#!/bin/bash
# image name
IMAGE=rayhub/hello-world

# use buildkite commit hash as a TAG

if [ ${BUILDKITE_BRANCH} ="master" ]
then
  TAG=latest
else
  TAG=${BUILDKITE_COMMIT::8}
fi

# make tmp folder
mkdir /tmp
cd /tmp
ls

#  clone repo
# env SSH_AUTH_SOCK= GIT_SSH_COMMAND='ssh -v -i /home/juelian_siow/.ssh/id_rsa' git clone SSH://${BUILDKITE_REPO}
git clone ${BUILDKITE_REPO}
git clone git@github.com:ScentreGroup/wrs_centre_service.git

# cd to pulled repo folder
cd /tmp/${BUILDKITE_PIPELINE_SLUG}

# checkout branch
git checkout ${BUILDKITE_BRANCH}

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
docker rmi -f ${DOCKER_REPO}/${IMAGE}:${TAG}

rm -rf /tmp/${BUILDKITE_PIPELINE_SLUG}
