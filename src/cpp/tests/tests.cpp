#include <gtest/gtest.h>
#include "../src/main.cpp" 

TEST(ArvoreBinaria, InsercaoEBusca) {
    no* raiz = nullptr;

    // Insere elementos
    raiz = inserir(raiz, 50);
    raiz = inserir(raiz, 30);
    raiz = inserir(raiz, 10);
    raiz = inserir(raiz, 40);
    raiz = inserir(raiz, 60);

    // Verifica se os elementos estão presentes
    EXPECT_NE(busca(raiz, 50), nullptr);
    EXPECT_NE(busca(raiz, 30), nullptr);
    EXPECT_EQ(busca(raiz, 25), nullptr); // Não deve existir

    // Verifica busca iterativa
    EXPECT_EQ(busca_iterativa(raiz, 10)->chave, 10);
    EXPECT_EQ(busca_iterativa(raiz, 40)->chave, 40);
}

TEST(ArvoreBinaria, Remocao) {
    no* raiz = nullptr;

    // Insere elementos
    raiz = inserir(raiz, 50);
    raiz = inserir(raiz, 30);
    raiz = inserir(raiz, 10);
    raiz = inserir(raiz, 40);
    raiz = inserir(raiz, 60);

    // Remove elemento folha
    raiz = remover(raiz, 10);
    EXPECT_EQ(busca(raiz, 10), nullptr);

    // Remove nó com um filho
    raiz = remover(raiz, 30);
    EXPECT_EQ(busca(raiz, 30), nullptr);

    // Remove nó com dois filhos
    raiz = remover(raiz, 50);
    EXPECT_EQ(busca(raiz, 50), nullptr);
}

TEST(ArvoreBinaria, Traversal) {
    no* raiz = nullptr;

    // Insere elementos
    raiz = inserir(raiz, 50);
    raiz = inserir(raiz, 30);
    raiz = inserir(raiz, 10);
    raiz = inserir(raiz, 40);
    raiz = inserir(raiz, 60);

    // Testa ordem simétrica
    testing::internal::CaptureStdout();
    ordem_simetrica(raiz);
    std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(output, "10\n30\n40\n50\n60\n");

    // Testa pré-ordem
    testing::internal::CaptureStdout();
    pre_ordem(raiz);
    output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(output, "50\n30\n10\n40\n60\n");
}

// int main(int argc, char **argv) {
//     ::testing::InitGoogleTest(&argc, argv);
//     return RUN_ALL_TESTS();
// }
