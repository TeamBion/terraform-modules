resource "aws_cloudwatch_log_group" "vpn" {
  count = var.logging_enabled ? 1 :0
  name              = "/aws/vpn/${var.name}/logs"
  retention_in_days = var.logs_retention

  tags = merge(
    var.tags,
    map(
      "Name", "${var.name}-Client-VPN-Log-Group",
      "EnvName", var.name
    )
  )
}

resource "aws_cloudwatch_log_stream" "vpn" {
  count = var.logging_enabled ? 1 :0
  name           = var.log_group_name
  log_group_name = aws_cloudwatch_log_group.vpn.*.name
}