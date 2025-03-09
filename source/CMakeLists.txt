set(LIB_SOURCES work.cpp)
# add_library(work_lib STATIC ${LIB_SOURCES}) # this was a static lib
add_library(work_lib SHARED ${LIB_SOURCES}) # this is a shared lib now
target_include_directories(work_lib PUBLIC ${CMAKE_SOURCE_DIR}/include)
