cmake_minimum_required(VERSION 3.16.0)

project(valuemodel VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 COMPONENTS Quick REQUIRED)
find_package(Qt6 COMPONENTS QuickControls2 REQUIRED)

add_executable(valuemodel
    main.cpp
    adaptivemodel.cpp
    adaptivemodel.h
    valuemodel.cpp
    valuemodel.h
    qml.qrc
)

target_link_libraries(valuemodel PRIVATE Qt6::Quick Qt6::QuickControls2)
