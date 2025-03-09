function(enable_coverage tests)
    if(CMAKE_BUILD_TYPE MATCHES "Debug|RelWithDebInfo|MinSizeRel")
        message(STATUS "Enabling Clang coverage flags")

        # Apply coverage flags globally using PARENT_SCOPE
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-instr-generate -fcoverage-mapping -fno-inline" PARENT_SCOPE)
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fprofile-instr-generate -fcoverage-mapping" PARENT_SCOPE)
    endif()

    add_custom_target(coverage
        COMMAND ${CMAKE_COMMAND} -E env LLVM_PROFILE_FILE=${CMAKE_BINARY_DIR}/default.profraw $<TARGET_FILE:${tests}>
        COMMAND llvm-profdata merge -sparse ${CMAKE_BINARY_DIR}/default.profraw -o ${CMAKE_BINARY_DIR}/default.profdata
        COMMAND llvm-cov show --format=html --instr-profile=${CMAKE_BINARY_DIR}/default.profdata -o ${CMAKE_BINARY_DIR}/coverage_report $<TARGET_FILE:${tests}> --ignore-filename-regex '/usr/*' --use-color
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        COMMENT "Generating code coverage report using LLVM tools"
    )
endfunction()
