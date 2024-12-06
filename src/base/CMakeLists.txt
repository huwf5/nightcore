# asm
add_library(base_asm INTERFACE)
target_sources(base_asm INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/asm.h")
target_include_directories(base_asm INTERFACE "${PROJECT_SOURCE_DIR}/src")


# common
# TODO: 1.<python.h> 
# macro defination 
add_library(base_common INTERFACE)
target_sources(base_common INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/common.h")
target_include_directories(base_common INTERFACE "${PROJECT_SOURCE_DIR}/src")

if(DEFINED __FAAS_SRC)
    target_compile_definitions(base_common INTERFACE __FAAS_SRC)
endif()
target_compile_definitions(base_common INTERFACE 
    $<$<BOOL:${__FAAS_SRC}>:__FAAS_HAVE_ABSL>
)
target_link_libraries(base_common INTERFACE 
    absl::time absl::strings absl::random_random absl::random_distributions absl::flat_hash_map absl::flat_hash_set absl::inlined_vector absl::synchronization absl::bind_front absl::algorithm_container
    fmt::fmt-header-only
    Microsoft.GSL::GSL
    base_macro base_logging base_std_span_polyfill
)

# init
add_library(base_init STATIC "${CMAKE_CURRENT_SOURCE_DIR}/init.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/init.h")
target_include_directories(base_init PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(base_init PRIVATE 
    absl::flags absl::flags_parse absl::symbolize absl::failure_signal_handler
    base_logging base_thread
)

# logging
add_library(base_logging STATIC "${CMAKE_CURRENT_SOURCE_DIR}/logging.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/logging.h")
target_include_directories(base_logging PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(base_logging PRIVATE 
    fmt::fmt-header-only
    base_macro
)
if(DEFINED __FAAS_SRC)
    target_link_libraries(base_logging PRIVATE 
        absl::synchronization
        base_thread
    )
endif()

# macro
add_library(base_macro INTERFACE)
target_sources(base_macro INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/macro.h")
target_include_directories(base_macro INTERFACE "${PROJECT_SOURCE_DIR}/src")

# std_span_polyfill
add_library(base_std_span_polyfill INTERFACE)
target_sources(base_std_span_polyfill INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}/std_span_polyfill.h")
target_include_directories(base_std_span_polyfill INTERFACE "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(base_std_span_polyfill INTERFACE 
    Microsoft.GSL::GSL
)

# thread
add_library(base_thread STATIC "${CMAKE_CURRENT_SOURCE_DIR}/thread.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/thread.h")
target_include_directories(base_thread PUBLIC "${PROJECT_SOURCE_DIR}/src")
target_link_libraries(base_thread PRIVATE 
    base_common
    utils_env_variables
    Threads::Threads
)
