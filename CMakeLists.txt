cmake_minimum_required(VERSION 3.30.8)

include(${CMAKE_SOURCE_DIR}/cmake_utils/cmake_functions/StaticAnalyzersFunctions.cmake)
include(${CMAKE_SOURCE_DIR}/cmake_utils/cmake_functions/UtilityFunctions.cmake)

recommend_ninja_if_available()
set_default_cxx_compiler_if_needed()

project(Learning VERSION 1.0 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 23)
set(MainProgram main)

set_compiler_flags_main_app()
set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE BOOL "Generate compile_commands.json" FORCE)

# Option to enable clang-tidy dependency
option(ENABLE_CLANG_TIDY "Enable running clang-tidy as part of the build" OFF)

enable_testing()

# Define the include directory
include_directories(${CMAKE_SOURCE_DIR}/include)
add_subdirectory(source)
add_subdirectory(tests)
add_subdirectory(mocks)

set(CMAKE_CXX_FLAGS ${DEBUG_MAIN_FLAGS})

add_executable(main main.cpp)

target_include_directories(main PRIVATE ${CMAKE_SOURCE_DIR}/include)
target_link_libraries(main PRIVATE work_lib)

# add custom target to run clang-tidy like tidy_target
enable_clang_tidy(main)

if(ENABLE_CLANG_TIDY)
    add_dependencies(main tidy_main)
endif()
