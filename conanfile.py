from conan import ConanFile
from conan.tools.cmake import CMake, cmake_layout

class MeuProjetoConan(ConanFile):
    name = "meu_projeto"
    version = "0.1.0"
    
    settings = "os", "compiler", "build_type", "arch"
    generators = "CMakeDeps", "CMakeToolchain"
    
    def requirements(self):
        self.requires("algorithms_with_c/1.0.0@ivancarlos/stable")
        # self.requires("outro_pacote/1.0.0")  # Adicione mais se precisar
    
    def layout(self):
        cmake_layout(self)
    
    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

