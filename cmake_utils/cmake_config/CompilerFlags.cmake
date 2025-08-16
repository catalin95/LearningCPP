set(DEBUG_CLANG_FLAGS "-O0 \
-g \
-Wall \
-Wextra \
-Wpedantic \
-Wconversion \
-Wshadow \
-Wcast-qual \
-Wnon-virtual-dtor \
-Wold-style-cast \
-Woverloaded-virtual \
-Wzero-as-null-pointer-constant \
-Wfloat-equal \
-fsanitize=address \
-fsanitize=undefined \
-fprofile-instr-generate \
-fcoverage-mapping")

set(DEBUG_GCC_FLAGS "-O0 \
-g \
-Wall \
-Wextra \
-Wpedantic \
-Wconversion \
-Wshadow \
-Wcast-qual \
-Wnon-virtual-dtor \
-Wold-style-cast \
-Woverloaded-virtual \
-Wzero-as-null-pointer-constant \
-fsanitize=address \
-fsanitize=leak \
-fsanitize=undefined \
-fprofile-arcs \
-ftest-coverage")

set(DEBUG_MSVC_FLAGS "/Od \
/Zi \
/W4 \
/permissive-")
