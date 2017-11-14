#!/bin/sh

set -eu

if [ "${SKIP_CERT_CHECK}" = "true" ]; then
  uaac target "https://${UAA_APP_NAME}.${CF_APP_DOMAIN}" --skip-ssl-validation
else
  uaac target "https://${UAA_APP_NAME}.${CF_APP_DOMAIN}"
fi

echo "Check that admin client exists"
uaac token client get admin -s ${ADMIN_SECRET}

echo "Check that default account doesn't exist"
set +e
uaac token owner get cf marissa -s "" -p koala
result=$?
set -e
if [ $result -eq 0 ]; then
  echo "default user should not exist" && exit 1
fi

echo "Check that the bootstrapped user exists..."
uaac user get user -a username

echo "... and can obtain a token..."
uaac token owner get cf user -s "" -p ${USER_PASSWORD}

echo "... and that the token is valid"
uaac token decode
