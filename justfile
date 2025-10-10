
# Justfile

BUILD_DIR := "build"
TESTS_BUILD_DIR := "build/tests/"

configure BUILD_DIR=BUILD_DIR:
    cmake -G Ninja -B "{{BUILD_DIR}}" -S .

build TARGET BUILD_DIR=BUILD_DIR:
    cmake --build "{{BUILD_DIR}}" --target "{{TARGET}}"

run TARGET  BUILD_DIR=BUILD_DIR:
    if echo "{{TARGET}}" | rg -q "tests"; then \
        ./"{{TESTS_BUILD_DIR}}"/"{{TARGET}}"; \
    else \
    ./"{{BUILD_DIR}}"/"{{TARGET}}"; \
    fi

clean BUILD_DIR=BUILD_DIR:
    if [ -d "{{BUILD_DIR}}" ]; then \
        echo "Removing build directory: {{BUILD_DIR}}"; \
        rm -rf "{{BUILD_DIR}}"; \
        echo "Creating build directory: {{BUILD_DIR}}"; \
        mkdir -p "{{BUILD_DIR}}"; \
        echo "Done. You can now run 'cmake ..' inside {{BUILD_DIR}} or 'cmake -B {{BUILD_DIR}} ...'"; \
    else \
        echo "Build directory '{{BUILD_DIR}}' does not exist"; \
    fi

