# appendable_buffer
add_library(utils_appendable_buffer INTERFACE)
target_sources(utils_appendable_buffer INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/appendable_buffer.h")
target_include_directories(utils_appendable_buffer INTERFACE "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(utils_appendable_buffer INTERFACE 
    base_common
)

# bench
add_library(utils_bench STATIC "${CMAKE_CURRENT_SOURCE_DIR}/bench.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/bench.h")
target_include_directories(utils_bench PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(utils_bench PRIVATE 
    base_common
    utils_env_variables
    utils_perf_event
    common_time
)

# bst
add_library(utils_bst INTERFACE)
target_sources(utils_bst INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/bst.h")
target_include_directories(utils_bst INTERFACE "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(utils_bst INTERFACE 
    base_common
)

# buffer_pool
add_library(utils_buffer_pool INTERFACE)
target_sources(utils_buffer_pool INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/buffer_pool.h")
target_include_directories(utils_buffer_pool INTERFACE "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(utils_buffer_pool INTERFACE 
    base_common
    common_uv
)

# docker
add_library(utils_docker STATIC "${CMAKE_CURRENT_SOURCE_DIR}/docker.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/docker.h")
target_include_directories(utils_docker PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(utils_docker PRIVATE 
    base_common
    utils_fs
    common_time
)

# dynamic_library
add_library(utils_dynamic_library INTERFACE)
target_sources(utils_dynamic_library INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/dynamic_library.h")
target_include_directories(utils_dynamic_library INTERFACE "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(utils_dynamic_library INTERFACE 
    base_common
    ${CMAKE_DL_LIBS}
)

# env_variables
add_library(utils_env_variables INTERFACE)
target_sources(utils_env_variables INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/env_variables.h")
target_include_directories(utils_env_variables INTERFACE "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(utils_env_variables INTERFACE 
    base_common
    absl::strings
)

# exp_moving_avg
add_library(utils_exp_moving_avg INTERFACE)
target_sources(utils_exp_moving_avg INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/exp_moving_avg.h")
target_include_directories(utils_exp_moving_avg INTERFACE "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(utils_exp_moving_avg INTERFACE 
    base_common
)

# fs
add_library(utils_fs STATIC "${CMAKE_CURRENT_SOURCE_DIR}/fs.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/fs.h")
target_include_directories(utils_fs PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(utils_fs PRIVATE 
    base_common
)

# io
add_library(utils_io INTERFACE)
target_sources(utils_io INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/io.h")
target_include_directories(utils_io INTERFACE "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(utils_io INTERFACE 
    base_common
)

# object_pool
add_library(utils_object_pool INTERFACE)
target_sources(utils_object_pool INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/object_pool.h")
target_include_directories(utils_object_pool INTERFACE "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(utils_object_pool INTERFACE 
    base_common
    absl::inlined_vector
)

# perf_event
add_library(utils_perf_event STATIC "${CMAKE_CURRENT_SOURCE_DIR}/perf_event.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/perf_event.h")
target_include_directories(utils_perf_event PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(utils_perf_event PRIVATE 
    base_common
)

# procfs
add_library(utils_procfs STATIC "${CMAKE_CURRENT_SOURCE_DIR}/procfs.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/procfs.h")
target_include_directories(utils_procfs PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(utils_procfs PRIVATE 
    base_common
    utils_fs
    common_time
)

# random 
add_library(utils_random STATIC "${CMAKE_CURRENT_SOURCE_DIR}/random.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/random.h")
target_include_directories(utils_random PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(utils_random PRIVATE 
    base_common
)

# socket
add_library(utils_socket STATIC "${CMAKE_CURRENT_SOURCE_DIR}/socket.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/socket.h")
target_include_directories(utils_socket PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(utils_socket PRIVATE 
    base_common
)