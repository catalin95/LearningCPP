function(enable_coverage tests)
    if(APPLE)
        message(STATUS "Configuring coverage for Apple/Clang...")
        get_filename_component(COMPILER_PATH ${CMAKE_CXX_COMPILER} REALPATH)
        if(COMPILER_PATH MATCHES ".*/usr/bin/clang\\+\\+$")
            set(LLVM_PROFDATA "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/llvm-profdata")
            set(LLVM_COV "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/llvm-cov")
        else()
            find_program(LLVM_PROFDATA llvm-profdata REQUIRED)
            find_program(LLVM_COV llvm-cov REQUIRED)
        endif()
    elseif(UNIX)
        message(STATUS "Configuring coverage for generic Unix...")
        find_program(LLVM_PROFDATA llvm-profdata REQUIRED)
        find_program(LLVM_COV llvm-cov REQUIRED)
    else()
        message(FATAL_ERROR "Coverage not supported on this platform")
    endif()

    message(STATUS "Using llvm-profdata: ${LLVM_PROFDATA}")
    message(STATUS "Using llvm-cov: ${LLVM_COV}")

    # Ensure coverage flags are set in debug-type builds
    if(CMAKE_BUILD_TYPE MATCHES "Debug|RelWithDebInfo|MinSizeRel")
        message(STATUS "Enabling Clang coverage flags")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-instr-generate -fcoverage-mapping -fno-inline" PARENT_SCOPE)
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fprofile-instr-generate -fcoverage-mapping" PARENT_SCOPE)
    endif()

    # Custom target to run tests and generate coverage
    add_custom_target(coverage
        COMMAND ${CMAKE_COMMAND} -E env LLVM_PROFILE_FILE=${CMAKE_BINARY_DIR}/default-%p.profraw $<TARGET_FILE:app_tests>
        COMMAND ${LLVM_PROFDATA} merge -sparse ${CMAKE_BINARY_DIR}/default-*.profraw -o ${CMAKE_BINARY_DIR}/default.profdata
        COMMAND ${LLVM_COV} show
            --format=html
            --instr-profile=${CMAKE_BINARY_DIR}/default.profdata
            -o ${CMAKE_BINARY_DIR}/coverage_report
            $<TARGET_FILE:app_tests>
            --ignore-filename-regex='/usr/.*|.*tests?.*.cpp'
            --use-color
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        COMMENT "Generating code coverage report using LLVM tools"
    )

endfunction()
