# modules/CMakeLists.txt
add_library(math_module OBJECT)
target_sources(math_module
    PUBLIC FILE_SET CXX_MODULES FILES math.ixx
)
target_include_directories(math_module PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# Make sure math_module sees the same compile flags as the consumer
target_compile_options(math_module PUBLIC
    $<$<COMPILE_LANGUAGE:CXX>:${SANITIZER_FLAGS} -pthread>
)


