provider "external" {}

provider "alicloud" {
  access_key = var.access_key
  secret_key = var.secret_key
  account_id = var.account_id
  region = var.region
}

data "external" "build" {
  program = [
    "./build.sh"
  ]
}

data "external" "archive" {
  program = [
    "./archive.sh",
    var.zip_file_name,
    "../src/"
  ]

  depends_on = [
    data.external.build
  ]
}

resource "alicloud_oss_bucket" "demo" {
  bucket = var.oss_bucket_name

  depends_on = [
    data.external.archive
  ]
}

resource "alicloud_oss_bucket_object" "demo" {
  bucket = alicloud_oss_bucket.demo.bucket
  key = "function/${timestamp()}/${var.zip_file_name}"
  source = var.zip_file_name
}

resource "alicloud_log_project" "demo" {
  name = "${var.service_name}-log-project"
}

resource "alicloud_log_store" "demo" {
  project = alicloud_log_project.demo.name
  name = "${var.service_name}-log-store"
}

resource "alicloud_ram_role" "demo" {
  name = "${var.service_name}-role"

  document = <<EOF
  {
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": [
            "log.aliyuncs.com",
            "fc.aliyuncs.com"
          ]
        }
      }
    ],
    "Version": "1"
  }
  EOF

  force = true
}

resource "alicloud_ram_role_policy_attachment" "demo_log_full_access" {
  role_name = alicloud_ram_role.demo.name
  policy_name = "AliyunLogFullAccess"
  policy_type = "System"
}

resource "alicloud_ram_role_policy_attachment" "demo_ecs_network_interface_management_access" {
  role_name = alicloud_ram_role.demo.name
  policy_name = "AliyunECSNetworkInterfaceManagementAccess"
  policy_type = "System"
}

resource "alicloud_fc_service" "demo" {
  name = var.service_name
  description = var.service_description
  log_config {
    project = alicloud_log_project.demo.name
    logstore = alicloud_log_store.demo.name
  }
  internet_access = var.service_internet_access
  role = alicloud_ram_role.demo.arn
  vpc_config {
    security_group_id = var.security_group_id
    vswitch_ids = [
      var.vswitch_id
    ]
  }
}

resource "alicloud_fc_function" "demo" {
  service = alicloud_fc_service.demo.name
  name = var.function_name
  description = var.function_description
  memory_size = var.function_memory_size
  runtime = var.function_runtime
  handler = var.function_handler
  oss_bucket = alicloud_oss_bucket.demo.bucket
  oss_key = alicloud_oss_bucket_object.demo.key
  timeout = var.function_default_timeout
  environment_variables = {
  }
}

resource "alicloud_fc_trigger" "demo" {
  service = alicloud_fc_service.demo.name
  function = alicloud_fc_function.demo.name
  name = var.function_http_trigger_name
  role = alicloud_ram_role.demo.arn
  type = "http"
  config = <<EOF
    {
        "authType": "anonymous",
        "methods" : ["GET"]
    }
  EOF
}
