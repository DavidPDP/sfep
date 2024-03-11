/*data "github_release" "iot_enrollment_asset" {
  repository  = "iot-device-enrollment-function"
  owner       = "safe-fleet"
  retrieve_by = "tag"
  release_tag = "2.0.0-release-next.1"
}

data "http" "iot_enrollment_asset_download" {
  url = data.github_release.iot_enrollment_asset.zipball_url
}

resource "null_resource" "iot_enrollment_asset_local" {
  triggers = {
    version = "2.0.0-release-next.12"
  }

  provisioner "local-exec" {
    command = <<EOF
    curl -L \\
    -H "Accept:application/vnd.github.v3.raw" \\
    -H "Authorization: Bearer <TOKEN>" \\
    -H "X-GitHub-Api-Version: 2022-11-28" \\
    -o ${path.module}/iot_enrollment_asset.zip \\
    https://api.github.com/repos/safe-fleet/iot-device-enrollment-function/zipball/2.0.0-release-next.1
    EOF
  }
}

/*resource "local_file" "iot_enrollment_asset_local" {
  content  = data.http.iot_enrollment_asset_download.response_body
  filename = "${path.module}/iot_enrollment_asset.zip"
}*/