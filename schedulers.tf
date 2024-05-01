
resource "aws_scheduler_schedule_group" "oci_inspector" {
  name = "oci-inspector"
}

resource "aws_scheduler_schedule" "oci_inspector_helios" {

  name                = "schedule-oci-inspector-helios"
  description         = "The schedule for Oci Inspectore Helios"
  group_name          = aws_scheduler_schedule_group.oci_inspector.name
  schedule_expression = "rate(2 hours)"
  state               = "ENABELD"

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = module.oci_inspector_helios.lambda_function_arn
    role_arn = aws_iam_role.scheduler_oci_inspector.arn

    retry_policy {
      maximum_retry_attempts = 0
    }
  }
}

resource "aws_scheduler_schedule" "oci_inspector_poseidon" {

  name                = "schedule-oci-inspector-poseidon"
  description         = "The schedule for Oci Inspectore Poseidon"
  group_name          = aws_scheduler_schedule_group.oci_inspector.name
  schedule_expression = "rate(2 hours)"
  state               = "ENABELD"

  flexible_time_window {
    mode = "OFF"
  }

  target {
    arn      = module.oci_inspector_poseidon.lambda_function_arn
    role_arn = aws_iam_role.scheduler_oci_inspector.arn

    retry_policy {
      maximum_retry_attempts = 0
    }
  }
}
