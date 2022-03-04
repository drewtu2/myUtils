FROM alpine:latest

LABEL maintainer="Andrew T <tu.a@husky.neu.edu>"
ARG NUM_CORES=2

VOLUME "/project"

WORKDIR "/project"

RUN apk update && \
    apk upgrade && \
    apk --update add \
        gcc \
        git \
        g++ \
        build-base \
        cmake \
        bash \
        libstdc++ \
        cppcheck \
        boost-dev \
        libtbb-dev \
        py-pip && \
        pip install conan && \
    rm -rf /var/cache/apk/*

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

ENTRYPOINT [ "bash", "-c" ]
