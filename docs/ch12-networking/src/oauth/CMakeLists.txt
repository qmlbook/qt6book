cmake_minimum_required(VERSION 3.14)

project(SpotifyOAuth VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick QuickControls2 Network NetworkAuth REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick QuickControls2 Network NetworkAuth REQUIRED)

set(
    PROJECT_SOURCES
        main.cpp
        spotifyapi.h spotifyapi.cpp
        spotifymodel.h spotifymodel.cpp
        qml.qrc
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(SpotifyOAuth MANUAL_FINALIZATION ${PROJECT_SOURCES})
else()
    add_executable(SpotifyOAuth ${PROJECT_SOURCES})
endif()

target_compile_definitions(
    SpotifyOAuth
    PRIVATE
        $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
)

target_link_libraries(
    SpotifyOAuth
    PRIVATE
        Qt${QT_VERSION_MAJOR}::Core
        Qt${QT_VERSION_MAJOR}::Quick
        Qt${QT_VERSION_MAJOR}::QuickControls2
        Qt${QT_VERSION_MAJOR}::Network
        Qt${QT_VERSION_MAJOR}::NetworkAuth
)

set_target_properties(
    SpotifyOAuth
    PROPERTIES
        QT_QML_MODULE_URI SpotifyOAuth
        QT_QML_MODULE_VERSION 1.0
        MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
        MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
        MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt6_qml_type_registration(SpotifyOAuth)
    qt_import_qml_plugins(SpotifyOAuth)
    qt_finalize_executable(SpotifyOAuth)
endif()
