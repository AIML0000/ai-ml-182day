# infra/foundation — Azure foundation on your personal account

The Day 1 foundation, for your **personal pay-as-you-go** subscription (you're
Owner, so no sandbox workarounds — Terraform creates the RG, uses RBAC on the
Key Vault, and assigns you the Secrets Officer role).

## Run

```bash
# 1. Log in once (persists) and export your subscription id
source ../../scripts/azure-login.sh

# 2. Apply
cd infra/foundation      # you're here
terraform init
terraform fmt
terraform validate
terraform plan           # expect ~5 to add (+ random_string)
terraform apply          # yes

# 3. Tear down when you're done for the session (real spend!)
terraform destroy        # yes
```

## Cost hygiene

- Idle cost is tiny (RG free, LRS storage a few paise/day, standard Key Vault
  effectively free for learning), but **destroy every session** — it's the
  cleanest guardrail and good SRE habit.
- Optional budget alert (off by default). Turn it on once:
  ```bash
  terraform apply \
    -var enable_budget=true \
    -var alert_email=you@example.com \
    -var budget_start_date=2026-09-01T00:00:00Z   # first of a month
  ```

## Optional: remote state

For a portfolio-grade setup you can add the azurerm backend from Day 2
(a `tfstate-rg` + storage container that outlives the foundation). Not required
for the early labs — local state is fine while you're the only user.

## Never commit

`*.tfstate*`, `terraform.tfvars`, `.env`, or any credential file.
