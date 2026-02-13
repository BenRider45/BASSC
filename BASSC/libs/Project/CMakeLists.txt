project(Project VERSION 1.0.0 LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core Multimedia)

add_library(project
    src/Project.cpp
    include/Project/Project.h
)

target_include_directories(project
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
)

target_link_libraries(audiocore
    PUBLIC
        Qt6::Core
        Qt6::Multimedia
)

# Alias for consistent naming
add_library(BASSC::Project ALIAS project)
