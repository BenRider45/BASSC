cmake_minimum_required(VERSION 3.21)
project(ProjectCore VERSION 1.0 LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core)

# ── Library target ─────────────────────────────────────────────────────────────
# Use STATIC to embed the library into the consuming executable.
# Swap to SHARED if you want a runtime .so / .dll instead.
add_library(ProjectCore STATIC
    src/Project.cpp
    src/ProjectHandler.cpp
    include/ProjectCore/Project.h
    include/ProjectCore/ProjectHandler.h
)

# ── Public headers ─────────────────────────────────────────────────────────────
# PRIVATE   = only needed to build this lib, not exposed to consumers
# PUBLIC    = needed to build this lib AND by anything that links it
# INTERFACE = not needed to build this lib, but required by consumers
target_include_directories(ProjectCore
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>   # used when installed to the system
)

target_link_libraries(ProjectCore
    PUBLIC Qt6::Core      # consumers of ProjectCore also get Qt6::Core
)

# ── Qt automoc needs to find headers alongside sources ────────────────────────
# Without this, moc won't find Q_OBJECT headers in the include/ folder
set_target_properties(ProjectCore PROPERTIES
    AUTOMOC ON
)

# ── Optional: install rules (for use as a proper reusable package) ─────────────
# Uncomment if you want to install this lib to the system or a staging directory
#
# include(GNUInstallDirs)
# install(TARGETS ProjectCore
#     EXPORT ProjectCoreTargets
#     ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
# )
# install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
# install(EXPORT ProjectCoreTargets
#     FILE ProjectCoreConfig.cmake
#     DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/ProjectCore
# )
