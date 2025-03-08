set(LIB_SOURCES work.cpp)
add_library(work_lib STATIC ${LIB_SOURCES})
target_include_directories(work_lib PUBLIC ${CMAKE_SOURCE_DIR}/include)
