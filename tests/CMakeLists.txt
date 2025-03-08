include(${CMAKE_SOURCE_DIR}/cmake_utils/cmake_config/CompilerFlags.cmake)

set(TEST_SOURCES tests.cpp)

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
