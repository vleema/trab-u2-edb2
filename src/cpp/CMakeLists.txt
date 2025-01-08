cmake_minimum_required(VERSION 3.10)

# Nome do projeto
project(BinaryTree)

# Habilitar testes
enable_testing()

# Adicionar diretório do Google Test
add_subdirectory(googletest)

# Adicionar o executável principal
add_executable(BinaryTree src/main.cpp)

# Adicionar testes
add_subdirectory(tests)
