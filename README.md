# UAA Pipeline

A Concourse pipeline for deploying a UAA as a CF app

## Setting the pipeline

You'll need to provide various variables to the pipeline:

1. Variables describing the environment you're pushing to
1. Variables bootstrapping your UAA with credentials
1. Credentials for storing Terraform state

Examples of the first two, targeting PCF Dev, are in `ci/vars/pcfdev.yml`.

Populate a secrets file called `secrets.yml` with the following details to allow the pipeline to persist Terraform state to S3:

```yaml
concourse_ci_s3_access_key: %ACCESS_KEY%
concourse_ci_s3_secret_key: %SECRET_KEY%
tf_bucket_name: a_cool_name
```

Then, assuming you are logged in to a Concourse with the target name `lite`, set the pipeline with:

```txt
fly --target lite set-pipeline \
  --pipeline uaa \
  --config ci/pipeline.yml \
  --load-vars-from ci/vars/pcfdev.yml
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

### Additional admin client

The pipeline will also use `uaac` to create another admin client so that the root one need not be exposed. This client will use the name and secret defined in `bootstrap_admin_name` and `bootstrap_admin_secret` in the pipeline secrets.

On each run of the pipeline this client will be created if it doesn't exist or will be updated if it does.

To check that the client has been created you can use `uaac`:

```sh
uaac target https://$uaa_app_name.$cf_app_domain
uaac token client get admin -s $admin_secret
uaac clients
```

You should see an output containing an entry resembling:

```sh
$bootstrap_admin_name
    scope: uaa.none
    resource_ids: none
    authorized_grant_types: client_credentials
    autoapprove:
    authorities: uaa.admin
    name: $bootstrap_admin_name
    lastmodified: 1510592446000
```

You can also retrieve the token of the client with:

```sh
uaac token client get $bootstrap_admin_name -s $bootstrap_admin_secret
uaac token decode
```
