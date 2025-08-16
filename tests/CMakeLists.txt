# include(${CMAKE_SOURCE_DIR}/cmake_utils/cmake_config/CompilerFlags.cmake)
include(${CMAKE_SOURCE_DIR}/cmake_utils/cmake_functions/CoverageFunctions.cmake)
include(${CMAKE_SOURCE_DIR}/cmake_utils/cmake_functions/UtilityFunctions.cmake)

set_compiler_flags_uts()

# Set the CMake package search path for Google Test
list(APPEND CMAKE_PREFIX_PATH "/usr/local/lib/cmake/GTest")

set(CMAKE_BUILD_TYPE Debug)

# Find Google Test package
find_package(GTest REQUIRED)

# Set source files and the target name
set(TEST_SOURCES tests.cpp ${CMAKE_SOURCE_DIR}/source/work.cpp)
set(This tests)

# Set CMake flags (you may already have specific debug flags for unit tests here)
set(CMAKE_CXX_FLAGS ${DEBUG_UT_FLAGS})

# Ensure that pthread is linked for the test target
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")

# Create the executable for tests
add_executable(tests ${TEST_SOURCES})

# Link the necessary libraries to the tests executable
target_link_libraries(tests
  PRIVATE
    GTest::gtest
    GTest::gmock
    GTest::gtest_main
    pthread
)

# Include necessary directories for the tests
target_include_directories(tests PRIVATE ${CMAKE_SOURCE_DIR}/include
                          ${CMAKE_SOURCE_DIR}/mocks)

# # Enable testing
# enable_testing()

# Add the test command to CTest
add_test(NAME UnitTests COMMAND tests)

enable_coverage(${This})
enable_clang_tidy(${This})
enable_cppcheck(${This})

if(ENABLE_CLANG_TIDY)
    add_dependencies(${This} tidy_${This})
endif()

if(ENABLE_CPPCHECK)
    add_dependencies(${This} cppcheck_${This})
endif()
