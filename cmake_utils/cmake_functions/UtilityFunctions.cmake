include(${CMAKE_SOURCE_DIR}/cmake_utils/cmake_config/CompilerFlags.cmake)

function(recommend_ninja_if_available)
    # Check if Ninja executable is available
    find_program(NINJA_EXECUTABLE ninja)

    if(NINJA_EXECUTABLE)
        if(NOT CMAKE_GENERATOR STREQUAL "Ninja")
            message(STATUS "Ninja is available at ${NINJA_EXECUTABLE}.")
            message(STATUS "Recommendation: run CMake with -G Ninja for faster builds.")
        endif()
    endif()

    message(STATUS "Using generator: ${CMAKE_GENERATOR}")
endfunction()

function(set_default_cxx_compiler_if_needed)

    if (NOT CMAKE_CXX_COMPILER)
        if(WIN32)
            set(CMAKE_CXX_COMPILER "cl" CACHE STRING "C++ compiler" FORCE)
        elseif(APPLE)
            if(EXISTS "/usr/local/opt/llvm/bin/clang++")
                set(CMAKE_CXX_COMPILER "/usr/local/opt/llvm/bin/clang++" CACHE STRING "C++ compiler" FORCE)
            elseif(EXISTS "/opt/homebrew/opt/llvm/bin/clang++")
                set(CMAKE_CXX_COMPILER "/opt/homebrew/opt/llvm/bin/clang++" CACHE STRING "C++ compiler" FORCE)
            else()
                set(CMAKE_CXX_COMPILER "clang++" CACHE STRING "C++ compiler" FORCE)
            endif()
        elseif(UNIX)
            set(CMAKE_CXX_COMPILER "g++" CACHE STRING "C++ compiler" FORCE)
        else()
            message(FATAL_ERROR "Unknown platform, cannot set default compiler")
        endif()
    endif()

    message(STATUS "Compiler set to ${CMAKE_CXX_COMPILER}")
endfunction()

function(set_target_flags target build_type)
    if(NOT CMAKE_CXX_COMPILER)
        message(FATAL_ERROR "C++ compiler is not set!")
    endif()

    message(STATUS "Setting compiler flags for ${CMAKE_CXX_COMPILER_ID}")
    set(LOCAL_FLAGS "")

    if (${build_type} STREQUAL "Debug")
        if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
            set(LOCAL_FLAGS ${DEBUG_GCC_FLAGS})
            
        elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
            set(LOCAL_FLAGS ${DEBUG_CLANG_FLAGS})

        elseif(CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang")
            set(LOCAL_FLAGS ${DEBUG_CLANG_FLAGS})

        elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
            set(LOCAL_FLAGS ${DEBUG_MSVC_FLAGS})

        else()
            message(WARNING "Unknown compiler: ${CMAKE_CXX_COMPILER_ID}, using default flags")
            set(COMMON_FLAGS -O0 -g -Wall -Wextra -Wpedantic)
            set(LOCAL_FLAGS ${COMMON_FLAGS})
        endif()
    endif()

    target_compile_options(${target} PRIVATE ${LOCAL_FLAGS})
    target_link_options(${target} PRIVATE ${LOCAL_FLAGS})

    message(STATUS "Compiler flags used in main app set to: ${LOCAL_FLAGS}")
endfunction()
