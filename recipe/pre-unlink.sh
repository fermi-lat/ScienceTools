#!/bin/bash

# Clean up libpython3.so symlink if created on Linux
if [ "$(uname)" != "Darwin" ] && [ -L "$PREFIX/lib/libpython3.so" ]; then
    rm -f "$PREFIX/lib/libpython3.so"
fi
