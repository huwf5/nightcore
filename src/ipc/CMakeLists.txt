# base
add_library(ipc_base STATIC "${CMAKE_CURRENT_SOURCE_DIR}/base.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/base.h")
target_include_directories(ipc_base PUBLIC "${PROJECT_SOURCE_DIR}/include")
target_link_libraries(ipc_base PRIVATE
    base_common
    utils_fs
)

# fifo
add_library(ipc_fifo STATIC "${CMAKE_CURRENT_SOURCE_DIR}/fifo.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/fifo.h")
target_include_directories(ipc_fifo PUBLIC "${PROJECT_SOURCE_DIR}/include")
target_link_libraries(ipc_fifo PRIVATE
    base_common
    ipc_base
    utils_fs
    common_time
)

# shm_region
add_library(ipc_shm_region STATIC "${CMAKE_CURRENT_SOURCE_DIR}/shm_region.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/shm_region.h")
target_include_directories(ipc_shm_region PUBLIC "${PROJECT_SOURCE_DIR}/include")
target_link_libraries(ipc_shm_region PRIVATE
    base_common
    ipc_base
    common_stat
    common_time
    utils_fs
)

# spsc_queue
add_library(ipc_spsc_queue INTERFACE)
target_sources(ipc_spsc_queue INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/spsc_queue.h" "${CMAKE_CURRENT_SOURCE_DIR}/spsc_queue-inl.h")
target_include_directories(ipc_spsc_queue INTERFACE "${PROJECT_SOURCE_DIR}/include")
target_link_libraries(ipc_spsc_queue INTERFACE
    base_common
    ipc_shm_region
    base_asm
)