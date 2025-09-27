# modules/CMakeLists.txt
add_library(work_module OBJECT)
target_sources(work_module
    PUBLIC FILE_SET CXX_MODULES FILES work.ixx
)
target_include_directories(work_module PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# Make sure work_module sees the same compile flags as the consumer
target_compile_options(work_module PUBLIC
    $<$<COMPILE_LANGUAGE:CXX>:${SANITIZER_FLAGS} -pthread>
    $<$<CONFIG:Debug>:-fprofile-instr-generate -fcoverage-mapping -fno-inline>
)



