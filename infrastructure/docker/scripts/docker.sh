# Export cloud computer shell environment
eval "$(yarn --cwd ../cloud-computer environment)"

# Always connect to localhost via the unix socket
if [ "$DOCKER_HOST" = "localhost" ]; then

  DOCKER_HOST=unix:///var/run/docker.sock
  DOCKER_TLS_VERIFY=

elif [ -z "$DOCKER_HOST" ]; then

  # Use tls when connecting to a remote host
  DOCKER_HOST=docker.$CLOUD_COMPUTER_HOST_DNS
  DOCKER_TLS_VERIFY=1

fi

docker \
  --host $DOCKER_HOST \
  --tlsverify $DOCKER_TLS_VERIFY \
  "$@"