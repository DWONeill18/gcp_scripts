#!/bin/bash

project_id=ujnewfiew


#setup gcloud
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-253.0.0-linux-x86.tar.gz
tar zxvf google-cloud-sdk-253.0.0-linux-x86.tar.gz google-cloud-sdk
gcloud init

#y
#2

gcloud auth login
gcloud config set project $project_id
gcloud compute project-info add-metadata --meta google-compute-default-region==europe-west1, google-compute-default-zone=europe-west1-b

#add these alias' to .bashrc file
#GCLOUD_CONFIG=$(gcloud config list --format json)
#GCLOUD_PROJECT=$(echo -n ${GCLOUD_CONFIG} | jq -r '.core.project')
#GCLOUD_REGION=$(echo -n ${GCLOUD_CONFIG} | jq -r '.compute.region')
#GCLOUD_ZONE=$(echo -n ${GCLOUD_CONFIG} | jq -r '.compute.zone')

#firewalll rules

gcloud compute firewall -rules create MY-RULE --allow tcp:8080 --proritory 1000 --source-ranges 0.0.0.0/0 --target-tags node
gcloud compute firewall -rules create MY-RULE --allow tcp:4200 --proritory 1001 --source-ranges 0.0.0.0/0 --target-tags angular
gcloud compute firewall -rules create MY-RULE --allow tcp:27017 --proritory 1002 --source-ranges 0.0.0.0/0 --target-tags mongodb


#create vm
gcloud compute instances create test --image-family ubuntu-1404-lts --image-project ubuntu-os-cloud --tags node angular mongodb
gcloud compute ssh test


#install backend
./mean_script


#install frontend

./mean_script





