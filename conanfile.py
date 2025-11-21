from conan import ConanFile
from conan.tools.cmake import CMake, cmake_layout

class MeuProjetoConan(ConanFile):
    settings = "os", "compiler", "build_type", "arch"
    generators = "CMakeDeps", "CMakeToolchain"
    
    def requirements(self):
        self.requires("algorithms_with_c/1.0.0@ivancarlos/stable")
    
    def layout(self):
        cmake_layout(self)

