locals {
  project_root       = "${var.terragrunt_dir}/../../.."
  index              = "index.html"
  error              = "error.html"
  avatar             = "avatar.jpg"
  html_content_type  = "text/html"
  image_content_type = "image/jpeg"
}

resource "aws_s3_bucket" "homepage" {
  bucket = var.homepage_url
  acl    = "public-read"

  website {
    index_document = local.index
    error_document = local.error
  }
}

resource "aws_s3_bucket_policy" "homepage" {
  bucket = aws_s3_bucket.homepage.id

  policy = data.aws_iam_policy_document.homepage.json
}

data "aws_iam_policy_document" "homepage" {
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.homepage.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.homepage.id
  key    = local.index

  source       = "${local.project_root}/${local.index}"
  content_type = local.html_content_type
  etag         = filemd5("${local.project_root}/${local.index}")
}

resource "aws_s3_bucket_object" "error" {
  bucket = aws_s3_bucket.homepage.id
  key    = local.error

  source       = "${local.project_root}/${local.error}"
  content_type = local.html_content_type
  etag         = filemd5("${local.project_root}/${local.error}")
}

resource "aws_s3_bucket_object" "avatar" {
  bucket = aws_s3_bucket.homepage.id
  key    = "images/${local.avatar}"

  source       = "${local.project_root}/${local.avatar}"
  content_type = local.image_content_type
  etag         = filemd5("${local.project_root}/${local.avatar}")
}
