#!/bin/bash

terraform init
terraform destroy -var-file="secrets.tfvars"
