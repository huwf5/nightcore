# func_config
add_library(common_func_config STATIC "${CMAKE_CURRENT_SOURCE_DIR}/func_config.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/func_config.h")
target_include_directories(common_func_config INTERFACE "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(common_func_config PRIVATE
    base_common
    common_protocol
    utils_fs
    nlohmann_json::nlohmann_json
)

# http_status
add_library(common_http_status STATIC "${CMAKE_CURRENT_SOURCE_DIR}/http_status.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/http_status.h")
target_include_directories(common_http_status INTERFACE "${PROJECT_SOURCE_DIR}/src")

target_link_libraries(common_http_status PRIVATE
    base_common
)

# protocol
add_library(common_protocol INTERFACE)
target_sources(common_protocol INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/protocol.h")
target_include_directories(common_protocol INTERFACE "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(common_protocol INTERFACE
    base_common
    common_time
)

# stat
add_library(common_stat INTERFACE)
target_sources(common_stat INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/stat.h")
target_include_directories(common_stat INTERFACE "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(common_stat INTERFACE
    base_common
    common_time
    utils_bst
    utils_env_variables
    utils_random
)

# subprocess
add_library(common_subprocess STATIC "${CMAKE_CURRENT_SOURCE_DIR}/subprocess.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/subprocess.h")
target_include_directories(common_subprocess INTERFACE "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(common_subprocess PRIVATE
    base_common
    common_uv
    utils_appendable_buffer
    utils_buffer_pool
)

# time
add_library(common_time INTERFACE)
target_sources(common_time INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/time.h")
target_include_directories(common_time INTERFACE "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(common_time INTERFACE
    base_common
)

# uv
add_library(common_uv STATIC "${CMAKE_CURRENT_SOURCE_DIR}/uv.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/uv.h")
target_include_directories(common_uv INTERFACE "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(common_uv PRIVATE
    base_common
    base_thread
    uv_a
)