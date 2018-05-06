#!/usr/bin/env bash
set -e

profile_uaa=""

if [ "x$UAA_URL" != "x" ]; then
	profile_uaa=",dev-uaa"
	cat <<EOF > src/main/resources/application-dev-uaa.yml
auth_server:
  url: ${UAA_URL}
  internal_url: ${UAA_INTERNAL_URL:-"~"}
security:
  oauth2:
    enabled: true
EOF

fi

exec ./gradlew --no-daemon bootRun \
 -Djava.security.egd=file:/dev/urandom \
 -Djdk.tls.ephemeralDHKeySize=3072 \
 -Djdk.tls.namedGroups='secp384r1' \
 -Djavax.net.ssl.trustStore=src/test/resources/auth_server_trust_store.jks \
 -Djavax.net.ssl.trustStorePassword=changeit \
 -Dspring.profiles.active=dev,dev-h2${profile_uaa} "$@"