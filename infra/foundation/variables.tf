variable "subscription_id" {
  type        = string
  description = "Your personal Azure subscription id (azure-login.sh exports it as TF_VAR_subscription_id)"
}

variable "location" {
  type        = string
  default     = "centralindia"
  description = "Azure region — Central India keeps latency low from Hyderabad"
}

variable "prefix" {
  type        = string
  default     = "mllab"
  description = "Short prefix for created resource names"
}

# ---------------------------------------------------------------------------
# Optional cost guardrail (off by default). Enable on the command line, e.g.:
#   terraform apply \
#     -var enable_budget=true \
#     -var alert_email=you@example.com \
#     -var budget_start_date=2026-09-01T00:00:00Z
# ---------------------------------------------------------------------------
variable "enable_budget" {
  type        = bool
  default     = false
  description = "Create a monthly budget alert on the resource group"
}

variable "budget_amount" {
  type        = number
  default     = 10
  description = "Monthly budget in your billing currency"
}

variable "budget_start_date" {
  type        = string
  default     = ""
  description = "First day of the current or a future month, e.g. 2026-09-01T00:00:00Z (required when enable_budget = true)"
}

variable "alert_email" {
  type        = string
  default     = ""
  description = "Email address for budget alerts (required when enable_budget = true)"
}
