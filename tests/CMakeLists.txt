include(${CMAKE_SOURCE_DIR}/cmake_utils/cmake_functions/CoverageFunctions.cmake)
include(${CMAKE_SOURCE_DIR}/cmake_utils/cmake_functions/UtilityFunctions.cmake)

# Set the CMake package search path for Google Test
# list(APPEND CMAKE_PREFIX_PATH "/usr/local/lib/cmake/GTest")

# Find Google Test package
find_package(GTest REQUIRED)

# Set source files and the target name
set(MainProgramTests app_tests)
set(TEST_SOURCES ${MainProgramTests}.cpp) # TODO: fix this, link it, not build from it

# Set CMake flags (you may already have specific debug flags for unit tests here)
set(CMAKE_CXX_FLAGS ${DEBUG_UT_FLAGS})

# Ensure that pthread is linked for the test target
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")

# Create the executable for tests
add_executable(${MainProgramTests} ${TEST_SOURCES})

# Link the necessary libraries to the tests executable
target_link_libraries(${MainProgramTests}
  PRIVATE
    # work_lib_obj
    GTest::gtest
    GTest::gmock
    GTest::gtest_main
    pthread
)
# Link the OBJECT files into the test executable
#target_sources(${MainProgramTests} PRIVATE $<TARGET_OBJECTS:work_module>)
#target_sources(${MainProgramTests} PRIVATE $<TARGET_OBJECTS:work2_module>)
target_sources(${MainProgramTests} PRIVATE $<TARGET_OBJECTS:work_lib_obj>)

# Include necessary directories for the tests
target_include_directories(${MainProgramTests} PRIVATE ${CMAKE_SOURCE_DIR}/include
                          ${CMAKE_SOURCE_DIR}/mocks)

set_target_flags(${MainProgramTests} ${CMAKE_BUILD_TYPE})

# Add the test command to CTest
add_test(NAME UnitTests COMMAND ${MainProgramTests})

enable_coverage(${MainProgramTests})
enable_clang_tidy(${MainProgramTests})
enable_cppcheck(${MainProgramTests})
enable_iwyu(${MainProgramTests} ${CMAKE_SOURCE_DIR}/tests)

if(ENABLE_CLANG_TIDY)
    add_dependencies(${MainProgramTests} tidy_${MainProgramTests})
endif()

if(ENABLE_CPPCHECK)
    add_dependencies(${MainProgramTests} cppcheck_${MainProgramTests})
endif()

if(ENABLE_IWYU)
    add_dependencies(${MainProgramTests} iwyu_${MainProgramTests})
endif()
