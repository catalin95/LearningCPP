cmake_minimum_required(VERSION 3.30.8)
project(Learning VERSION 1.0 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 23)
set(MainProgram main)

include(${CMAKE_SOURCE_DIR}/cmake_utils/cmake_config/CompilerFlags.cmake)

# Define the include directory
include_directories(${CMAKE_SOURCE_DIR}/include)
add_subdirectory(source)
add_subdirectory(tests)
add_subdirectory(mocks)

set(CMAKE_CXX_FLAGS ${DEBUG_MAIN_FLAGS})

add_executable(main
    main.cpp
)
target_include_directories(main PRIVATE ${CMAKE_SOURCE_DIR}/include)
target_link_libraries(main PRIVATE work_lib)
