#include <gtest/gtest.h>
#include "../src/main.cpp" 

TEST(ArvoreBinaria, InsercaoEBusca) {
    no* raiz = nullptr;

    // Insere elementos
    raiz = inserir(raiz, 20);
    raiz = inserir(raiz, 10);
    raiz = inserir(raiz, 40);
    raiz = inserir(raiz, 15);
    raiz = inserir(raiz, 30);
    raiz = inserir(raiz, 50);
    raiz = inserir(raiz, 60);

    // Verifica se os elementos estão presentes
    EXPECT_NE(busca(raiz, 50), nullptr);
    EXPECT_NE(busca(raiz, 30), nullptr);
    EXPECT_NE(busca(raiz, 15), nullptr);
    EXPECT_NE(busca(raiz, 35), nullptr);
    EXPECT_NE(busca(raiz, 20), nullptr);
    EXPECT_EQ(busca(raiz, 59), nullptr); // Não deve existir
    EXPECT_EQ(busca(raiz, 99), nullptr); // Não deve existir

    // Verifica busca iterativa
    EXPECT_EQ(busca_iterativa(raiz, 10)->chave, 10);
    EXPECT_EQ(busca_iterativa(raiz, 40)->chave, 40);
}

TEST(ArvoreBinaria, Insercao) {
    no* raiz = nullptr;

    // Insere elementos
    raiz = inserir(raiz, 50);
    raiz = inserir(raiz, 35);
    raiz = inserir(raiz, 70);
    raiz = inserir(raiz, 25);
    raiz = inserir(raiz, 50);
    raiz = inserir(raiz, 65);
    raiz = inserir(raiz, 90);
    raiz = inserir(raiz, 30);
    raiz = inserir(raiz, 80);

    // Verifica se os elementos estão presentes
    EXPECT_NE(busca(raiz, 50), nullptr);
    EXPECT_NE(busca(raiz, 35), nullptr);


    raiz = inserir(raiz, 42);

    EXPECT_NE(busca(raiz, 42), nullptr);
    EXPECT_EQ(busca(raiz, 40)->dir->chave, 42);
}

TEST(ArvoreBinaria, Remocao) {
    no* raiz = nullptr;

    // Insere elementos
    raiz = inserir(raiz, 50);
    raiz = inserir(raiz, 35);
    raiz = inserir(raiz, 70);
    raiz = inserir(raiz, 25);
    raiz = inserir(raiz, 50);
    raiz = inserir(raiz, 65);
    raiz = inserir(raiz, 90);
    raiz = inserir(raiz, 30);
    raiz = inserir(raiz, 80);

    // Remove elemento folha
    raiz = remover(raiz, 40);
    EXPECT_EQ(busca(raiz, 40), nullptr);

    // Remove nó com um filho
    raiz = remover(raiz, 35);
    EXPECT_EQ(busca(raiz, 35), nullptr);

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
