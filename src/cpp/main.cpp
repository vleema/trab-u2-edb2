#include <iostream>
#include <vector>

typedef struct nodo{
    int chave;
    struct nodo* esq;
    struct nodo* dir;

    // Construtor
    nodo(int chaveNovoNo) : chave(chaveNovoNo), esq(nullptr), dir(nullptr) {}

} no;


no* inserir(no* origem, int chaveNovoNo){
    if(origem == nullptr){
        return new no(chaveNovoNo);
    }

    if(chaveNovoNo == origem->chave){
        return origem;
    }

    if(chaveNovoNo < origem->chave){
        origem->esq = inserir(origem->esq, chaveNovoNo);
    }else{
        origem->dir = inserir(origem->dir, chaveNovoNo);
    }

    return origem;
}

void pre_ordem(no* pt){
    std::cout << pt->chave << " ";
    if(pt->esq != NULL){
        pre_ordem(pt->esq);
    }
    if(pt->dir != NULL){
        pre_ordem(pt->dir);
    }
}

void ordem_simetrica(no* pt){
    if(pt->esq != NULL){
        ordem_simetrica(pt->esq);
    }
    std::cout << pt->chave << " ";
    if(pt->dir != NULL){
        ordem_simetrica(pt->dir);
    }
}

void pos_ordem(no* pt){
    if(pt->esq != NULL){
        pos_ordem(pt->esq);
    }
    if(pt->dir != NULL){
        pos_ordem(pt->dir);
    }
    std::cout << pt->chave << " ";
}

void auxiliar_em_nivel(no* no, int nivel, std::vector<std::vector<int>>& resultados){
    if(!no){
        return;
    }

    if(static_cast<int>(resultados.size()) == nivel){
        resultados.push_back(std::vector<int>());
    }

    resultados[nivel].push_back(no->chave);

    auxiliar_em_nivel(no->esq, nivel + 1, resultados);
    auxiliar_em_nivel(no->dir, nivel + 1, resultados);
}

void em_nivel(no* no){
    std::vector<std::vector<int>> resultados;

    auxiliar_em_nivel(no, 0, resultados);

    for(const auto& nivel : resultados){
        for(int chave : nivel){
            std::cout << chave << " ";
        }
        //std::cout << "| ";
    }
    std::cout << std::endl;
}

no* busca(no* raiz, int chave){
    if(raiz == NULL || raiz->chave == chave){
        return raiz;
    }
    if(chave < raiz->chave){
        return busca(raiz->esq, chave);
    }
    if(chave > raiz->chave){
        return busca(raiz->dir, chave);
    }
    return NULL;
}

no* busca_iterativa(no* raiz, int chave){
    while(raiz != NULL && raiz->chave != chave){
        if(chave < raiz->chave){
            raiz = raiz->esq;
        }else{
            raiz = raiz->dir;
        }
    }
    return raiz;
}

//Pega o valor mínimo da árvore ou subárvore
no* encontra_minimo(no* raiz){
    while(raiz && raiz->esq){
        raiz = raiz->esq;
    }
    return raiz;
}

no* remover(no* root, int chave) {
    if (!root)
        return nullptr;

    if (chave < root->chave) {
        root->esq = remover(root->esq, chave);
    } else if (chave > root->chave) {
        root->dir = remover(root->dir, chave);
    } else {
        // Caso 1: Nó é uma folha
        if (!root->esq && !root->dir) {
            delete root;
            return nullptr;
        }
        // Caso 2: Nó tem um único filho
        else if (!root->esq) {
            no* temp = root->dir;
            delete root;
            return temp;
        } else if (!root->dir) {
            no* temp = root->esq;
            delete root;
            return temp;
        }
        // Caso 3: Nó tem dois filhos
        else {
            no* temp = encontra_minimo(root->dir);
            root->chave = temp->chave;            
            root->dir = remover(root->dir, temp->chave);
        }
    }
    return root;
}

int main(){
    no* raiz = nullptr;

    // Teste de inserção e busca
    std::cout << "Teste de inserção:" << std::endl;
    std::cout << "Inserindo 50, 35, 70, 25, 50, 65, 90, 30 e 80"<< std::endl;
    raiz = inserir(raiz, 50);
    raiz = inserir(raiz, 35);
    raiz = inserir(raiz, 70);
    raiz = inserir(raiz, 25);
    raiz = inserir(raiz, 50);
    raiz = inserir(raiz, 65);
    raiz = inserir(raiz, 90);
    raiz = inserir(raiz, 30);
    raiz = inserir(raiz, 80);

    std::cout << "\nTravessia em nivel:"<< std::endl;
    em_nivel(raiz);

    std::cout << "\nTeste de busca:\n";
    std::cout << (busca(raiz, 35) != nullptr ? "Encontrado 50\n" : "Nao encontrado 50\n")<< std::endl;
    std::cout << (busca(raiz, 90) != nullptr ? "Encontrado 35\n" : "Nao encontrado 35\n")<< std::endl;

    std::cout << "Teste de remoção:\n";
    raiz = remover(raiz, 40);
    std::cout << (busca(raiz, 40) == nullptr ? "Removido 40\n" : "Falha ao remover 40\n")<< std::endl;
    raiz = remover(raiz, 35);
    std::cout << (busca(raiz, 35) == nullptr ? "Removido 35\n" : "Falha ao remover 35\n")<< std::endl;
    raiz = remover(raiz, 50);
    std::cout << (busca(raiz, 50) == nullptr ? "Removido 50\n" : "Falha ao remover 50\n")<< std::endl;

    // Teste de travessia
    std::cout << "Travessia em ordem simetrica:\n";
    ordem_simetrica(raiz);
    std::cout << "\n\nTravessia em pre-ordem:\n";
    pre_ordem(raiz);
    std::cout << "\n\nTravessia em pos-ordem:\n";
    pos_ordem(raiz);
    std::cout << "\n\nTravessia em nivel:\n";
    em_nivel(raiz);

    return 0;


}