#!/bin/bash
gcloud compute instances create reddit-app-new \
--zone=us-west1-b \
--boot-disk-size=10GB \
--boot-disk-type=pd-ssd \
--machine-type=f1-micro \
--tags puma-server \
--image=reddit-full-1561658948 \
--restart-on-failure
