# UAA Pipeline

A Concourse pipeline for deploying a UAA as a CF app

## Setting the pipeline

Populate a secrets file called `secrets.yml` an example for pcfdev is below:

*NOTE*: the `uaa_app_name` must provide a unique route for the app

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

skip_cert_check: true

# UAA credentials
# Clients
admin_secret: 3c151ec1128567f9870eaa7a1360194c
# Users
user_password: 6abbc3a8595f878065e879e5c80d6144
```

Then, assuming you are logged in to a Concourse with the target name `lite`, set the pipeline with:

```txt
fly --target lite set-pipeline \
  --pipeline uaa \
  --config ci/pipeline.yml \
  --load-vars-from secrets.yml
```

## Accessing your UAA

Vist `https://${uaa_app_name}.${cf_app_domain}` and login using `user/$user_password`.

## Bootstrapped Clients & Users

The pipeline will bootstrap two clients and one user using credentials passed in your secrets file.

To test you will need the [uaac CLI tool](https://github.com/cloudfoundry/cf-uaac)

```sh
# Target the UAA
uaac target https://$uaa_app_name.$cf_app_domain

# Get token of admin client
uaac token client get admin -s $admin_secret
uaac token decode

# Get token of bootstrapped user
uaac token owner get cf user -s "" -p $user_password
uaac token decode
```
