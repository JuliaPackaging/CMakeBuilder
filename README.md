# CMakeBuilder

[![Build Status](https://travis-ci.org/JuliaPackaging/CMakeBuilder.svg?branch=master)](https://travis-ci.org/JuliaPackaging/CMakeBuilder)

This repository builds compiled binaries of [cmake](https://cmake.org/) for the Julia packages that require this program to build. Binary artifacts are automatically uploaded to
[this repository's GitHub releases page](https://github.com/JuliaPackaging/CMakeBuilder/releases) whenever a tag is created
on this repository.

This repository uses [BinaryBuilder.jl](https://github.com/JuliaPackaging/BinaryBuilder.jl).
