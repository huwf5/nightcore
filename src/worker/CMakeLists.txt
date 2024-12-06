# func_worker
add_library(worker_v1_func_worker STATIC
    "${CMAKE_CURRENT_SOURCE_DIR}/v1/func_worker.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/v1/func_worker.h"
)
target_include_directories(worker_v1_func_worker PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(worker_v1_func_worker PRIVATE
    base_common
    base_thread
    common_stat
    common_protocol
    common_func_config
    utils_dynamic_library
    utils_appendable_buffer
    utils_buffer_pool
    ipc_shm_region
    faas_worker_v1_interface
    common_time
    ipc_base
    ipc_fifo
    utils_io
    utils_socket
    worker_worker_lib
)

# event_driven_worker
add_library(worker_event_driven_worker STATIC
    "${CMAKE_CURRENT_SOURCE_DIR}/event_driven_worker.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/event_driven_worker.h"
)
target_include_directories(worker_event_driven_worker PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(worker_event_driven_worker PRIVATE
    base_common
    common_func_config
    common_protocol
    ipc_shm_region
    utils_object_pool
    common_time
    ipc_base
    ipc_fifo
    utils_io
    utils_socket
    utils_env_variables
    worker_worker_lib
)

# worker_lib
add_library(worker_worker_lib STATIC
    "${CMAKE_CURRENT_SOURCE_DIR}/worker_lib.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/worker_lib.h"
)
target_include_directories(worker_worker_lib PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(worker_worker_lib PRIVATE
    base_common
    common_protocol
    ipc_shm_region
    ipc_fifo
)