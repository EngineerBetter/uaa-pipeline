#!/bin/bash

set -eu

sed "s/@appname@/$UAA_APP_NAME/g; \
     s/@appdomain@/$CF_APP_DOMAIN/g; \
     s/@adminsecret@/$ADMIN_SECRET/g; \
     s/@userpassword@/$USER_PASSWORD/g" \
     uaa-pipeline-repo/assets/uaa_manifest.yml > uaa-manifest/manifest.yml
