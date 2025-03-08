set(DEBUG_MAIN_FLAGS "-O0 \
-g \
-ggdb \
-Wall \
-Wextra \
-Wpedantic \
-fsanitize=address \
-fsanitize=leak \
-fsanitize=undefined \
-fprofile-instr-generate \
-fcoverage-mapping")

set(DEBUG_UT_FLAGS "-O0 \
-g \
-ggdb \
-Wall \
-Wextra \
-Wpedantic \
-ftest-coverage \
-fsanitize=address \
-fsanitize=leak \
-fsanitize=undefined")
