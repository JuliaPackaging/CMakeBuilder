using BinaryBuilder

# Collection of sources required to build CMake
sources = [
    "https://cmake.org/files/v3.12/cmake-3.12.0.tar.gz" =>
    "d0781a90f6cdb9049d104ac16a150f9350b693498b9dea8a0331e799db6b9d69", # v3.12.0
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/cmake-*
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$prefix -DCMAKE_TOOLCHAIN_FILE=/opt/$target/$target.toolchain -DCMAKE_USE_SYSTEM_LIBRARIES=Off ..
make
make install
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = supported_platforms() # build on all supported platforms

# FreeBSD doesn't work yet: BinaryBuilder.jl#232
platforms = filter!(p -> !(p isa FreeBSD), platforms)

# The products that we will ensure are always built
products(prefix) = [
    ExecutableProduct(prefix, "cmake", :cmake),
]

# Dependencies that must be installed before this package can be built
dependencies = [
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, "CMake", v"3.12.0", sources, script, platforms, products, dependencies)
