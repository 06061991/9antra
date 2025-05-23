#!/bin/sh

# Check if GATEWAY_API_URL is set
if [ -z "$GATEWAY_API_URL" ]; then
  echo "Error: GATEWAY_API_URL is not set!"
  exit 1
fi

# Replace API placeholder in nginx.conf
sed -i "s|__API_GATEWAY_URL__|$GATEWAY_API_URL|g" /etc/nginx/nginx.conf

# Inject API URL into a JavaScript file that Angular will read
cat <<EOF > /usr/share/nginx/html/assets/runtime-env.js
window.env = {
   GATEWAY_API_URL: "http://$GATEWAY_API_URL"
};
EOF

# Start Nginx
exec nginx -g "daemon off;"
