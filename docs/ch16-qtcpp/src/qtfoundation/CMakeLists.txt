cmake_minimum_required(VERSION 3.16.0)

project(foundation_tests VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 COMPONENTS Core REQUIRED)
find_package(Qt6 COMPONENTS Test REQUIRED)

add_executable(foundation_tests
    tst_foundation.cpp
)

target_link_libraries(foundation_tests PRIVATE Qt6::Core Qt6::Test)
