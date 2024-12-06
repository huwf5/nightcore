# dispatcher
add_library(engine_dispatcher STATIC "${CMAKE_CURRENT_SOURCE_DIR}/dispatcher.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/dispatcher.h")
target_include_directories(engine_dispatcher PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(engine_dispatcher PRIVATE
    base_common
    common_stat
    common_protocol
    common_func_config
    utils_object_pool
    engine_tracer
    ipc_base
    engine_engine
    absl::flags
)

# engine
add_library(engine_engine STATIC "${CMAKE_CURRENT_SOURCE_DIR}/engine.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/engine.h")
target_include_directories(engine_engine PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(engine_engine PRIVATE
    base_common
    common_uv
    common_protocol
    common_func_config
    server_server_base
    engine_gateway_connection
    engine_message_connection
    engine_dispatcher
    engine_worker_manager
    engine_monitor
    engine_tracer
    ipc_base
    ipc_shm_region
    common_time
    utils_fs
    utils_io
    utils_docker
    utils_socket
    worker_worker_lib
    absl::flags
)


# gateway_connection
add_library(engine_gateway_connection STATIC "${CMAKE_CURRENT_SOURCE_DIR}/gateway_connection.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/gateway_connection.h")
target_include_directories(engine_gateway_connection PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(engine_gateway_connection PRIVATE
    base_common
    common_uv
    common_protocol
    common_stat
    utils_appendable_buffer
    server_io_worker
    server_connection_base
    engine_engine
    absl::flags
)

# message_connection
add_library(engine_message_connection STATIC "${CMAKE_CURRENT_SOURCE_DIR}/message_connection.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/message_connection.h")
target_include_directories(engine_message_connection PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(engine_message_connection PRIVATE
    base_common
    common_uv
    common_protocol
    common_stat
    utils_appendable_buffer
    utils_object_pool
    server_io_worker
    server_connection_base
    common_time
    common_uv
    ipc_base
    ipc_fifo
    engine_engine
    absl::flags
)

# monitor
add_library(engine_monitor STATIC "${CMAKE_CURRENT_SOURCE_DIR}/monitor.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/monitor.h")
target_include_directories(engine_monitor PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(engine_monitor PRIVATE
    base_common
    base_thread
    common_time
    utils_docker
    utils_procfs
    engine_engine
)

# tracer
add_library(engine_tracer STATIC "${CMAKE_CURRENT_SOURCE_DIR}/tracer.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/tracer.h")
target_include_directories(engine_tracer PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(engine_tracer PRIVATE
    base_common
    common_protocol
    common_stat
    utils_object_pool
    utils_exp_moving_avg
    engine_engine
    engine_worker_manager
    absl::flags
)

# worker_manager
add_library(engine_worker_manager STATIC "${CMAKE_CURRENT_SOURCE_DIR}/worker_manager.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/worker_manager.h")
target_include_directories(engine_worker_manager PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(engine_worker_manager PRIVATE
    base_common
    common_protocol
    engine_message_connection
    ipc_base
    ipc_fifo
    engine_engine
)