resource "aws_iam_role" "codeartifact_role" {
  name = "CodeArtifactRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "codeartifact_policy" {
  name        = "CodeArtifactAccessPolicy"
  description = "Policy to allow EC2 to fetch artifacts from AWS CodeArtifact"
  policy      = jsonencode(
{
   "Version": "2012-10-17",
   "Statement": [
      {
         "Action": [
            "codeartifact:Describe*",
            "codeartifact:Get*",
            "codeartifact:List*",
            "codeartifact:ReadFromRepository"
         ],
         "Effect": "Allow",
         "Resource": "*"
      },
      {
         "Effect": "Allow",
         "Action": "sts:GetServiceBearerToken",
         "Resource": "*",
         "Condition": {
            "StringEquals": {
               "sts:AWSServiceName": "codeartifact.amazonaws.com"
            }
         }
      }  
   ]
})
}

resource "aws_iam_role_policy_attachment" "attach_codeartifact_policy" {
  role       = aws_iam_role.codeartifact_role.name
  policy_arn = aws_iam_policy.codeartifact_policy.arn
}