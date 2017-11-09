# UAA Pipeline

A Concourse pipeline for deploying a UAA as a CF app

## Setting the pipeline

Populate a secrets file called `secrets.yml` an example for pcfdev is below:

```yaml
cf_api: https://api.local.pcfdev.io
cf_app_domain: local.pcfdev.io
cf_org: pcfdev-org
cf_space: pcfdev-space
cf_password: admin
cf_username: admin
cf_service_name: p-mysql
cf_service_plan: 512mb

concourse_ci_s3_access_key: %ACCESS_KEY%
concourse_ci_s3_secret_key: %SECRET_KEY%

tf_bucket_name: a_cool_name

uaa_app_name: myuaa

random_route: false

skip_cert_check: true
```

Then, assuming you are logged in to a Concourse with the target name `lite`, set the pipeline with:

```txt
fly --target lite set-pipeline \
  --pipeline uaa \
  --config ci/pipeline.yml \
  --load-vars-from secrets.yml
```

## Accessing your UAA

Vist `https://${uaa_app_name}.${cf_app_domain}` and login.
