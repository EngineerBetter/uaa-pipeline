# UAA Pipeline

A Concourse pipeline for deploying a UAA as a CF app

## Setting the pipeline

Populate a secrets file called `secrets.yml` using the following template:

```yaml
cf_api: https://api.local.pcfdev.io
cf_app_domain: local.pcfdev.io
cf_org: pcfdev-org
cf_space: pcfdev-space
cf_username: admin
cf_password: admin

concourse_ci_s3_access_key: %ACCESS_KEY%
concourse_ci_s3_secret_key: %SECRET_KEY%

tf_bucket_name: a_cool_name

uaa_app_name: myuaa
```

Then, assuming you are logged in to a Concourse with the target name `lite`, set the pipeline with:

```txt
fly --target lite set-pipeline \
  --pipeline uaa \
  --config ci/pipeline.yml \
  --load-vars-from secrets/secrets.yml
```

## Accessing your UAA

Vist `https://${uaa_app_name}.${cf_app_domain}` and login.
