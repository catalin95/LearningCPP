
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
            print("Checking system packages for Linux...")
            installer = self._get_linux_installer()

            # Check for GTest
            if not os.path.exists("/usr/include/gtest/gtest.h"):
                print("Installing libgtest-dev...")
                installer.install(["libgtest-dev"])

            # Check for Boost
            if not os.path.exists("/usr/include/boost/version.hpp"):
                print("Installing libboost-all-dev...")
                installer.install(["libboost-all-dev"])

        elif self.settings.os == "Macos":
            print("Checking system packages for macOS...")
            installer = self._get_macos_installer()

            # Check for GTest
            if not os.path.exists("/usr/local/include/gtest/gtest.h") and \
               not os.path.exists("/opt/homebrew/include/gtest/gtest.h"):
                print("Installing googletest via Homebrew...")
                installer.install(["googletest"])

            # Check for Boost
            if not os.path.exists("/usr/local/include/boost/version.hpp") and \
               not os.path.exists("/opt/homebrew/include/boost/version.hpp"):
                print("Installing boost via Homebrew...")
                installer.install(["boost"])

    def _get_linux_installer(self):
        from conan.tools.system.package_manager import Apt
        return Apt(self)

    def _get_macos_installer(self):
        from conan.tools.system.package_manager import Brew
        return Brew(self)
