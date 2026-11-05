# L00205444 Terraform Sentinel Assignment

**Taniya Offergeld, L00205444** 

## What this repo does
Terraform makes a plan. Sentinel checks the plan and passes or fails it. In HCP Terraform a failed hard-mandatory policy stops the run before anything is built. I do plan (only) and never apply.

## Structure
- `sentinel/`: policies, `sentinel.hcl` and test cases
- `terraform/`: code, `.terraform.lock.hcl` and saved plans (`tfplan`)
- `tests/`: mock data per policy
- `documentation/`: evidence 

| Policy | File | What it checks | Enforcement | Status |
|---|---|---|---|---|
| Sovereignty (approved regions) | `sentinel/sovereignty.sentinel` | The `region` variable in the plan is `eu-west-1` or `eu-central-1` | hard-mandatory (blocks the run) 
| Instance type | `sentinel/instance_type.sentinel` | Instance type is t2.micro, t2.small or t2.medium, and a `Name` tag exists | advisory (warns only) 


Run the tests from `sentinel/` with `sentinel test -verbose`. Evidence is in `documentation/evidence/`.

The brief quotes: "Digital Security & Resilience will be a key priority for
Ireland during the upcoming presidency of the EU council". The Dáil answer
(Question 74, 13 May 2026) describes digital sovereignty as the ability of
Ireland and the European Union to act autonomously. My policies follow
that idea.


## Design Choices and Limitations

**Region policy (`sovereignty`, hard-mandatory)**
- Only Ireland (`eu-west-1`) and Frankfurt (`eu-central-1`) are allowed.
  Both are inside the EU, so deployments stay in EU jurisdiction.
- Two regions also help resilience: if one is unavailable, the other is
  still inside the EU.
- London (`eu-west-2`) and Zurich (`eu-central-2`) are excluded. Both are
  in Europe but not in the EU.


**Instance type policy (`instance_type`, advisory)**
- Allowed types are t2.micro, t2.small and t2.medium.
- Main focus is on cost control
  It shows that policy as code can enforce a different kind of rule next to
  the region rule
- It is advisory only. The Free plan of HCP Terraform let me save one
  mandatory policy, so I used it for the region policy. On a paid plan I
  would make this one soft mandatory.
- The policy is HashiCorp's `restrict-aws-instances-type-and-tag` example
  (MPL-2.0), copied with a credit header.


## Decision justification

- **Policy as code works for sovereignty:** the region rule is written once, checked on every plan and kept in Git. It blocked a US region before anything was built. It enforces my region list, not sovereignty itself.
- **Region limits:** a region shows where data sits, not who runs the platform. My policy also reads the `region` variable, so a region hard-coded in AWS would be missed.
- **Supply chain:** The provider runs with my AWS credentials, so a changed provider could bypass every policy. The pinned version and lock file make Terraform install the same provider each run. Sentinel cannot see inside a provider, and I did not write a policy for provider source yet
- **Sentinel limits:** Sentinel only checks the plan that Terraform produces. It has no way of seeing what happens in AWS outside Terraform.
- **Maintenance:** regions and policies in HCP can drift from GitHub. On the Free plan HCP can’t read GitHub by itself, so it doesn’t update automatically.

## AI use declaration

## Credits and sources

**Code**
- Terraform code is based on HashiCorp's `learn-terraform-sentinel`
  (MPL-2.0, Copyright (c) 2020 HashiCorp, Inc.). Licence copy:
  `terraform/LICENSE-HashiCorp-learn-terraform-sentinel`.
- `sentinel/instance_type.sentinel` is HashiCorp's
  `restrict-aws-instances-type-and-tag.sentinel` from
  `learn-sentinel-write-policy` (MPL-2.0, Copyright (c) 2021 HashiCorp,
  Inc.), copied unmodified apart from a credit header. Licence copy:
  `sentinel/LICENSE-HashiCorp-learn-sentinel-write-policy`.
- `sentinel/sovereignty.sentinel` and the test cases are my own work.

**Sources**
- Dáil Éireann, Question 74, 13 May 2026: definition of digital
  sovereignty and the Digital Security & Resilience priority. (add link)
- Declaration for European Digital Sovereignty, signed by Ireland on
  18 November 2025 in Berlin. (add link)
- HashiCorp Sentinel and HCP Terraform documentation. (add links to the
  pages you actually used)