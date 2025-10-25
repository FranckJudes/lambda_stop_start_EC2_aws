resource "aws_cloudwatch_event_rule" "stop_schedule" {
    name = "schedule-stop-instance"
    description = "Schedule to stop the instance every day at 20:00"
    schedule_expression = "cron(0 20 ? * MON-FRI *)" # Every day at 20:00 from Monday to Friday
}