# function(enable_coverage tests)

#     # use uncommented code if you want to use coverage from apple
#     # set(LLVM_PROFDATA "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/llvm-profdata")
#     # set(LLVM_COV "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/llvm-cov")

#     if(CMAKE_BUILD_TYPE MATCHES "Debug|RelWithDebInfo|MinSizeRel")
#         message(STATUS "Enabling Clang coverage flags")
#         set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-instr-generate -fcoverage-mapping -fno-inline" PARENT_SCOPE)
#         set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fprofile-instr-generate -fcoverage-mapping" PARENT_SCOPE)
#     endif()

#     add_custom_target(coverage
#         COMMAND ${CMAKE_COMMAND} -E env LLVM_PROFILE_FILE=${CMAKE_BINARY_DIR}/default.profraw $<TARGET_FILE:${tests}>
#         COMMAND llvm-profdata merge -sparse ${CMAKE_BINARY_DIR}/default.profraw -o ${CMAKE_BINARY_DIR}/default.profdata
#         COMMAND llvm-cov show --format=html --instr-profile=${CMAKE_BINARY_DIR}/default.profdata -o ${CMAKE_BINARY_DIR}/coverage_report $<TARGET_FILE:${tests}> --ignore-filename-regex '/usr/*' --use-color
#         # COMMAND ${LLVM_PROFDATA} merge -sparse ${CMAKE_BINARY_DIR}/default.profraw -o ${CMAKE_BINARY_DIR}/default.profdata
#         # COMMAND ${LLVM_COV} show --format=html --instr-profile=${CMAKE_BINARY_DIR}/default.profdata -o ${CMAKE_BINARY_DIR}/coverage_report $<TARGET_FILE:${tests}> --ignore-filename-regex '/usr/*' --use-color
#         WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
#         COMMENT "Generating code coverage report using LLVM tools"
#     )
# endfunction()

# function(enable_coverage tests)
#     # Determine llvm-profdata and llvm-cov executables
#     find_program(LLVM_PROFDATA llvm-profdata)
#     find_program(LLVM_COV llvm-cov)

#     if(NOT LLVM_PROFDATA)
#         # fallback to Xcode toolchain paths
#         set(LLVM_PROFDATA "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/llvm-profdata")
#     endif()

#     if(NOT LLVM_COV)
#         set(LLVM_COV "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/llvm-cov")
#     endif()

#     message(STATUS "Using llvm-profdata: ${LLVM_PROFDATA}")
#     message(STATUS "Using llvm-cov: ${LLVM_COV}")

#     if(CMAKE_BUILD_TYPE MATCHES "Debug|RelWithDebInfo|MinSizeRel")
#         message(STATUS "Enabling Clang coverage flags")
#         set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-instr-generate -fcoverage-mapping -fno-inline" PARENT_SCOPE)
#         set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fprofile-instr-generate -fcoverage-mapping" PARENT_SCOPE)
#     endif()

#     add_custom_target(coverage
#         COMMAND ${CMAKE_COMMAND} -E env LLVM_PROFILE_FILE=${CMAKE_BINARY_DIR}/default.profraw $<TARGET_FILE:${tests}>
#         COMMAND ${LLVM_PROFDATA} merge -sparse ${CMAKE_BINARY_DIR}/default.profraw -o ${CMAKE_BINARY_DIR}/default.profdata
#         COMMAND ${LLVM_COV} show --format=html --instr-profile=${CMAKE_BINARY_DIR}/default.profdata -o ${CMAKE_BINARY_DIR}/coverage_report $<TARGET_FILE:${tests}> --ignore-filename-regex '/usr/*' --use-color
#         WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
#         COMMENT "Generating code coverage report using LLVM tools"
#     )
# endfunction()

function(enable_coverage tests)
    # Determine compiler path
    get_filename_component(COMPILER_PATH ${CMAKE_CXX_COMPILER} REALPATH)

    if(COMPILER_PATH MATCHES ".*/usr/bin/clang\\+\\+$")
        # Apple Xcode LLVM
        set(LLVM_PROFDATA "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/llvm-profdata")
        set(LLVM_COV "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/llvm-cov")
    else()
        # Try to find in PATH as fallback
        find_program(LLVM_PROFDATA llvm-profdata)
        find_program(LLVM_COV llvm-cov)
    endif()

    message(STATUS "Using llvm-profdata: ${LLVM_PROFDATA}")
    message(STATUS "Using llvm-cov: ${LLVM_COV}")

    if(CMAKE_BUILD_TYPE MATCHES "Debug|RelWithDebInfo|MinSizeRel")
        message(STATUS "Enabling Clang coverage flags")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-instr-generate -fcoverage-mapping -fno-inline" PARENT_SCOPE)
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fprofile-instr-generate -fcoverage-mapping" PARENT_SCOPE)
    endif()

    add_custom_target(coverage
        COMMAND ${CMAKE_COMMAND} -E env LLVM_PROFILE_FILE=${CMAKE_BINARY_DIR}/default.profraw $<TARGET_FILE:${tests}>
        COMMAND ${LLVM_PROFDATA} merge -sparse ${CMAKE_BINARY_DIR}/default.profraw -o ${CMAKE_BINARY_DIR}/default.profdata
        COMMAND ${LLVM_COV} show --format=html --instr-profile=${CMAKE_BINARY_DIR}/default.profdata -o ${CMAKE_BINARY_DIR}/coverage_report $<TARGET_FILE:${tests}> --ignore-filename-regex '/usr/*' --use-color
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        COMMENT "Generating code coverage report using LLVM tools"
    )
endfunction()
