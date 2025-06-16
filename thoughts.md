#### Thoughts and assumptions

- Testing was limited (only s3) due to costs
- Working example w/ tfvars can be found in /example dir
- IAM policy for s3 and dynamoDB could be scoped tighter
- Using cloud init as a standardized means to install binaries
- Installing AWS CLI to be able to interact with s3 or dynamo
- Github actions creates releases for module  based on Conventional Commits
- Could have used IAM auth for RDS access.
- Plz ignore any direct commits to main :). In production env there would be branch protection to prevent applying to directly to main.
