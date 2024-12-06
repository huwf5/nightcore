# bin object

# engine
add_executable(engine "${CMAKE_CURRENT_SOURCE_DIR}/engine.cpp")
target_link_libraries(engine PRIVATE 
    base_init
    base_common
    ipc_base
    utils_docker
    utils_fs
    utils_env_variables
    engine_engine
    absl::flags
)

# func_worker_v1
add_executable(func_worker_v1 "${CMAKE_CURRENT_SOURCE_DIR}/func_worker_v1.cpp")
target_link_libraries(func_worker_v1 PRIVATE 
    base_init
    base_common
    ipc_base
    utils_env_variables
    worker_v1_func_worker
)

# gateway
add_executable(gateway "${CMAKE_CURRENT_SOURCE_DIR}/gateway.cpp")
target_link_libraries(gateway PRIVATE 
    base_init
    base_common
    ipc_base
    utils_docker
    utils_env_variables
    gateway_server
    absl::flags
)

# launcher
add_executable(launcher "${CMAKE_CURRENT_SOURCE_DIR}/launcher.cpp")
target_link_libraries(launcher PRIVATE 
    base_init
    base_common
    ipc_base
    launcher_launcher
    absl::flags
)

# benchmark object

if (BUILD_BENCH)
    # bench_eventfd
    add_executable(bench_eventfd "${CMAKE_CURRENT_SOURCE_DIR}/bench_eventfd.cpp")
    target_link_libraries(bench_eventfd PRIVATE 
        base_init
        base_common
        common_time
        utils_bench
        absl::flags
    )
    set_target_properties(bench_eventfd PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/bench)

    # bench_futex
    add_executable(bench_futex "${CMAKE_CURRENT_SOURCE_DIR}/bench_futex.cpp")
    target_link_libraries(bench_futex PRIVATE 
        base_init
        base_common
        common_time
        utils_bench
        absl::flags
    )
    set_target_properties(bench_futex PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/bench)

    # bench_ipc_shm
    add_executable(bench_ipc_shm "${CMAKE_CURRENT_SOURCE_DIR}/bench_ipc_shm.cpp")
    target_link_libraries(bench_ipc_shm PRIVATE 
        base_init
        base_common
        common_time
        utils_fs
        utils_bench
        absl::flags
    )
    set_target_properties(bench_ipc_shm PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/bench)

    # bench_shared_mem
    add_executable(bench_shared_mem "${CMAKE_CURRENT_SOURCE_DIR}/bench_shared_mem.cpp")
    target_link_libraries(bench_shared_mem PRIVATE 
        base_init
        base_common
        common_time
        utils_fs
        utils_bench
        absl::flags
    )
    set_target_properties(bench_shared_mem PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/bench)

    # bench_socket
    add_executable(bench_socket "${CMAKE_CURRENT_SOURCE_DIR}/bench_socket.cpp")
    target_link_libraries(bench_socket PRIVATE 
        base_init
        base_common
        common_time
        utils_io
        utils_socket
        utils_bench
        absl::flags
    )
    set_target_properties(bench_socket PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/bench)

    # bench_spsc_queue
    add_executable(bench_spsc_queue "${CMAKE_CURRENT_SOURCE_DIR}/bench_spsc_queue.cpp")
    target_link_libraries(bench_spsc_queue PRIVATE 
        base_init
        base_asm
        base_common
        common_time
        utils_bench
        ipc_spsc_queue
        absl::flags
    )
    set_target_properties(bench_spsc_queue PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/bench)
endif()