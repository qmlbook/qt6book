cmake_minimum_required (VERSION 3.15)

project(cppmodel VERSION 0.0.1 LANGUAGES C CXX ASM)

find_package(Qul)

if(Qul_VERSION VERSION_GREATER_EQUAL "1.7")
    qul_add_target(cppmodel citymodel.cpp)
else()
    add_executable(cppmodel citymodel.cpp)
    target_link_libraries(cppmodel
        Qul::QuickUltralite
        Qul::QuickUltralitePlatform)
endif()

qul_target_generate_interfaces(cppmodel citymodel.h)
qul_target_qml_sources(cppmodel cppmodel.qml)

app_target_setup_os(cppmodel)

if(Qul_VERSION VERSION_GREATER_EQUAL "2.0")
    app_target_default_entrypoint(cppmodel cppmodel)
else()
    app_target_default_main(cppmodel cppmodel)
endif()
