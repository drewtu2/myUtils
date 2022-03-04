FROM ubuntu:16.04

MAINTAINER Eran Segal <eran@sphericalcow.io>

USER root
ARG NUM_CORES=2

## Install packages
RUN apt-get update -q && \
    apt-get install -y --fix-missing --no-install-recommends \
    # Basics
    ca-certificates \
    wget curl build-essential checkinstall unzip autoconf automake libtool g++ yasm cmake git \
    # GTSAM Prerequisites
    libboost-all-dev libtbb-dev

# ## Intel MKL
# ENV MKL_VER=l_mkl_11.3.3.210
# ENV MKL_PATH=/opt/intel

# WORKDIR /tmp
# RUN wget http://registrationcenter-download.intel.com/akdlm/irc_nas/9068/${MKL_VER}.tgz && \
#     tar xzf ${MKL_VER}.tgz

# # NOTE: Installer may complain about "Unsupported OS". Installation should still be valid.
# RUN cd ${MKL_VER} && \
#     sed -i 's/ACCEPT_EULA=decline/ACCEPT_EULA=accept/g' silent.cfg && \
#     sed -i 's/ACTIVATION_TYPE=exist_lic/ACTIVATION_TYPE=trial_lic/g' silent.cfg && \
#     ./install.sh -s silent.cfg && \
#     cd .. && rm -rf ${MKL_VER}*

# # Configure dynamic link
# RUN echo "${MKL_PATH}/lib/intel64\n${MKL_PATH}/mkl/lib/intel64" > /etc/ld.so.conf.d/mkl.conf && \
#   ldconfig && \
#   echo ". ${MKL_PATH}/bin/compilervars.sh intel64" >> /etc/bash.bashrc

# GTSAM
WORKDIR /tmp
RUN git clone https://bitbucket.org/gtborg/gtsam.git && \
    cd gtsam && \
    mkdir build && \
    cd build && \
    cmake -DGTSAM_USE_QUATERNIONS=ON \
          -DGTSAM_BUILD_PYTHON=ON \
          -DGTSAM_ALLOW_DEPRECATED_SINCE_V4=OFF \
          .. && \
    make -j $NUM_CORES && \
    make install

# cleanup
# RUN ldconfig && \
#     apt-get autoclean && apt-get clean && \
#     rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Misc
# ENV LC_ALL=C
# RUN export uid=1000 gid=1000 && \
#     mkdir -p /home/user && \
#     echo "user:x:${uid}:${gid}:Developer,,,:/home/user:/bin/bash" >> /etc/passwd && \
#     echo "user:x:${uid}:" >> /etc/group && \
#     echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
#     chown ${uid}:${gid} -R /home/user

# RUN mv /tmp/gtsam /home/user/ && \
#     chown -R $uid:$gid /home/user/gtsam

# ## Use something like this to connect to your xserver
# # -e DISPLAY -v $HOME/.Xauthority:/home/user/.Xauthority --net=host


# USER user
# ENV HOME /home/user
# WORKDIR /home/user
# CMD /bin/bash
