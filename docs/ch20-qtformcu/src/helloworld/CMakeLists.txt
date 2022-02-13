cmake_minimum_required (VERSION 3.15)

project(helloworld VERSION 0.0.1 LANGUAGES C CXX ASM)

find_package(Qul)

if(Qul_VERSION VERSION_GREATER_EQUAL "1.7")
    qul_add_target(helloworld)
else()
    add_executable(helloworld)
    target_link_libraries(helloworld
        Qul::QuickUltralite
        Qul::QuickUltralitePlatform)
endif()

qul_target_qml_sources(helloworld helloworld.qml)

app_target_setup_os(helloworld)
app_target_default_main(helloworld helloworld)
