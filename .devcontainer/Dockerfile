FROM amazon/aws-glue-libs:glue_libs_1.0.0_image_01

ARG USERNAME
ARG USER_UID
ARG USER_GID

## Create non-root user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

## Add sudo support in case we need to install software after connecting
## Jessie is not the latest stable Debian release - jessie-backports is not available
RUN rm -rf /etc/apt/sources.list.d/jessie-backports.list

RUN apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

## Install extra packages for python 3.6
COPY ./3.6 /tmp/3.6
RUN pip install -r /tmp/3.6/dev.txt

## Setup python 3.7 and install default and development packages to a virtual env
RUN apt-get update \
    && apt-get install -y python3.7 python3.7-venv

RUN python3.7 -m venv /root/venv

COPY ./3.7 /tmp/3.7
RUN /root/venv/bin/pip install -r /tmp/3.7/dev.txt

## Copy pytest execution script to /aws-glue-libs/bin
## in order to run pytest from the virtual env
COPY ./bin/gluepytest2 /home/aws-glue-libs/bin/gluepytest2