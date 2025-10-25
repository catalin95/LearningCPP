
# Justfile

BUILD_DIR := "build"
TESTS := "tests"
PROFILE := "brew-clang"
BUILD_TYPE := "Debug"
PRESET_TYPE := "debug"

configure BUILD_TYPE=BUILD_TYPE PROFILE=PROFILE:
    conan install . --profile {{PROFILE}} --build=missing -s build_type={{BUILD_TYPE}}

generate PRESET_TYPE=PRESET_TYPE:
    cmake --preset conan-{{PRESET_TYPE}}

build TARGET BUILD_TYPE=BUILD_TYPE BUILD_DIR=BUILD_DIR:
    cmake --build {{BUILD_DIR}}/{{BUILD_TYPE}} --target {{TARGET}}

run TARGET BUILD_TYPE=BUILD_TYPE BUILD_DIR=BUILD_DIR:
    if echo "{{TARGET}}" | rg -q "tests"; then \
        ./{{BUILD_DIR}}/{{BUILD_TYPE}}/{{TESTS}}/{{TARGET}}; \
    else \
    ./{{BUILD_DIR}}/{{BUILD_TYPE}}/{{TARGET}}; \
    fi

# clean BUILD_DIR=BUILD_DIR:
#     if [ -d "{{BUILD_DIR}}" ]; then \
#         echo "Removing build directory: {{BUILD_DIR}}"; \
#         rm -rf "{{BUILD_DIR}}"; \
#         echo "Creating build directory: {{BUILD_DIR}}"; \
#         mkdir -p "{{BUILD_DIR}}"; \
#         echo "Done. You can now run 'cmake ..' inside {{BUILD_DIR}} or 'cmake -B {{BUILD_DIR}} ...'"; \
#     else \
#         echo "Build directory '{{BUILD_DIR}}' does not exist"; \
#     fi

clean BUILD_DIR=BUILD_DIR:
    if [ -d "{{BUILD_DIR}}" ]; then \
        echo "Removing build directory: {{BUILD_DIR}}"; \
        rm -rf "{{BUILD_DIR}}"; \
        echo "Done removing build directory! Use configure to regenerate build files"; \
    else \
        echo "Build directory '{{BUILD_DIR}}' does not exist"; \
    fi

