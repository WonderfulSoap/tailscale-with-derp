apt update
apt install jq -y
latest_version=$(curl -s  https://api.github.com/repos/tailscale/tailscale/releases/latest | jq -r .tag_name)
echo "the latest version of tailscale is $latest_version"
docker build . --build-arg LATEST_VERSION=$latest_version -t wondersoap/tailscale-with-derp:$latest_version -t wondersoap/tailscale-with-derp:latest
echo $DOCKER_HUB_TOKEN | docker login -u wondersoap --password-stdin
docker push wondersoap/tailscale-with-derp:$latest_version
docker push wondersoap/tailscale-with-derp:latest