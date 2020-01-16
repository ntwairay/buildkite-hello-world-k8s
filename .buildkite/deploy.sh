#!/bin/bash

set -e

cd $PWD/deploy

if [ ${BUILDKITE_BRANCH} == "master" ]
then
  TAG=latest
  ENV=prod
else
  TAG=${BUILDKITE_COMMIT::8}
  ENV=dev
fi

echo "GCP Configuration"
gcloud config set project ${GCP_PROJECT}
gcloud container clusters get-credentials ${GKE_CLUSTER} --region australia-southeast1-b

echo "Helm deploy"
RAILS_ENV=${ENV} helmfile sync

echo "Kustomize deploy"
/kustomize build ./environments/${ENV}/ | kubectl apply -f -

echo "Provision properties for configmap"
cat ../config/kustomization.tpl | sed "s/\$env/$ENV/" > ../config/kustomization.yaml | /kustomize build ../config/ | kubectl apply -f -

echo "Clean up"
rm -rf ./tmp/${BUILDKITE_PIPELINE_SLUG}
