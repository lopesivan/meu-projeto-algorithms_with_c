cmake_minimum_required(VERSION 3.15)
project(meu_projeto C)

# Encontra o pacote algorithms_with_c
find_package(algorithms_with_c REQUIRED)

# Define os caminhos base do pacote
if(DEFINED algorithms_with_c_PACKAGE_FOLDER_RELEASE)
    set(ALG_BASE "${algorithms_with_c_PACKAGE_FOLDER_RELEASE}")
else()
    set(ALG_BASE "${algorithms_with_c_PACKAGE_FOLDER}")
endif()

# Define os diretórios de include e source
set(ALG_INCLUDE "${ALG_BASE}/include")
set(ALG_SRC "${ALG_BASE}/src")

# Adiciona o executável - escolha apenas os .c que você precisa
add_executable(meu_app
    main.c
    ${ALG_SRC}/list.c
    # ${ALG_SRC}/queue.c   # Descomente se precisar
    # ${ALG_SRC}/stack.c   # Descomente se precisar
)

# Adiciona os includes
target_include_directories(meu_app PRIVATE ${ALG_INCLUDE})
