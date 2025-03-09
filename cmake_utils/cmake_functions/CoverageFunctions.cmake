function(enable_coverage program)
    if(CMAKE_BUILD_TYPE MATCHES "Debug|RelWithDebInfo|MinSizeRel")
        message(STATUS "Enabling Clang coverage flags")

        # Apply coverage flags globally using PARENT_SCOPE
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-instr-generate -fcoverage-mapping -fno-inline" PARENT_SCOPE)
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fprofile-instr-generate -fcoverage-mapping" PARENT_SCOPE)
    endif()

    add_custom_target(coverage
        # Step 1: Run the tests to generate the .profraw file
        COMMAND ${CMAKE_COMMAND} -E env LLVM_PROFILE_FILE=${CMAKE_BINARY_DIR}/default.profraw $<TARGET_FILE:${program}>
        # Step 2: Merge the profile data into .profdata
        COMMAND llvm-profdata merge -sparse ${CMAKE_BINARY_DIR}/default.profraw -o ${CMAKE_BINARY_DIR}/default.profdata
        # Step 3: Generate the HTML coverage report (use the full test executable for coverage data)
        COMMAND llvm-cov show --format=html --instr-profile=${CMAKE_BINARY_DIR}/default.profdata -o ${CMAKE_BINARY_DIR}/coverage_report $<TARGET_FILE:${Program}> --ignore-filename-regex '/usr/*' --use-color
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        COMMENT "Generating code coverage report using LLVM tools"
    )
endfunction()
