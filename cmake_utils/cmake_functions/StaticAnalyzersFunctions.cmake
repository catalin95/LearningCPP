function(enable_clang_tidy target)
    # Make sure target exists
    if(NOT TARGET ${target})
        message(FATAL_ERROR "Target ${target} does not exist")
    endif()

    # Build the compile commands for the target
    get_target_property(SOURCES ${target} SOURCES)
    if(NOT SOURCES)
        message(WARNING "Target ${target} has no sources to run clang-tidy on")
        return()
    endif()

    # Optional: set clang-tidy binary (can also use env var)
    set(CLANG_TIDY_BINARY "clang-tidy")

    # Add a custom target to run clang-tidy, and it will be tidy_ + binary name or target
    add_custom_target(
    tidy_${target}
    COMMAND ${CMAKE_COMMAND} -E echo "Running clang-tidy on target ${target}..."
    COMMAND ${CLANG_TIDY_BINARY} -checks=cppcoreguidelines-owning-memory ${SOURCES} -p ${CMAKE_BINARY_DIR} -- -std=gnu++23 -isysroot ${CMAKE_OSX_SYSROOT}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "Running clang-tidy static analysis"
    VERBATIM
)

endfunction()
