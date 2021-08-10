cmake_minimum_required(VERSION 3.16.0)

message(WARNING "fileio plugin parts not yet implemented in CMake")

project(fileio VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 COMPONENTS Quick REQUIRED)

add_library(fileio SHARED
    fileio.cpp
    fileio.h
    fileio_plugin.cpp
    fileio_plugin.h
)

set_target_properties(fileio PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/imports/org/example/io
)

add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/imports/org/example/io/qmldir
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/qmldir
    COMMAND "${CMAKE_COMMAND}" -E copy "${CMAKE_CURRENT_SOURCE_DIR}/qmldir" "${CMAKE_CURRENT_BINARY_DIR}/imports/org/example/io/qmldir"
    COMMENT "Copying qmldir"
)

target_sources(fileio PRIVATE
    ${CMAKE_CURRENT_BINARY_DIR}/imports/org/example/io/qmldir
)

target_link_libraries(fileio PRIVATE Qt6::Quick)
