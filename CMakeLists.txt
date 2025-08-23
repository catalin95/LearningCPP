cmake_minimum_required(VERSION 3.30.8)

include(${CMAKE_SOURCE_DIR}/cmake_utils/cmake_functions/StaticAnalyzersFunctions.cmake)
include(${CMAKE_SOURCE_DIR}/cmake_utils/cmake_functions/UtilityFunctions.cmake)

recommend_ninja_if_available()
set_default_cxx_compiler_if_needed()

project(Learning VERSION 1.0 LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 23)
set(MainProgram app)
set(CMAKE_BUILD_TYPE Debug)

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

set(CMAKE_CXX_FLAGS ${DEBUG_MAIN_FLAGS})

add_executable(${MainProgram} ${MainProgram}.cpp)

target_include_directories(${MainProgram}  PRIVATE ${CMAKE_SOURCE_DIR}/include)
target_link_libraries(${MainProgram}  PRIVATE work_lib)
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
