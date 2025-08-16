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

function(set_compiler_flags_main_app)
    if(NOT CMAKE_CXX_COMPILER)
        message(FATAL_ERROR "C++ compiler is not set!")
    endif()

    message(STATUS "Setting compiler flags for ${CMAKE_CXX_COMPILER_ID}")

    if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set(CMAKE_CXX_FLAGS ${DEBUG_MAIN_FLAGS})
        
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        set(CMAKE_CXX_FLAGS ${DEBUG_MAIN_FLAGS})

    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
        set(CMAKE_CXX_FLAGS ${DEBUG_MSVC_FLAGS})

    else()
        message(WARNING "Unknown compiler: ${CMAKE_CXX_COMPILER_ID}, using default flags")
        set(COMMON_FLAGS "-Wall -Wextra -O2 -g")
    endif()

    message(STATUS "Compiler flags used in main app set to: ${CMAKE_CXX_FLAGS}")
endfunction()

function(set_compiler_flags_uts)
    if(NOT CMAKE_CXX_COMPILER)
        message(FATAL_ERROR "C++ compiler is not set!")
    endif()

    message(STATUS "Setting compiler flags for ${CMAKE_CXX_COMPILER_ID}")

    if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set(CMAKE_CXX_FLAGS ${DEBUG_UT_FLAGS})
        
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        set(CMAKE_CXX_FLAGS ${DEBUG_UT_FLAGS})

    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
        message(WARNING "Reusing MSVC flags for main app")
        set(CMAKE_CXX_FLAGS ${DEBUG_MSVC_FLAGS})

    else()
        message(WARNING "Unknown compiler: ${CMAKE_CXX_COMPILER_ID}, using default flags")
        set(COMMON_FLAGS "-Wall -Wextra -O2 -g")
    endif()

    message(STATUS "Compiler flags used in UTs set to: ${CMAKE_CXX_FLAGS}")
endfunction()
