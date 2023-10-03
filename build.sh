latest_version=$(curl -s  https://api.github.com/repos/tailscale/tailscale/releases/latest | jq -r .tag_name)
echo "the latest version of tailscale is $latest_version"

dockerhub_tags=$(curl -s https://registry.hub.docker.com/v2/repositories/wondersoap/tailscale-with-derp/tags)
if [[ "$dockerhub_tags" == *"$latest_version"* ]]; then
    echo "version $latest_version already built and pushed to docker hub. finish"
    exit
fi

# build and push docker image
echo $DOCKER_HUB_TOKEN | docker login -u wondersoap --password-stdin
docker build . --build-arg LATEST_VERSION=$latest_version -t wondersoap/tailscale-with-derp:$latest_version -t wondersoap/tailscale-with-derp:latest
docker push wondersoap/tailscale-with-derp:$latest_version
docker push wondersoap/tailscale-with-derp:latest
