
# Justfile

BUILD_DIR := "build"

clean BUILD_DIR=BUILD_DIR:
    if [ -d "{{BUILD_DIR}}" ]; then \
        echo "Removing build directory: {{BUILD_DIR}}"; \
        rm -rf "{{BUILD_DIR}}"; \
        echo "Creating build directory: {{BUILD_DIR}}"; \
        mkdir -p "{{BUILD_DIR}}"; \
        echo "Done. You can now run 'cmake ..' inside {{BUILD_DIR}} or 'cmake --build {{BUILD_DIR}} ...'"; \
    else \
        echo "Build directory does not exist"; \
    fi
