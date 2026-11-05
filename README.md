# L00205444 Terraform Sentinel Assignment

**Taniya Offergeld, L00205444** 

## What this repo does
Terraform makes a plan. Sentinel checks the plan and passes or fails it. In HCP Terraform a failed hard-mandatory policy stops the run before anything is built. I do plan (only) and never apply.

## Structure
- `sentinel/`: policies, `sentinel.hcl` and test cases
- `terraform/`: code, `.terraform.lock.hcl` and saved plans (`tfplan`)
- `tests/`: mock data per policy
- `documentation/`: evidence 

| Policy | File | What it checks | Enforcement |
|---|---|---|---|
| Sovereignty (approved regions) | `sentinel/sovereignty.sentinel` | The `region` variable in the plan is `eu-west-1` or `eu-central-1` | hard-mandatory (blocks the run) |
| Instance type | `sentinel/instance_type.sentinel` | Instance type is t2.micro, t2.small or t2.medium, and a `Name` tag exists | advisory |
| Allowed providers (supply chain) | `sentinel/allowed_providers.sentinel` (needs `sentinel/common-functions/tfconfig-functions.sentinel`) | Every provider in the configuration is `aws` | advisory |


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

  **Allowed providers policy (supply chain)**

HashiCorp's `allowed-providers` policy, with the allowed list reduced to
`["aws"]` because my code only uses AWS. It checks the configuration, not
the plan.

- **CLI:** pass and fail both work. The pass mock is from an HCP run.
  The fail mock is HashiCorp's own, with `google`, `random` and others.
- **HCP Free:** the policy errors with
  `Import "tfconfig-functions" is not available`. It needs a helper file,
  and the HCP form takes only one file. Evidence:
  `documentation/evidence/hcp-allowed-providers-error.png`.
- **Limit:** it checks the provider name (`aws`), not the full address
  (`hashicorp/aws`). I did not test what happens with another publisher's
  provider of the same name.
- **Warning:** Sentinel shows a deprecation warning for the `module` block.
  HashiCorp's own tests use it too.


## Decision justification

- **Policy as code works for sovereignty:** the region rule is written once, checked on every plan and kept in Git. It blocked a US region before anything was built. It enforces my region list, not sovereignty itself.
- **Region limits:** a region shows where data sits, not who runs the platform. My policy also reads the `region` variable, so a region hard-coded in provider block would be missed.
- **Supply chain:** the provider runs with my AWS credentials, so a changed provider could bypass every policy. The pinned version and lock file make Terraform install the same provider each run. When I changed the version in HCP, the old lock file stopped the run (`documentation/evidence/hcp-lockfile-mismatch.png`). The `allowed_providers` policy rejects any provider except `aws`, but it only worked on the CLI, not in HCP Free. Sentinel cannot see inside a provider.
- **Sentinel limits:** Sentinel only checks the plan that Terraform produces. It has no way of seeing what happens in AWS outside Terraform. Advisory failures do not block a run.
- **Maintenance:** regions and policies in HCP can drift from GitHub. On the Free plan HCP can’t read GitHub by itself, so it doesn’t update automatically.

## AI use declaration

**My work:**
- Worked through HashiCorp's beginner Terraform tutorial (the HashiCups coffee example) and set up the HCP Terraform Free account and organization
- Built and ran everything myself: every command, and every step in HCP Terraform, AWS and GitHub
- Chose the policies, the regions and the enforcement levels, and decided what to leave out
- Took and checked all the evidence, found and fixed the problems that came up (paths, expired credentials, the lock file mismatch, the fork configuration)
- Wrote the README in my own words and managed the Git branches, pull requests and merges

**AI assistance:** Claude (Anthropic), Claude Sonnet 5.5 (`claude-sonnet-5-5`) for feedback on design choices and README. Additionally, Claude helped me to understand the assigment step by step 

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
- `sentinel/sovereignty.sentinel` and the test cases are my own work with AI assisted feedback

