cmake_minimum_required(VERSION 3.10)

project(nightcore)

# check build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE release)
endif()

set(SRC_PATH ${CMAKE_CURRENT_LIST_DIR}/src)
set(DEPS ${CMAKE_CURRENT_LIST_DIR}/deps)
set(DEPS_INSTALL_PATH ${DEPS}/out)
set(SRC_EXT "cpp")

# Leave C++ standard up to the root application, so set it only if this is the
# current top-level CMake project.
if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  set(CMAKE_CXX_STANDARD 17)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)
endif()

# set global compile options
add_compile_options(
    -Wall -Wextra -Werror -Wno-unused-parameter -Wno-unused-variable
    -fdata-sections -ffunction-sections
    -MP -MMD
)

set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG")
set(CMAKE_CXX_FLAGS_DEBUG   "-g  -DDEBUG")

# set global linker options
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,--gc-sections")

set(CMAKE_VERBOSE_MAKEFILE ON)

# Macro settings
add_definitions(-D__FAAS_SRC)
# _POSIX_C_SOURCE=200112

# config.mk
option(DISABLE_STAT "State" ON)
option(USE_NEW_STAT_COLLECTOR "USE_NEW_STAT_COLLECTOR" OFF)
option(DEBUG_BUILD "DEBUG_BUILD" OFF)
option(BUILD_BENCH "BUILD_BENCH" OFF)

if(DISABLE_STAT)
  add_definitions(-D__FAAS_DISABLE_STAT)
endif()
if(USE_NEW_STAT_COLLECTOR)
  add_definitions(-D__FAAS_USE_NEW_STAT_COLLECTOR)
endif()

# get deps
find_package(Git REQUIRED)
if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
# Update submodules as needed
    option(GIT_SUBMODULE "Check submodules during build" ON)
    if(GIT_SUBMODULE)
        message(STATUS "Submodule update")
        execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
                        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                        RESULT_VARIABLE GIT_SUBMOD_RESULT)
        if(NOT GIT_SUBMOD_RESULT EQUAL "0")
            message(FATAL_ERROR "git submodule update --init --recursive failed with ${GIT_SUBMOD_RESULT}, please checkout submodules")
        endif()
    endif()
endif()


# faas_interface target
add_library(faas_worker_v1_interface INTERFACE)
target_sources(faas_worker_v1_interface INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/include/faas/worker_v1_interface.h")
target_include_directories(faas_worker_v1_interface INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/include")

# deps

# pthread 
find_package(Threads REQUIRED)
if(NOT Threads_FOUND)
    message(FATAL_ERROR "pthread not found")
endif()

# fmt
add_subdirectory(${DEPS}/fmt)
include_directories(${DEPS}/fmt/include)

# GSL
add_subdirectory(${DEPS}/GSL)
include_directories(${DEPS}/GSL/include)

# abseil-cpp
# ref: https://github.com/abseil/abseil-cpp/blob/master/CMake/README.md
add_subdirectory(${DEPS}/abseil-cpp)
include_directories(${DEPS}/abseil-cpp)

# http-parser
include(ExternalProject)
ExternalProject_Add(http-parser
    PREFIX ${DEPS}
    SOURCE_DIR ${DEPS}/http-parser
    BINARY_DIR ${DEPS}/http-parser
    CONFIGURE_COMMAND ""  
    BUILD_COMMAND 
        COMMAND ${CMAKE_COMMAND} -E echo "Building http-parser"
        COMMAND make clean
        COMMAND make package
    INSTALL_COMMAND 
        COMMAND ${CMAKE_COMMAND} -E make_directory ${DEPS_INSTALL_PATH}/include
        COMMAND ${CMAKE_COMMAND} -E copy ${DEPS}/http-parser/http_parser.h ${DEPS_INSTALL_PATH}/include/http_parser.h
        COMMAND ${CMAKE_COMMAND} -E make_directory ${DEPS_INSTALL_PATH}/lib
        COMMAND ${CMAKE_COMMAND} -E copy ${DEPS}/http-parser/libhttp_parser.a ${DEPS_INSTALL_PATH}/lib/libhttp_parser.a
        COMMAND ${CMAKE_COMMAND} -E chdir ${DEPS}/http-parser make clean
        COMMAND ${CMAKE_COMMAND} -E echo "Installation of http-parser completed"
)
# wrap http-parser as a target
add_library(http-parser-wrapper INTERFACE)
add_dependencies(http-parser-wrapper http-parser)
target_include_directories(http-parser-wrapper INTERFACE ${DEPS_INSTALL_PATH}/include)
target_link_libraries(http-parser-wrapper INTERFACE ${DEPS_INSTALL_PATH}/lib/libhttp_parser.a)
include_directories(${DEPS_INSTALL_PATH}/include)

message(STATUS "Http-parser include directory: ${DEPS_INSTALL_PATH}/include")
message(STATUS "Http-parser library directory: ${DEPS_INSTALL_PATH}/lib")

# json
# library target: nlohmann_json::nlohmann_json
set(JSON_BuildTests OFF CACHE INTERNAL "")
add_subdirectory(${DEPS}/json)

# libuv
set(LiBUV_BUILD_TESTS OFF CACHE BOOL "Build libuv tests")
add_subdirectory(${DEPS}/libuv)
include_directories(${DEPS}/libuv/include)

# nghttp2
set(ENABLE_LIB_ONLY ON CACHE BOOL "Only build nghttp2 library")
set(ENABLE_ASIO_LIB OFF CACHE BOOL "Do not build the asio library")
set(ENABLE_STATIC_LIB ON CACHE BOOL "Build static library")
set(ENABLE_SHARED_LIB OFF CACHE BOOL "Build shared library")
set(WITH_JEMALLOC OFF CACHE BOOL "Do not use jemalloc")
add_subdirectory(${DEPS}/nghttp2)
include_directories(${DEPS}/nghttp2/lib/includes)
include_directories(${CMAKE_BINARY_DIR}/deps/nghttp2/lib/includes)


# pybind11
# TODO:
add_subdirectory(${DEPS}/pybind11)


# nightcore
add_subdirectory(${SRC_PATH}/base)
add_subdirectory(${SRC_PATH}/bin)
add_subdirectory(${SRC_PATH}/common)
add_subdirectory(${SRC_PATH}/engine)
add_subdirectory(${SRC_PATH}/gateway)
add_subdirectory(${SRC_PATH}/ipc)
add_subdirectory(${SRC_PATH}/launcher)
add_subdirectory(${SRC_PATH}/server)
add_subdirectory(${SRC_PATH}/utils)
add_subdirectory(${SRC_PATH}/worker)
