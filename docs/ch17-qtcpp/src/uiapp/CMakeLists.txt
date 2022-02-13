cmake_minimum_required(VERSION 3.16.0)

project(uiapp VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 COMPONENTS Gui REQUIRED)
find_package(Qt6 COMPONENTS Widgets REQUIRED)

add_executable(uiapp
    main.cpp
    mainwindow.cpp
)

target_link_libraries(uiapp PRIVATE Qt6::Gui Qt6::Widgets)
