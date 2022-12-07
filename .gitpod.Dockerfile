FROM gitpod/workspace-full

USER gitpod

# Install custom tools, runtime, etc. using apt-get
# For example, the command below would install "bastet" - a command line tetris clone:
#
# RUN sudo apt-get -q update && \
#     sudo apt-get install -yq bastet && \
#     sudo rm -rf /var/lib/apt/lists/*
#
# More information: https://www.gitpod.io/docs/config-docker/

RUN sudo apt update -q && \
    sudo DEBIAN_FRONTEND=noninteractive && \
    sudo apt install keyboard-configuration && \
    sudo apt install -y elixir && \
    sudo apt install -y erlang
    # mix deps.get && \
    # mix local.hex
