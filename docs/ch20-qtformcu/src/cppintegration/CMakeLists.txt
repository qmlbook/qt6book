cmake_minimum_required (VERSION 3.15)

project(cppintegration VERSION 0.0.1 LANGUAGES C CXX ASM)

find_package(Qul)

if(Qul_VERSION VERSION_GREATER_EQUAL "1.7")
    qul_add_target(cppintegration counter.cpp)
else()
    add_executable(cppintegration counter.cpp)
    target_link_libraries(cppintegration
        Qul::QuickUltralite
        Qul::QuickUltralitePlatform)
endif()

#region generate_interfaces
qul_target_generate_interfaces(cppintegration counter.h)
#endregion generate_interfaces
qul_target_qml_sources(cppintegration cppintegration.qml PlainButton.qml)

app_target_setup_os(cppintegration)
app_target_default_main(cppintegration cppintegration)
