# Docker containers for local lab environment
I have a local lab environment at home that I manage. There is a need to deploy my apps or 3rd party apps easily. Docker is a good choice for stateless apps. Each docker folder should have `README.md` explaining the purpose of each docker container. I expect viewers of this repo to use it as a reference to see how one can use docker to help in building local lab environment.

## What qualifies as a reasonable local lab environment
There are things that local lab environment needs to provide to be considered usuful. IMHO: consideration for these different areas to be given.

- code build
- code deploy
- manage configuration
- view logs
- monitor
- test release

## How are containers built?
Docker container can be built by executing build.sh. This can be done locally or within the `Builder` docker container.

## How are containers deployed?
Docker container can be deployed by executing deploy.sh. This can be done locally or within the `Builder` docker container.

## Tooling
I published a python CLI tool [vag](https://vag.readthedocs.io/en/latest/vag.html) to help me automate. 

## TODO
A diagram of my lab environment is coming soon. I have the following servers or tools in my lab.

- private docker registry
- UI for docker registry
- builder servers. Jenkins and `Builder`
- Log indexing and searching