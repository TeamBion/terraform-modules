resource "aws_ec2_client_vpn_endpoint" "default" {
    description            = "${var.name}-Client-VPN"
    server_certificate_arn = aws_acm_certificate.server.arn
    client_cidr_block      = var.cidr
    split_tunnel           = true

    authentication_options {
        type                       = "certificate-authentication"
        root_certificate_chain_arn = aws_acm_certificate.root.arn
    }

    connection_log_options {
        enabled               = var.logging_enabled
        cloudwatch_log_group  = var.logging_enabled ? tostring(aws_cloudwatch_log_group.vpn.*.name) : ""
        cloudwatch_log_stream = var.logging_enabled ? tostring(aws_cloudwatch_log_stream.vpn.*.name) : ""
    }

    tags = merge(
        var.tags,
        map(
        "Name", "${var.name}-Client-VPN"
        )
    )
}

resource "aws_ec2_client_vpn_network_association" "default" {
    count                  = length(var.subnet_ids)
    client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default.id
    subnet_id              = element(var.subnet_ids, count.index)
}

resource "aws_ec2_client_vpn_authorization_rule" "default" {
    for_each = toset(var.target_network_cidrs)
    client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.default.id
    target_network_cidr    = each.key
    authorize_all_groups   = true
}