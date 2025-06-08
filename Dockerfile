FROM ubuntu:22.04

# Install base tools
RUN apt-get update && apt-get install -y \
    build-essential \
    mingw-w64 \
    cmake \
    git \
    pkg-config \
    wget \
    unzip \
    xz-utils \
    file \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /build

# Download and build GLFW for Windows
RUN git clone https://github.com/glfw/glfw.git && \
    cd glfw && \
    cmake -S . -B build \
        -DCMAKE_SYSTEM_NAME=Windows \
        -DCMAKE_C_COMPILER=x86_64-w64-mingw32-gcc \
        -DCMAKE_RC_COMPILER=x86_64-w64-mingw32-windres \
        -DCMAKE_INSTALL_PREFIX=/usr/x86_64-w64-mingw32 \
        -DBUILD_SHARED_LIBS=ON \
        -DGLFW_BUILD_EXAMPLES=OFF \
        -DGLFW_BUILD_TESTS=OFF \
        -DGLFW_BUILD_DOCS=OFF && \
    cmake --build build --target install

# Download and extract GLEW for MinGW (Windows)
RUN wget https://github.com/nigels-com/glew/releases/download/glew-2.2.0/glew-2.2.0-win32.zip && \
    unzip glew-2.2.0-win32.zip && \
    mkdir -p /usr/x86_64-w64-mingw32/include/GL && \
    cp -r glew-2.2.0/include/GL /usr/x86_64-w64-mingw32/include/ && \
    cp glew-2.2.0/lib/Release/x64/glew32.lib /usr/x86_64-w64-mingw32/lib/libglew32dll.a && \
    cp glew-2.2.0/lib/Release/x64/glew32s.lib /usr/x86_64-w64-mingw32/lib/libglew32s.a \
     && cp glew-2.2.0/bin/Release/x64/glew32.dll /usr/x86_64-w64-mingw32/bin/glew32.dll 
    # && rm -rf glew-2.2.0* 

WORKDIR /host
# Copy source files into container (or just overmount it with -v ${pwd}:/host)
COPY shader_hello.c buildwin.sh ./
RUN chmod +x /host/buildwin.sh

CMD ["/bin/bash"]

# docker build -t shader .
# docker run -it -v ${pwd}:/host --rm --name shader shader 
# ./buildwin.sh
