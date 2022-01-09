resource "aws_apigatewayv2_api" "demo_api" {
  name          = "demo_api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "demo_api" {
  api_id = aws_apigatewayv2_api.demo_api.id

  name        = "demo_api"
  auto_deploy = true
}

# ~~ API Service: Main

resource "aws_apigatewayv2_integration" "api_service_main" {
  api_id = aws_apigatewayv2_api.demo_api.id

  integration_uri    = aws_lambda_function.api_service_main.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "api_service_main" {
  api_id    = aws_apigatewayv2_api.demo_api.id
  route_key = "$default"
  target    = "integrations/${aws_apigatewayv2_integration.api_service_main.id}"
}

resource "aws_lambda_permission" "api_gw_service_main" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api_service_main.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.demo_api.execution_arn}/*/*"
}

# ~~ API Service: Videos

resource "aws_apigatewayv2_integration" "api_service_videos" {
  api_id = aws_apigatewayv2_api.demo_api.id

  integration_uri    = aws_lambda_function.api_service_videos.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "api_service_videos" {
  api_id    = aws_apigatewayv2_api.demo_api.id
  route_key = "ANY /videos"
  target    = "integrations/${aws_apigatewayv2_integration.api_service_videos.id}"
}

resource "aws_lambda_permission" "api_gw_service_videos" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api_service_videos.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.demo_api.execution_arn}/*/*"
}
