import os
import platform
from pathlib import Path
from functools import partial
from test.examples_tools import run


def main():
    print("libcurl and stb example")

    # Tipo de build (Release por padrão, pode usar: export BUILD_TYPE=Debug)
    build_type = os.getenv("BUILD_TYPE", "Release")

    # Ambiente extra (Linux apenas)
    extra_env = {}
    if platform.system() == "Linux":
        extra_env["PKG_CONFIG_PATH"] = "/usr/lib/x86_64-linux-gnu/pkgconfig"

    runner = partial(run, extra_env=extra_env)

    # Pastas de build
    build_root = Path("build")
    build_dir = build_root / "build" / build_type
    toolchain_file = build_dir / "generators" / "conan_toolchain.cmake"

    # 1) Conan install
    runner(
        f"conan install . "
        f"--output-folder={build_root} "
        f"--build=missing "
        f"-s build_type={build_type}"
    )

    # 2) CMake configure
    runner(
        f"cmake -S . -B {build_dir} "
        f"-DCMAKE_TOOLCHAIN_FILE={toolchain_file} "
        f"-DCMAKE_BUILD_TYPE={build_type} "
        f"-DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
    )

    # 3) CMake build
    # --config é ignorado pelo Makefile/Yarn Ninja, mas OK
    runner(
        f"cmake --build {build_dir} --config {build_type}"
    )


if __name__ == "__main__":
    main()
