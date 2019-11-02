# ----------------------------------------------------------------------------------------------------------------------
# CREDENTIALS VARIABLES
# ----------------------------------------------------------------------------------------------------------------------

variable "account_id" {}

variable "access_key" {}

variable "secret_key" {}

variable "region" {
  type = string
  description = "The region to launch resources."
  default = "eu-central-1"
}

# ----------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# ----------------------------------------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------------------------------------
# VPC VARIABLES
# ----------------------------------------------------------------------------------------------------------------------

variable "security_group_id" {
  type = string
  description = "A security group ID associated with the FC service."
  default = "YOUR_SECURITY_GROUP_ID"
}

variable "vswitch_id" {
  type = string
  description = "A list of vswitch IDs associated with the FC service."
  default = "YOUR_VSWITCH_ID"
}

# ----------------------------------------------------------------------------------------------------------------------
# STORAGE VARIABLES
# ----------------------------------------------------------------------------------------------------------------------

variable "zip_file_name" {
  type = string
  description = "function's implementation archived filename"
  default = "demo-functions.zip"
}

variable "oss_bucket_name" {
  type = string
  description = "The name of the bucket."
  default = "demo"
}

# ----------------------------------------------------------------------------------------------------------------------
# SERVICE VARIABLES
# ----------------------------------------------------------------------------------------------------------------------

variable "service_name" {
  type = string
  description = "The Function Compute service name. "
  default = "demo"
}

variable "service_description" {
  type = string
  description = "The function compute service description."
  default = "sample function FC service"
}

variable "service_internet_access" {
  type = bool
  description = "Whether to allow the service to access Internet. Default to true."
  default = false
}

# ----------------------------------------------------------------------------------------------------------------------
# FUNCTION VARIABLES
# ----------------------------------------------------------------------------------------------------------------------

variable "function_name" {
  type = string
  description = "The Function Compute function name."
  default = "demo"
}

variable "function_description" {
  type = string
  description = "The Function Compute function description."
  default = "sample demo function"
}

variable "function_memory_size" {
  type = string
  description = "Amount of memory in MB your Function can use at runtime. Defaults to 128. Limits to [128, 3072]."
  default = "128"
}

variable "function_runtime" {
  type = string
  description = "The Function Compute function runtime type."
  default = "nodejs8"
}

variable "function_handler" {
  type = string
  description = "The function entry point in your code."
  default = "handler.demo"
}

variable "function_default_timeout" {
  type = number
  description = "The amount of time your Function has to run in seconds."
  default = 15
}

# ----------------------------------------------------------------------------------------------------------------------
# TRIGGER VARIABLES
# ----------------------------------------------------------------------------------------------------------------------

variable "function_http_trigger_name" {
  type = string
  description = "The Function Compute trigger name."
  default = "demo-function-http-trigger"
}



