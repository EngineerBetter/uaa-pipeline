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
client_already_exists=$?
set -e

VERB="add"

if [ $client_already_exists -eq 0 ]; then
  VERB="update"
fi

uaac client "$VERB" "$BOOTSTRAP_ADMIN_NAME" \
--name "$BOOTSTRAP_ADMIN_NAME" \
--scope uaa.none \
--authorized_grant_types client_credentials \
--authorities uaa.admin \
--secret "$BOOTSTRAP_ADMIN_SECRET"
