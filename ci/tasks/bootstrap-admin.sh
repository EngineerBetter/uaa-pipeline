#!/bin/sh

set -eu

if [ "${SKIP_CERT_CHECK}" = "true" ]; then
  uaac target "https://${APP_NAME}.${CF_APP_DOMAIN}" --skip-ssl-validation
else
  uaac target "https://${APP_NAME}.${CF_APP_DOMAIN}"
fi

uaac token client get admin -s ${ADMIN_SECRET}

set +e
uaac client get "$BOOTSTRAP_ADMIN_NAME"
client_exists=$?
set -e

if [ $client_exists -eq 0 ]; then
  set +e
  output=$(uaac client update "$BOOTSTRAP_ADMIN_NAME" \
    --name "$BOOTSTRAP_ADMIN_NAME" \
    --scope uaa.none \
    --authorized_grant_types client_credentials \
    --authorities uaa.admin)
  result=$?
  echo "$output" | grep -q "Nothing to update"
  no_update=$?
  set -e
  if [ $result -ne 0 ] && [ $no_update -ne 0 ]; then
    echo "client update failed" && exit 1
  fi
else
  uaac client add "$BOOTSTRAP_ADMIN_NAME" \
    --name "$BOOTSTRAP_ADMIN_NAME" \
    --scope uaa.none \
    --authorized_grant_types client_credentials \
    --authorities uaa.admin \
    --secret "$BOOTSTRAP_ADMIN_SECRET"
fi
