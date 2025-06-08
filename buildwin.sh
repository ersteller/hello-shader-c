#!/bin/bash
 x86_64-w64-mingw32-gcc -m64 -o shader_hello.exe shader_hello.c \
 -I/usr/x86_64-w64-mingw32/include \
 -L/usr/x86_64-w64-mingw32/lib \
 -l"glfw3dll" -l"glew32dll" -lopengl32 -lgdi32 -luser32 -lkernel32 \
 -static-libgcc -static-libstdc++

cp /usr/x86_64-w64-mingw32/bin/glew32.dll .
cp /usr/x86_64-w64-mingw32/bin/glfw3.dll .



