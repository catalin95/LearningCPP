cmake_minimum_required(VERSION 3.30.8)

include(${CMAKE_SOURCE_DIR}/cmake_utils/cmake_functions/StaticAnalyzersFunctions.cmake)
include(${CMAKE_SOURCE_DIR}/cmake_utils/cmake_functions/UtilityFunctions.cmake)

recommend_ninja_if_available()
set_default_cxx_compiler_if_needed()

project(Learning VERSION 1.0 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(MainProgram app)
set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_EXE_LINKER_FLAGS "" CACHE STRING "Linker flags" FORCE)

# Enable module support
set(CMAKE_EXPERIMENTAL_CXX_MODULE_CMAKE_API 1)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE BOOL "Generate compile_commands.json" FORCE)

# Option to enable clang-tidy dependency
option(ENABLE_CLANG_TIDY "Enable running clang-tidy as part of the build" OFF)
option(ENABLE_CPPCHECK "Enable running cppcheck as part of the build" OFF)
option(ENABLE_IWYU "Enable running iwyu as part of the build" OFF)

enable_testing()

# Define the include directory
include_directories(${CMAKE_SOURCE_DIR}/include)
add_subdirectory(source)
add_subdirectory(tests)
add_subdirectory(mocks)
add_subdirectory(modules)

set(CMAKE_CXX_FLAGS ${DEBUG_MAIN_FLAGS})

# set(CMAKE_CXX_CLANG_TIDY "clang-tidy;-checks=*;-header-filter=.*;--system-headers")

add_executable(${MainProgram} ${MainProgram}.cpp)

target_include_directories(${MainProgram}  PRIVATE ${CMAKE_SOURCE_DIR}/include)
# target_link_libraries(${MainProgram}  PRIVATE work_lib)
#target_sources(${MainProgram} PRIVATE $<TARGET_OBJECTS:work_module>)
#target_sources(${MainProgram} PRIVATE $<TARGET_OBJECTS:work2_module>)
target_sources(${MainProgram} PRIVATE $<TARGET_OBJECTS:work_lib_obj>)
# target_link_libraries(${MainProgram} PRIVATE work_lib_obj)
set_target_flags(${MainProgram}  ${CMAKE_BUILD_TYPE})

# add custom target to run clang-tidy like tidy_target
enable_clang_tidy(${MainProgram})
enable_cppcheck(${MainProgram})
enable_iwyu(${MainProgram} ${CMAKE_SOURCE_DIR})

if(ENABLE_CLANG_TIDY)
    add_dependencies(${MainProgram} tidy_${MainProgram})
endif()

if(ENABLE_CPPCHECK)
    add_dependencies(${MainProgram} cppcheck_${MainProgram})
endif()

if(ENABLE_IWYU)
    add_dependencies(${MainProgram} iwyu_${MainProgram})
endif()

# Collect all project sources (example: src/ + include/)
file(GLOB_RECURSE ALL_SOURCE_FILES
    ${CMAKE_SOURCE_DIR}/app.cpp
    ${CMAKE_SOURCE_DIR}/src/*.cpp
    ${CMAKE_SOURCE_DIR}/include/*.hpp
    ${CMAKE_SOURCE_DIR}/mocks/*.hpp
    ${CMAKE_SOURCE_DIR}/tests/*.cpp
)

# Target to format all files
add_clang_format(format FORMAT FILES ${ALL_SOURCE_FILES})

# Target to check formatting
add_clang_format(format-check CHECK FILES ${ALL_SOURCE_FILES})
