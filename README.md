# AI/ML Engineer — 182-Day Track

Learning + project workspace for a Senior AI/ML Engineer (Azure) transition,
built on an SRE foundation. ~26 weeks at ~1.5–2 hrs/day.

All Azure labs run on your **personal pay-as-you-go account** (destroy every
session). Portfolio repo: https://github.com/AIML0000

## Structure

```
ai-ml-182day-track/
├── roadmap/    The full 182-day plan (open first; tracks progress in-browser)
│   └── ai-ml-engineer-182-day-roadmap.html
├── lessons/    Daily lesson files (light theme, five tabs, print-friendly)
│   ├── day-01-alignment-and-foundation.html
│   └── day-02-ml-lifecycle-and-portfolio.html
├── infra/
│   └── foundation/   Personal-account Terraform (RG + Storage + RBAC Key Vault + optional budget)
└── scripts/
    └── azure-login.sh   Logs into your personal account + exports TF vars (source it)
```

## The 11 phases

| # | Phase | Days |
|---|-------|------|
| P0 | Alignment & Foundation | 1–2 |
| P1 | Python for ML | 3–22 |
| P2 | Math & Stats for ML | 23–36 |
| P3 | Data Engineering & Pipelines | 37–50 |
| P4 | Core Machine Learning | 51–80 |
| P5 | Deep Learning | 81–102 |
| P6 | MLOps & Productionization | 103–120 |
| P7 | Azure ML + Databricks + MLflow | 121–140 |
| P8 | Generative AI & LLMs | 141–162 |
| P9 | Agentic AI | 163–174 |
| P10 | Capstone & Interview Prep | 175–182 |

10 portfolio projects land on days 22, 36, 50, 80, 102, 120, 140, 162, 174, 182.

## Progress

| Item | Status |
|------|--------|
| Roadmap (11 phases, 182 days) | delivered |
| Day 01 — Alignment & Foundation | delivered |
| Day 02 — ML Lifecycle & Portfolio Workflow | delivered |
| Day 03 — Python: data structures | not started |

## How to run the Azure labs (personal account)

```bash
source scripts/azure-login.sh        # az login (once) + export TF_VAR_subscription_id
cd infra/foundation
terraform init && terraform apply    # ~5 resources
# ... do the lab ...
terraform destroy                    # tear down — real spend
```

## Notes

- All files use a light, print-friendly theme.
- Copy buttons work over `file://` (legacy fallback included).
- Never commit: `*.tfstate*`, `terraform.tfvars`, `.env`, or any credential file.
- Optional cost guardrail (monthly budget alert) is in `infra/foundation/budget.tf`.
