# L00205444 Terraform Sentinel Assignment

## What this does
Terraform makes a plan. Sentinel checks the plan before anything is built, and passes or fails it. I only plan and never apply, so nothing is created in AWS.

## Digital sovereignty
The brief quotes: "Digital Security & Resilience will be a key priority for Ireland during the upcoming presidency of the EU council". The Dáil answer (Question 74, 13 May 2026) describes digital sovereignty as the ability of Ireland and the European Union to act autonomously. My policies follow that idea: 

## Policies and why
- sovereignty (hard-mandatory): only Ireland (eu-west-1) and Germany (Frankfurt, eu-central-1). Both are in the EU. I chose two regions mainly for resilience, backup and redundancy: if one region or country is disrupted, a second EU region can take over or hold backups, and data still stays under EU law. London and Zurich are excluded because they are not in the EU. The policy only restricts where resources may be created.
- instance_type (advisory): only t2.micro, t2.small and t2.medium. A cost control, not a sovereignty measure. 
- allowed_providers (advisory): only the aws provider (supply chain) due to plaform familiarty.

## Why AWS only
- We used AWS the most in the course, so it is the platform I know best. I also have my own AWS account. One provider kept the project small enough to test properly.
- AWS has regions in the EU (Ireland and Frankfurt), so a region list can express "EU only". The Dáil answer supports access to trusted non-EU providers, so an AWS setup inside EU regions is consistent with it.
- For compliance and regulation, I used the region as the control: it decides which country's infrastructure is used. I did not assess AWS's compliance certifications or its legal position, so I make no claim about them.
- Limit: AWS is a US company, so one provider also means dependence on it. A region policy does not remove that, which is why digital sovereignty needs more than this framework.

## Why I decided this way
- Only the sovereignty policy blocks a run. The HCP Free form let me save one mandatory policy (observed, not documented).
- Two EU regions, Ireland and Germany: resilience, backup and redundancy inside the EU. The trade-off is that data may leave Ireland, but it stays under EU law.
- I used HashiCorp's own code for the other two policies, because it is trusted and tested, and fits supply chain security.
- The provider is pinned (~> 6.0) and the lock file is committed, so the same provider is installed every run.
- I did not write IMDSv2, EBS encryption or SSH policies: I found no official HashiCorp Sentinel policy for them, and wanted to use only official code.

## How it was tested (pass and fail)
Run from the sentinel folder: `sentinel test -verbose`

| Policy | CLI | HCP Terraform |
|---|---|---|
| sovereignty | evidence-sovereignty-pass.png, evidence-sovereignty-fail.png, evidence-sovereignty-sentinel-test.png | hcp-sovereignty-pass.png, hcp-sovereignty-fail.png (US region blocked) |
| instance_type | evidence-instance-pass.png, evidence-instance-fail.png | hcp-instance-type-pass.png, hcp-instance-type-fail.png (t2.large warned) |
| allowed_providers | evidence-allowed-providers-pass.png, evidence-allowed-providers-fail.png | hcp-allowed-providers-error.png (HCP Free cannot load the helper file) |

Also: hcp-lockfile-mismatch.png (the lock file stopped a provider change). All files are in documentation/evidence/. Saved plans: terraform/tfplan (compliant) and terraform/tfplan-noncompliant. Mocks are real downloads from HCP runs.

## Limits
- A region check shows where data sits, not who runs the platform. A region hard-coded in the provider block would be missed.
- Sentinel only sees the plan, not changes made in AWS afterwards.
- Advisory policies warn but do not block. More in the technical report.

## AI use
Tool: Claude (Anthropic), Claude Sonnet 5.5 (claude-sonnet-5-5)
Prompts and reviews focused around the two links about Irish policymaking and code reviews
- I am an Irish policymaker deciding how the State should approach digital sovereignty when choosing a cloud provider and a backup strategy. Ireland is a trusted EU partner and supports access to trusted non-EU providers. My main priorities are protecting Irish data and resilience. The data includes <personal / sensitive / critical-service data: specify>. My current setup, if any, is <e.g. AWS Ireland region>.
Please act as an independent adviser on cloud policy, writing for a senior decision-maker who is not a technical specialist, and tell me what I should consider when choosing (1) a cloud provider and (2) a backup and resilience design, so that Irish data is protected and services can keep running if one provider, region or country is disrupted.
- Give me realistic  scenario in which Europe is cut off from non-EU countries and say what would still need to work in Ireland. What would it mean for Irish infrastructure from big to small scale.
- What pros and cons do my own decisions have done in my assigments
- Where do sovereignty and reslience contradict each other in the current Eurpean political climate and what are trends observed across Europe in the last 3 years? To avoid single point of failure but still remain data sovereignty as a core policy? What impact would that have on classifying data and who can do that?
- I am using https://github.com/hashicorp-education/learn-terraform-sentinel and https://github.com/hashicorp-education/learn-sentinel-write-policy as my main code, explain the code to my step by step and it has been written in that way, show strenghts and weaknesses of the code and wether it is solid for my assigment. If needed adjust it to my requirements and explain why. Do not change, propose only.


