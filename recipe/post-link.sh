#!/bin/bash

# Ensure libpython3.so symlink exists on Linux pointing to the active Python runtime library
if [ "$(uname)" != "Darwin" ] && [ ! -f "$PREFIX/lib/libpython3.so" ]; then
    for py_lib in "$PREFIX"/lib/libpython3.*.so.1.0 "$PREFIX"/lib/libpython3.*.so; do
        if [ -f "$py_lib" ]; then
            ln -sf "$(basename "$py_lib")" "$PREFIX/lib/libpython3.so"
            break
        fi
    done
fi
