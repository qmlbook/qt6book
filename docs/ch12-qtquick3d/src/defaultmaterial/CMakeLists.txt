cmake_minimum_required(VERSION 3.16)

project(defaultmaterial VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)

qt_add_executable(appdefaultmaterial
    main.cpp
)

qt_add_qml_module(appdefaultmaterial
    URI defaultmaterial
    VERSION 1.0
    QML_FILES main.qml 
    RESOURCES meshes/suzanne.mesh maps/skybox.jpg
)

set_target_properties(appdefaultmaterial PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(appdefaultmaterial
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appdefaultmaterial
    PRIVATE Qt6::Quick)
