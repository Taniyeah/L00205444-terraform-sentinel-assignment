# L00205444 Terraform Sentinel Assignment

**Taniya Offergeld, L00205444** 

## What this repo does
Terraform makes a plan. Sentinel checks the plan and passes or fails it. In HCP Terraform a failed hard-mandatory policy stops the run before anything is built. I do plan (only) and never apply.

## Structure
- `sentinel/`: policies, `sentinel.hcl` and test cases
- `terraform/`: code, `.terraform.lock.hcl` and saved plans (`tfplan`)
- `tests/`: mock data per policy
- `documentation/`: evidence 

## Policies
| Policy | Status |
|---|---|
| Sovereignty (approved regions) | Done |


Run the tests from `sentinel/` with `sentinel test -verbose`. Evidence is in `documentation/evidence/`.

## Design decisions
- **Regions:** Ireland (`eu-west-1`) and Frankfurt (`eu-central-1`), for resilience and trusted EU partners. London and Zurich are excluded because they are not in the EU.
- **HCP Free plan:** policies are pasted into HCP by hand
- **Provider:** AWS provider pinned to `~> 6.0`, with the lock file committed.


## Decision justification

- **Policy as code works for sovereignty:** it checks every plan against my region list (Ireland and Frankfurt) and blocked the US region before anything was built.
- **Region limits:** a region shows where data sits, not who runs the platform.
- **Supply chain:** the lock file stops a provider changing after I chose it. Sentinel cannot check what is inside a provider.- **Sentinel limits:** Sentinel only checks the plan that Terraform produces. It has no way of seeing what happens in AWS outside Terraform.
- **Maintenance:** regions and and policies in HCP can drift from GitHub. On the Free plan HCP can’t read GitHub by itself, so it doesn’t update automatically.

## AI use declaration
*To be written by me: tool name, version and prompts.*

## Credits
Terraform code is based on HashiCorp's `learn-terraform-sentinel` (MPL-2.0, Copyright (c) 2020 HashiCorp, Inc.). Sources are listed in the report.