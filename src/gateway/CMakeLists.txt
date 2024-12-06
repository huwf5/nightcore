# engine_connection
add_library(gateway_engine_connetion STATIC "${CMAKE_CURRENT_SOURCE_DIR}/engine_connection.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/engine_connection.h")
target_include_directories(gateway_engine_connetion PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(gateway_engine_connetion PRIVATE
    base_common
    common_uv
    common_protocol
    common_stat
    utils_appendable_buffer
    server_io_worker
    server_connection_base
    gateway_server
    absl::flags
)

# func_call_context
add_library(gateway_func_call_context INTERFACE)
target_sources(gateway_func_call_context INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/func_call_context.h")
target_include_directories(gateway_func_call_context INTERFACE "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(gateway_func_call_context INTERFACE
    base_common
    common_protocol
    utils_appendable_buffer
    server_connection_base
)

# grpc_connection
add_library(gateway_grpc_connection STATIC "${CMAKE_CURRENT_SOURCE_DIR}/grpc_connection.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/grpc_connection.h")
target_include_directories(gateway_grpc_connection PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(gateway_grpc_connection PRIVATE
    base_common
    common_uv
    utils_appendable_buffer
    utils_object_pool
    server_io_worker
    server_connection_base
    gateway_func_call_context
    nghttp2
    common_time
    common_http_status
    gateway_server
)

add_library(gateway_http_connection STATIC "${CMAKE_CURRENT_SOURCE_DIR}/http_connection.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/http_connection.h")
target_include_directories(gateway_http_connection PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(gateway_http_connection PRIVATE
    base_common
    common_uv
    common_http_status
    utils_appendable_buffer
    server_io_worker
    server_connection_base
    gateway_func_call_context
    http-parser-wrapper
    common_time
    gateway_server
    nlohmann_json::nlohmann_json
)

# server
add_library(gateway_server STATIC "${CMAKE_CURRENT_SOURCE_DIR}/server.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/server.h")
target_include_directories(gateway_server PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(gateway_server PRIVATE
    base_common
    base_thread
    common_uv
    common_stat
    common_protocol
    common_func_config
    server_server_base
    gateway_func_call_context
    gateway_http_connection
    gateway_grpc_connection
    gateway_engine_connetion
    ipc_base
    ipc_shm_region
    common_time
    utils_fs
    utils_io
    utils_docker
    worker_worker_lib
    absl::flags
)