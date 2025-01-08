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
    raiz = inserir(raiz, 30);
    raiz = inserir(raiz, 25);
    raiz = inserir(raiz, 39);
    raiz = inserir(raiz, 20);
    raiz = inserir(raiz, 27);
    raiz = inserir(raiz, 35);
    raiz = inserir(raiz, 42);
    raiz = inserir(raiz, 23);
    raiz = inserir(raiz, 40);

    // Testa ordem simétrica
    testing::internal::CaptureStdout();
    ordem_simetrica(raiz);
    std::string output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(output, "20\n23\n25\n27\n30\n35\n39\n40\n42");

    // Testa pré-ordem
    testing::internal::CaptureStdout();
    pre_ordem(raiz);
    output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(output, "30\n25\n20\n23\n27\n39\n35\n42\n40");

    // Testa pós-ordem
    testing::internal::CaptureStdout();
    ordem_simetrica(raiz);
    output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(output, "23\n20\n27\n25\n35\n40\n42\n39\n30");

    // Testa em-nível
    testing::internal::CaptureStdout();
    pre_ordem(raiz);
    output = testing::internal::GetCapturedStdout();
    EXPECT_EQ(output, "30\n25\n39\n20\n27\n35\n42\n23\n40");
}
