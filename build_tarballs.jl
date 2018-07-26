using BinaryBuilder

# Collection of sources required to build CMake
sources = [
    "https://gitlab.kitware.com/cmake/cmake.git" =>
    "f84c15ef2fa30dd074fcccafccec6b9b69266619", # v3.12.0
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/cmake
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$prefix -DCMAKE_TOOLCHAIN_FILE=/opt/$target/$target.toolchain -DCMAKE_USE_SYSTEM_LIBRARIES=Off ..
make && make install
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
build_tarballs(ARGS, "CMake", sources, script, platforms, products, dependencies)

println("Contents of ", pwd(), " = ", readdir("."))
if isdir("products")
    println("PRODUCTS = ", readdir("products"))
else
    println("products/ directory not found")
end
