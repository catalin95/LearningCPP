function(enable_clang_tidy target)
    if(NOT TARGET ${target})
        message(FATAL_ERROR "Target ${target} does not exist")
    endif()

    get_target_property(SOURCES ${target} SOURCES)
    if(NOT SOURCES)
        message(WARNING "Target ${target} has no sources to run clang-tidy on")
        return()
    endif()

    set(CLANG_TIDY_BINARY "clang-tidy")

    add_custom_target(
        tidy_${target}
        COMMAND ${CMAKE_COMMAND} -E echo "Running clang-tidy on target ${target}..."
        COMMAND ${CLANG_TIDY_BINARY} -p ${CMAKE_BINARY_DIR} ${SOURCES}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMENT "Running clang-tidy static analysis"
        VERBATIM
    )
endfunction()

function(enable_cppcheck target)
    if(NOT TARGET ${target})
        message(FATAL_ERROR "Target ${target} does not exist")
    endif()

    set(CPPCHECK_BINARY "cppcheck")
    set(CPPCHECK_FLAGS
        --enable=all
        --std=c++23
        --inconclusive
        --quiet
        --suppress=missingIncludeSystem
    )

    add_custom_target(
        cppcheck_${target}
        COMMAND ${CMAKE_COMMAND} -E echo "Running cppcheck on target ${target}..."
        COMMAND ${CPPCHECK_BINARY} ${CPPCHECK_FLAGS} --project=${CMAKE_BINARY_DIR}/compile_commands.json
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMENT "Running cppcheck static analysis"
        VERBATIM
    )
endfunction()
