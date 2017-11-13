#!/bin/sh

set -eux

if [ "${SKIP_CERT_CHECK}" = "true" ]; then
  uaac target "https://${APP_NAME}.${CF_APP_DOMAIN}" --skip-ssl-validation
else
  uaac target "https://${APP_NAME}.${CF_APP_DOMAIN}"
fi

uaac client get "$BOOTSTRAP_ADMIN_NAME" || \
uaac client add "$BOOTSTRAP_ADMIN_NAME" \
--name "$BOOTSTRAP_ADMIN_NAME" \
--scope uaa.none \
--authorized_grant_types client_credentials \
--authorities uaa.admin \
--secret "$BOOTSTRAP_ADMIN_SECRET"
