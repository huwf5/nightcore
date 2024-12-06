# connection_base
add_library(server_connection_base INTERFACE)
target_sources(server_connection_base INTERFACE
    "${CMAKE_CURRENT_SOURCE_DIR}/connection_base.h"
)
target_include_directories(server_connection_base INTERFACE "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(server_connection_base INTERFACE
    base_common
    common_uv
)

# io_worker
add_library(server_io_worker STATIC "${CMAKE_CURRENT_SOURCE_DIR}/io_worker.cpp")
target_include_directories(server_io_worker PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(server_io_worker PRIVATE
    base_common
    base_thread
    common_uv
    common_uv
    common_stat
    utils_buffer_pool
    utils_object_pool
    server_connection_base
)

add_library(server_server_base STATIC "${CMAKE_CURRENT_SOURCE_DIR}/server_base.cpp")
target_include_directories(server_server_base PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(server_server_base PRIVATE
    base_common
    common_uv
    utils_appendable_buffer
    server_connection_base
    server_io_worker
)