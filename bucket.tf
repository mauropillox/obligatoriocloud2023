resource "aws_s3_bucket" "obligatorio_bucket1" {
  bucket = "obligatorio1"

  tags = {
    Name      = "obligatorio-bucket1"
    terraform = "True"
  }
}

# resource "aws_iam_policy" "s3_bucket_policy" {
#   name   = "S3BucketPolicy"
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": [
#         "s3:PutObject",
#         "s3:GetObject",
#         "s3:DeleteObject"
#       ],
#       "Resource": [
#         "arn:aws:s3:::obligatorio1/*"
#       ]
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role_policy_attachment" "bucket_policy_attachment" {
#   role       = "LabRole"
#   policy_arn = aws_iam_policy.s3_bucket_policy.arn
# }
