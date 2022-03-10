FROM ubuntu:20.04

LABEL maintainer="Andrew T <tu.a+docker@husky.neu.edu>"

ARG NUM_CORES=2 
ARG APT_CMD="apt-get -qq --yes --no-install-recommends"

ENV TERM=xterm-color
ENV DEBIAN_FRONTEND=noninteractive

# Upgrade packages
RUN ${APT_CMD} update \
    && ${APT_CMD} dist-upgrade \
    && ${APT_CMD} clean \
    && rm -rf /var/lib/apt/lists/*

# Install basic tools
RUN ${APT_CMD} update \
    && ${APT_CMD} install \
        bash-completion \
        build-essential \ 
        coreutils \
        cmake \
        curl \
        debconf-utils \
        file \
        git \
        htop \
        iputils-ping \
        less \
        locales \
        openssh-client \
        python3 \
        python3-argcomplete \
        rsync \
        screen \
        sudo \
        tmux \
        tree \
        unzip \
        vim \
        wget \
        x11-xserver-utils \
        zip \
    && ${APT_CMD} clean \
    && rm -rf /var/lib/apt/lists/*

# Post-install configuration
# Configure locale and Set default localtime
RUN locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 \
    && ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime \
    && echo "America/New_York" > /etc/timezone

# Enable argparsing for python scripts. Assumes the use of argcomplete in said scripts.
RUN activate-global-python-argcomplete3

# Random libraries that we probably want to use.
RUN ${APT_CMD} update && ${APT_CMD} install \
    libeigen3-dev \
    libgoogle-glog-dev \
    libgtest-dev \
    libsuitesparse-dev \
    libopencv-dev \
    libzip-dev \
    libboost-all-dev \
    liblz4-dev \
    && ${APT_CMD} clean \
    && rm -rf /var/lib/apt/lists/*

# Install SSL certifications. If this isn't done, git will complain.
# https://stackoverflow.com/questions/35821245/github-server-certificate-verification-failed
RUN ${APT_CMD} update \
	&& ${APT_CMD} install --reinstall ca-certificates

# Install and source myUtils.
WORKDIR "/root"
RUN git clone https://github.com/drewtu2/myUtils.git \
    && cd myUtils \
    && ./setup-dotfiles.sh

WORKDIR "/"
######## Don't modify anything above here #########
# Do anything specific to a project here. 

# Install ldso from source. LDSO is DSO w/ Loop Closure and Global Optimization
WORKDIR /usr/src
RUN git clone https://github.com/tum-vision/LDSO.git
WORKDIR /usr/src/LDSO
RUN ${APT_CMD} update && ${APT_CMD} install \
    libeigen3-dev \
    libgoogle-glog-dev \
    libgtest-dev \
    libsuitesparse-dev \
    libopencv-dev \
    libzip-dev \
    libboost-all-dev \
    liblz4-dev


# Install Pangolin for visulization. Install a patch for solving Wayland problems.
RUN git clone --recursive https://github.com/stevenlovegrove/Pangolin.git \
    && cd Pangolin \
    && git pull origin pull/715/head --no-commit

WORKDIR /usr/src/LDSO/Pangolin
RUN apt-get update && yes | ./scripts/install_prerequisites.sh -m "apt" recommended 

RUN ${APT_CMD} update && ${APT_CMD} install \
    python3-pip

RUN mkdir build \
	&& cd build \
	&& cmake .. \
	&& cmake --build . \
    && cmake --build . -t pypangolin_pip_install


WORKDIR /usr/src/LDSO
COPY target/eigen_changes.diff eigen.diff
RUN patch -p0 < eigen.diff && ./make_project.sh

######## Don't modify anything below here #########

VOLUME "/root/app"
WORKDIR "/root/app"

# Drop into an interactive shell and source the bashrc.
ENTRYPOINT ["bash","-i"]
