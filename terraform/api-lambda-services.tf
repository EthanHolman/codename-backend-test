resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "api_service_videos" {
  function_name = "ApiService-Videos"

  runtime = "nodejs14.x"
  handler = "lambda.handler"

  filename         = "${path.module}/../bin/api-videos.zip"
  source_code_hash = filebase64sha256("${path.module}/../bin/api-videos.zip")

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_lambda_function" "api_service_main" {
  function_name = "ApiService-Main"

  runtime = "nodejs14.x"
  handler = "lambda.handler"

  filename         = "${path.module}/../bin/api.zip"
  source_code_hash = filebase64sha256("${path.module}/../bin/api.zip")

  role = aws_iam_role.lambda_exec.arn
}

