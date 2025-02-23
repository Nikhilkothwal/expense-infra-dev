resource "aws_ssm_parameter" "listener_app_alb_arn" {
    name = "/${var.project_name}/${var.environment}/listener_app_alb"
    type = "String"
    value = aws_lb_listener.http.arn
}