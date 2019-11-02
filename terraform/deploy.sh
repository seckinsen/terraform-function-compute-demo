#!/bin/bash

terraform init
terraform apply -var-file="secrets.tfvars"
