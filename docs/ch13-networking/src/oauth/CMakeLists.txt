cmake_minimum_required(VERSION 3.16.0)

project(SpotifyOAuth VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 COMPONENTS Core Quick QuickControls2 Network NetworkAuth REQUIRED)

qt_add_executable(SpotifyOAuth main.cpp)

qt_add_qml_module(SpotifyOAuth
    VERSION 1.0.0
    URI Spotify
    QML_FILES
        main.qml
    SOURCES
        spotifyapi.h spotifyapi.cpp
        spotifymodel.h spotifymodel.cpp
)

set_target_properties(SpotifyOAuth PROPERTIES
    WIN32_EXECUTABLE TRUE
    MACOSX_BUNDLE TRUE
)

target_link_libraries(SpotifyOAuth PRIVATE Qt6::Core Qt6::Quick Qt6::QuickControls2 Qt6::Network Qt6::NetworkAuth)
