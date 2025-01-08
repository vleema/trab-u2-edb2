# Adicionar o teste como executável
add_executable(BinaryTreeTests tests.cpp)

# Linkar o Google Test e Google Mock ao executável
target_link_libraries(BinaryTreeTests PRIVATE gtest gmock gtest_main)

# Adicionar o teste à suíte de testes do CMake
add_test(NAME BinaryTreeTests COMMAND BinaryTreeTests)
