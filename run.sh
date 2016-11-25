#!/bin/sh
cat >$(ls -1 /web.war/config*.js) <<EOF
// Use this file as a template when the app needs to be pointed to
// a different server, for example when dockerizing the app
window.SHELVES_API_SERVER="${API_SERVER}";
window.SHELVES_API_BASE="${API_BASE}";
window.SHELVES_API_NAMESPACE="${API_NAMESPACE}";
EOF
sed -i -e 's#src="\(/config-[a-f0-9]*.js\)" integrity="[^"]*"#src="\1"#' /web.war/index.html
echo "Configuration done, starting server."
exec nginx -g "daemon off;" "$@"

