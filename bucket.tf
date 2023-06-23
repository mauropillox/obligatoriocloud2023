# Recurso para el bucket de S3
resource "aws_s3_bucket" "obligatorio_bucket1" {
  bucket = "obligatorio"

  tags = {
    Name      = "obligatorio-bucket1"
    terraform = "True"
  }
}

# Recurso para la política de bucket de S3
resource "aws_s3_bucket_policy" "obligatorio_bucket_policy" {
  bucket = aws_s3_bucket.obligatorio_bucket.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::${aws_s3_bucket.obligatorio_bucket.id}/*"
      ]
    }
  ]
}
EOF
}
