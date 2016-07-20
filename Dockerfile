FROM ubuntu:14.04


RUN apt-get update && apt-get install -y \
    libtiff-dev libgeotiff-dev libgdal1-dev \
    libboost-system-dev libboost-thread-dev libboost-filesystem-dev libboost-program-options-dev libboost-regex-dev libboost-iostreams-dev \
    git cmake build-essential wget software-properties-common

RUN add-apt-repository ppa:ubuntu-toolchain-r/test && apt-get update && apt-get install -y gcc-4.9 g++-4.9 && \
    cd /usr/bin && \
    rm gcc g++ cpp && \
    ln -s gcc-4.9 gcc && \
    ln -s g++-4.9 g++ && \
    ln -s cpp-4.9 cpp

WORKDIR /opt

RUN git clone https://github.com/m-schuetz/LAStools.git && cd LAStools/LASzip && mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && make && make install

# Build potree converter
RUN git clone https://github.com/potree/PotreeConverter.git /opt/PotreeConverter
WORKDIR /opt/PotreeConverter
RUN git checkout develop && mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release -DLASZIP_INCLUDE_DIRS=/opt/LAStools/LASzip/dll/ -DLASZIP_LIBRARY=/opt/LAStools/LASzip/build/src/liblaszip.so .. && \
    make && make install && rm /usr/local/bin/PotreeConverter && ln -s /opt/PotreeConverter/build/PotreeConverter/PotreeConverter /usr/local/bin/PotreeConverter

#CMD PotreeConverter
