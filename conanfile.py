
from conan import ConanFile
from conan.tools.cmake import cmake_layout
import os

class MyProjectConan(ConanFile):
    name = "Learning"
    version = "1.0"
    settings = "os", "compiler", "build_type", "arch"
    generators = "CMakeDeps", "CMakeToolchain"

    def layout(self):
        cmake_layout(self)

    def system_requirements(self):
        """
        Install system packages only if not already installed.
        """
        if self.settings.os == "Linux":
            # Check if gtest is installed
            if not os.path.exists("/usr/include/gtest/gtest.h"):
                # Install system package
                installer = self._get_linux_installer()
                installer.install("libgtest-dev")  # apt
        # You could add clang-tidy, cppcheck, iwyu similarly

    def _get_linux_installer(self):
        from conan.tools.system.package_manager import Apt
        return Apt(self)
