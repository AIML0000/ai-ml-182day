# ---------------------------------------------------------------------------
# Cost guardrail — a monthly budget on the resource group with email alerts.
# Off by default so a first apply never breaks. Turn it on with:
#   terraform apply -var enable_budget=true \
#     -var alert_email=you@example.com \
#     -var budget_start_date=2026-09-01T00:00:00Z
# Note: start_date must be the FIRST day of the current or a future month.
# ---------------------------------------------------------------------------
resource "azurerm_consumption_budget_resource_group" "ml" {
  count             = var.enable_budget ? 1 : 0
  name              = "${var.prefix}-monthly-budget"
  resource_group_id = azurerm_resource_group.ml.id

  amount     = var.budget_amount
  time_grain = "Monthly"

  time_period {
    start_date = var.budget_start_date
  }

  # Alert at 80% of actual spend.
  notification {
    enabled        = true
    threshold      = 80
    operator       = "GreaterThanOrEqualTo"
    threshold_type = "Actual"
    contact_emails = [var.alert_email]
  }

  # Alert when forecast to hit 100%.
  notification {
    enabled        = true
    threshold      = 100
    operator       = "GreaterThanOrEqualTo"
    threshold_type = "Forecasted"
    contact_emails = [var.alert_email]
  }
}
