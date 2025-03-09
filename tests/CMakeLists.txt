include(${CMAKE_SOURCE_DIR}/cmake_utils/cmake_config/CompilerFlags.cmake)
include(${CMAKE_SOURCE_DIR}/cmake_utils/cmake_functions/CoverageFunctions.cmake)

set(TEST_SOURCES tests.cpp)
set(This tests)

set(CMAKE_CXX_FLAGS ${DEBUG_UT_FLAGS})

find_package(GTest REQUIRED)
add_executable(tests ${TEST_SOURCES})
target_link_libraries(tests
  PRIVATE
    work_lib
    GTest::gtest
    GTest::gmock
    GTest::gtest_main
)
target_include_directories(tests PRIVATE ${CMAKE_SOURCE_DIR}/include)

enable_testing()
add_test(NAME UnitTests COMMAND tests)


# if(CMAKE_BUILD_TYPE MATCHES "Debug|RelWithDebInfo|MinSizeRel")
#     message(STATUS "Enabling Clang coverage flags")

#     # Add Clang coverage flags to generate coverage data
#     set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-instr-generate -fcoverage-mapping")
#     set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fprofile-instr-generate -fcoverage-mapping")

#     # Optional: Disable inlining for better coverage accuracy
#     set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-inline")
# endif()

# add_custom_target(coverage
#     # Step 1: Run the tests to generate the .profraw file
#     COMMAND ${CMAKE_COMMAND} -E env LLVM_PROFILE_FILE=${CMAKE_BINARY_DIR}/default.profraw $<TARGET_FILE:${This}>
#     # Step 2: Merge the profile data into .profdata
#     COMMAND llvm-profdata merge -sparse ${CMAKE_BINARY_DIR}/default.profraw -o ${CMAKE_BINARY_DIR}/default.profdata
#     # Step 3: Generate the HTML coverage report (use the full test executable for coverage data)
#     COMMAND llvm-cov show --format=html --instr-profile=${CMAKE_BINARY_DIR}/default.profdata -o ${CMAKE_BINARY_DIR}/coverage_report $<TARGET_FILE:${Program}> --ignore-filename-regex '/usr/*' --use-color
#     WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
#     COMMENT "Generating code coverage report using LLVM tools"
# )

enable_coverage(${This})