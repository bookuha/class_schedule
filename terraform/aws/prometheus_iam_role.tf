resource "aws_iam_role" "prometheus_role" {
  name = "prometheus_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "prometheus_policy" {
  name        = "PrometheusEC2Read"
  description = "Allow Prometheus to read EC2 instances for service discovery"
  
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = [
          "ec2:DescribeInstances",
          "ec2:DescribeTags"
        ]
        Resource  = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_prometheus_policy" {
  policy_arn = aws_iam_policy.prometheus_policy.arn
  role       = aws_iam_role.prometheus_role.name
}

resource "aws_iam_instance_profile" "prometheus_instance_profile" {
  name = "prometheus_instance_profile"
  role = aws_iam_role.prometheus_role.name
}
