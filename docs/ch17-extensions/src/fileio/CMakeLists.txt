cmake_minimum_required(VERSION 3.16.0)

message(WARNING "fileio plugin parts not yet implemented in CMake")

project(fileio VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 COMPONENTS Quick REQUIRED)

add_library(fileio
    fileio.cpp
    fileio.h
    fileio_plugin.cpp
    fileio_plugin.h
)

target_link_libraries(fileio PRIVATE Qt6::Quick)
