CONTAINER_NAME=$1
echo "Removing container: $CONTAINER_NAME"
exec > /dev/null 2>&1
docker stop $CONTAINER_NAME || true && docker rm $CONTAINER_NAME || true
