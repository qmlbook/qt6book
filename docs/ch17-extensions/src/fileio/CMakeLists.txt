cmake_minimum_required(VERSION 3.16.0)

message(WARNING "fileio plugin installation part not yet implemented in CMake")

project(fileio VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 COMPONENTS Quick REQUIRED)

qt_add_qml_module(fileio PLUGIN_TARGET
    VERSION 1.0.0
    URI "org.example.io"
    OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/imports/org/example/io/"
    SOURCES
        fileio.cpp
        fileio.h
        fileio_plugin.cpp
)

set_target_properties(fileio PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

target_link_libraries(fileio PRIVATE Qt6::Quick)
