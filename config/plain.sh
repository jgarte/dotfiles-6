UTILS_DIR="$HOME/code/edh/plain-utils/bin"
if [ -d "$UTILS_DIR" ]; then
  export PATH="$UTILS_DIR:$PATH"
fi

SERVICES_DIR="$HOME/code/edh/plain-services-docker/bin"
if [ -d "$SERVICES_DIR" ]; then
  export PATH="$SERVICES_DIR:$PATH"
fi
