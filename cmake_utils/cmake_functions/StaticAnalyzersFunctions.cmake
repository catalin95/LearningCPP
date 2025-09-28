function(enable_clang_tidy target)
    if(NOT TARGET ${target})
        message(FATAL_ERROR "Target ${target} does not exist")
    endif()

    set(CLANG_TIDY_BINARY "clang-tidy")

    # Collect all cpp source files in source directory
    file(GLOB_RECURSE CPP_SOURCES
         "${CMAKE_SOURCE_DIR}/source/*.cpp"
    )

    if(NOT CPP_SOURCES)
        message(WARNING "No C++ sources found for clang-tidy in source")
        return()
    endif()

    # Collect all module targets for dependency (optional)
    set(MODULE_TARGETS "")
    get_property(ALL_TARGETS DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY BUILDSYSTEM_TARGETS)
    foreach(tgt IN LISTS ALL_TARGETS)
        if(tgt MATCHES ".*module.*")
            list(APPEND MODULE_TARGETS ${tgt})
        endif()
    endforeach()

    message(STATUS "Catalin -> print cpp sources: ")

    add_custom_target(
        tidy_${target}
        COMMAND ${CMAKE_COMMAND} -E echo "Running clang-tidy on CPP files..."
        COMMAND ${CLANG_TIDY_BINARY} -p ${CMAKE_BINARY_DIR} ${CPP_SOURCES}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMENT "Running clang-tidy static analysis on .cpp files only"
        DEPENDS ${MODULE_TARGETS} ${target}  # ensure modules and target are built first
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

function(enable_iwyu target target_path)
    if(NOT TARGET ${target})
        message(FATAL_ERROR "Target ${target} does not exist")
    endif()

    # Path to IWYU binary (can be overridden with -DIWYU_BINARY=/path/to/iwyu)
    set(IWYU_BINARY "include-what-you-use")

    # Default flags (can be overridden by user)
    set(IWYU_FLAGS
        -std=c++23
    )

    add_custom_target(
        iwyu_${target}
        COMMAND ${CMAKE_COMMAND} -E echo "Running IWYU on target ${target}..."
        COMMAND ${IWYU_BINARY} ${IWYU_FLAGS}
        -I${CMAKE_SOURCE_DIR}/include
        -I${CMAKE_SOURCE_DIR}/mocks
        -I/opt/homebrew/include
        ${target_path}/${target}.cpp
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMENT "Running include-what-you-use analysis"
        VERBATIM
    )
endfunction()
