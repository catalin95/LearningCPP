# Build work.ixx as an OBJECT library with coverage flags
add_library(work_module OBJECT)
target_sources(work_module
    PUBLIC FILE_SET CXX_MODULES FILES work.ixx
)
target_include_directories(work_module PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_compile_options(work_module PUBLIC
    $<$<COMPILE_LANGUAGE:CXX>:${SANITIZER_FLAGS} -pthread>
    $<$<CONFIG:Debug>:-fprofile-instr-generate -fcoverage-mapping -fno-inline>
)

add_library(work2_module OBJECT)
target_sources(work2_module
    PUBLIC FILE_SET CXX_MODULES FILES work2.ixx
)
target_include_directories(work2_module PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_compile_options(work2_module PUBLIC
    $<$<COMPILE_LANGUAGE:CXX>:${SANITIZER_FLAGS} -pthread>
    $<$<CONFIG:Debug>:-fprofile-instr-generate -fcoverage-mapping -fno-inline>
)