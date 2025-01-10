# Vídeo Solicitado

[https://drive.google.com/file/d/1dbfPqjNdvHVfbht1xMqU6htON6X5RtQM/view?usp=sharing] para entender o funcionamento do projeto.

# Sobre o repositório

## Dependências

- [GHCup](https://www.haskell.org/ghcup/) - Haskell
- [Rustup](https://www.rust-lang.org/tools/install) - Rust Toolchain Manager
- [Cargo](https://rust-lang.github.io/rustup/installation/index.html) - Rust Package Manager
- [GNU Make](https://www.gnu.org/software/make/) - Makefile
- GCC ou Clang - Compilador de C/C++
- [TeX Live](https://tug.org/texlive/) - Compilador $\LaTeX$ e bibliotecas

## $\LaTeX$

Para compilar o documento, use o Makefile na pasta latex.

- Compila o arquivo `main.pdf` em `latex/output`.

```terminal
make
```

- Limpa os arquivos de compilação

```terminal
 make clean
```

## Implementação dos algoritmos

Os arquivos de código que contem as implementações requeridas estão na pasta `src/`, em Rust estão sendo implementadas as funções da Heap e HeapSort, mas também deixamos os algoritmos de ordenação implementados no último trabalho para podemos comparar com o novo. Em haskell foram implementadas as árvores AVL e Rubro Negra e em C++ foi implementada a árvore binária.

### Rust

#### Rodando

Para rodar os testes de Alteração de Prioridade, Inserção, Remoção (da raiz) e Construção das Heaps basta executar dentro da pasta `src/rust`:

```terminal
cargo test
```

Ele vai mostrar no terminal o resultado dos testes programados no código.

Pra rodar a comparação entre os sorts basta executar dentro da pasta `src/rust`:

```terminal
cargo run --release
```

E aí ele vai criar o arquivo `src/rust/src/out/entries.txt` e `src/rust/src/out/output.txt`, com as listas que ele usou e o resultado de performance respectivamente.

### Haskell

Para testar/brincar com os códigos em haskell, basta ir em `src/haskell`, e abrir o `ghci` com o que você quer mexer:

```terminal
ghci RBTree
```

### C++

```terminal
g++ main.cpp -o main
./main

```

# Lista de atividades dos colaboradores

## 1. Implementação Computacional (Heap)

- [x] 1.0. Descreva o ambiente computacional utilizado (Software e Hardware). (**Bianca**)

- [x] 1.1. Implemente as funções de Heap (máximo e mínimo). Seu código deve constar das funções de (a) Alteração de Prioridade; (b) Inserção; (c) Remoção (da raiz) e (d) Construção das Heaps. Para este item, apresente as saídas do programa com os exemplos vistos em sala de aula.(**Bianca**)

- [x] 1.2. Descreva em forma de pseudocódigo e implemente o algoritmo de ordenação Heapsort.(**Bianca**)

- [x] 1.3. Crie listas aleatórias, contendo inteiros variando entre 0 e 10.000 (dez mil), e com o tamanho (da lista) 10.000, 100.000 e 1.000.000 (salve as listas em arquivo txt).(**Bianca**)

- [x] 1.4. Compare os resultados obtidos com o algoritmo de ordenação Heapsort com os algoritmos implementados no trabalho da primeira unidade (BubbleSort, MergeSort e QuickSort, iterativo e recursivo) nas listas, salve o resultado da lista ordenada em um arquivo .txt, e compute o tempo de processamento para cada caso. Faça o tabelamento dos resultados, e realize uma análise detalhada. Esta análise deve ser escrita e entregue em um arquivo PDF.(**Bianca**)

## 2. Implementação Computacional (Árvores Binárias)

- [x] 2.1. Defina (descreva em formato de fluxograma e implemente) uma estratégia para a criação de árvore binária a partir de uma lista de dados de entrada. (de preferência, uma estratégia que não deixe a árvore inicial muito desequilibrada).(**Marina**)
- [x] 2.2. Implemente as funções de busca, inserção e remoção em uma árvore binária. Teste nos exemplos vistos em sala de aula.(**Marina**)
- [x] 2.3. Implemente as funções de percurso em árvore binária: (a) Pre-Ordem; (b) Ordem-Simétrica; (c) Pós-Ordem e (d) Em-Nível. Teste nos exemplos vistos em sala de aula.(**Marina**)

## 3. Implementação Computacional (Árvores AVL)

- [x] 3.1. Implemente as funções de (a) rotação; (b) busca (mesmo que na árvore binária); (c) inserção e (d) remoção em uma árvore AVL. Teste nos exemplos vistos em sala de aula. (**Gabriel**)
- [x] 3.2. Crie uma árvore AVL, usando a função de inserção, com os seguintes valores inteiros: L={15, 18,20, 35, 32, 38, 30, 40, 32, 45, 48, 52, 60, 50}. Imprima a árvore em nível (ou usando alguma biblioteca de representação gráfica de árvores).(**Gabriel**)

## 4. Implementação Computacional (Árvores Rubro-Negras)

- [x] 4.1. Faça um algoritmo em forma de fluxograma para a função de exclusão de um nó em uma árvore Rubro Negra. (deve ser entregue em formato PDF) (**Vinicius**)
- [x] 4.2. Implemente as funções de (a) rotação (mesmo que na árvore AVL); (b) busca (mesmo que na árvore binária); (c) inserção e (d) remoção em uma árvore RN. Teste nos exemplos vistos em sala de aula. (**Vinicius**)
- [x] 4.3. Crie uma árvore RN, usando a função de inserção, com os seguintes valores inteiros: L={15, 18,20, 35, 32, 38, 30, 40, 32, 45, 48, 52, 60, 50}. Imprima a árvore em nível (ou usando alguma biblioteca de representação gráfica de árvores). (**Vinicius**)

Na verdade verdadeira, novamente, todo mundo se intrometeu em tudo! Mas por fins de prestar conta, essa é nossa lista.

---

&copy; IMD/UFRN 2024
