FROM public.ecr.aws/cevoaustralia/glue-base:3.0

ARG USERNAME
ARG USER_UID
ARG USER_GID

## Create non-root user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

## Add sudo support in case we need to install software after connecting
RUN apt-get update \
    && apt-get install -y sudo nano \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

## Install Python packages
COPY ./pkgs /tmp/pkgs
RUN pip install -r /tmp/pkgs/dev.txt
