
add_library(work_lib_obj OBJECT work.cpp)
target_compile_options(work_lib_obj PUBLIC
    $<$<CONFIG:Debug>:-fprofile-instr-generate -fcoverage-mapping -fno-inline>
    $<$<COMPILE_LANGUAGE:CXX>:${SANITIZER_FLAGS} -pthread>
)
set_target_properties(work_lib_obj PROPERTIES CXX_ENABLE_MODULES ON)
target_include_directories(work_lib_obj PUBLIC ${CMAKE_SOURCE_DIR}/include)

