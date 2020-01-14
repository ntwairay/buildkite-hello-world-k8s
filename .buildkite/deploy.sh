#!/bin/bash

# setup helm
echo "Installing helm"
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash

echo "Installing helmfile"
HELMFILE_VERSION=v0.46.2
curl -sfL -o /usr/local/bin/helmfile https://github.com/roboll/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_linux_amd64
chmod a+x /usr/local/bin/helmfile

echo "Installing kubectl"
KUBECTL_VERSION=1.13.3
curl -sfL -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl

echo "Installing gcloud"
# Add the Cloud SDK distribution URI as a package source
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
# Update the package list and install the Cloud SDK
sudo apt-get update && sudo apt-get install google-cloud-sdk

echo "--- Configuring Helm cli :rocket:"
export HELM_HOME="${PWD}/.buildkite/.helm"
helm init -c
helm repo add charts https://my_charts.com/charts
helm repo update

if [ ${BUILDKITE_BRANCH} ="master" ]
then
  TAG=latest
else
  TAG=${BUILDKITE_COMMIT::8}
fi

# # app name
# APP=some_app
#
# # deploy/upgrade app with helm
# echo "--- Deploying $APP :rocket:"
# helm upgrade --install ${APP} charts/my_app --namespace ${SOME_NAMESPACE} --reuse-values \
#   --set image.tag="${GIT_TAG}"
