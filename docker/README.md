Release

* make sure you are logged into the artifacts server using docker
  ```
  docker login docker.unidata.ucar.edu -u <nexus-username>
  ```
* make sure you are logged into the GitHub Container Registry (using a classic personal access token [following these instructions](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-to-the-container-registry))
  ```
  docker login ghcr.io -u <github-username>
  ```
* bump theme/plugin versions in the Gemfile contained in this directory
* run `build.sh` to create a local multi-platform image
* tag the latest image with the release version for docker.unidata.ucar.edu and ghcr:
  ```
  docker image tag unidata-jekyll-docs:latest docker.unidata.ucar.edu/unidata-jekyll-docs:0.0.5
  docker image tag unidata-jekyll-docs:latest ghcr.io/unidata/unidata-jekyll-docs:0.0.5
  ```
* push the new images
  ```
  docker image push docker.unidata.ucar.edu/unidata-jekyll-docs:0.0.5
  docker image push ghcr.io/unidata/unidata-jekyll-docs:0.0.5
  ```
