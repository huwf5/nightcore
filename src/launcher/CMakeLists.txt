# engine_connection
add_library(launcher_engine_connection STATIC "${CMAKE_CURRENT_SOURCE_DIR}/engine_connection.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/engine_connection.h")
target_include_directories(launcher_engine_connection PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(launcher_engine_connection PRIVATE
    base_common
    common_protocol
    common_uv
    utils_appendable_buffer
    utils_buffer_pool
    utils_object_pool
    launcher_launcher
    ipc_base
    utils_socket
    utils_env_variables
)

# func_process
add_library(launcher_func_process STATIC "${CMAKE_CURRENT_SOURCE_DIR}/func_process.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/func_process.h")
target_include_directories(launcher_func_process PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(launcher_func_process PRIVATE
    base_common
    common_protocol
    common_uv
    common_subprocess
    utils_buffer_pool
    utils_object_pool
    common_time
    utils_fs
    ipc_base
    launcher_launcher
)

# launcher
add_library(launcher_launcher STATIC "${CMAKE_CURRENT_SOURCE_DIR}/launcher.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/launcher.h")
target_include_directories(launcher_launcher PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(launcher_launcher PRIVATE
    base_common
    base_thread
    common_stat
    common_protocol
    common_func_config
    common_uv
    utils_buffer_pool
    launcher_engine_connection
    launcher_func_process
    ipc_base
    common_time
    utils_fs
    utils_docker
)