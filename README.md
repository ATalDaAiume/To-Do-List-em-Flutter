![Atividade](https://img.shields.io/badge/Atividade-Flutter-blue)
![Dart](https://img.shields.io/badge/Linguagem-Dart-00b4ab)

# 💜 App de Lista de Tarefas (To-Do List)
> Resolução de Atividade Prática — Aula 7

**Aluna:** Eloize Aiume de Liz Pereira | **Turma:** 5ª Fase — Análise e Desenvolvimento de Sistemas (2026/1)

Repositório criado para armazenar o projeto completo da atividade prática de **Gerenciamento de Estado Básico em Flutter**, solicitada no contexto da disciplina de Desenvolvimento para Dispositivos Móveis na Faculdade Senac Joinville.

## 📚 Sobre o Projeto

Este aplicativo é uma **To-Do List interativa** totalmente construída em Flutter. O objetivo principal da atividade foi aplicar na prática os conceitos fundamentais de interface e reatividade, focando especificamente na utilização de `StatefulWidget`, manipulação de estado com `setState()`, entrada de dados de utilizador e listas dinâmicas.

A interface foi completamente personalizada para uma temática em tons de roxo (Deep Purple) amigável, garantindo uma ótima experiência de utilizador (UX) com a implementação de todos os elementos opcionais propostos.

## 📸 Capturas de Ecrã (Screenshots)

Abaixo estão as demonstrações do aplicativo a funcionar em diferentes estados:

| 📭 Lista Vazia | 📝 Com Tarefas (Pendentes) | ✅ Tarefas Concluídas |
| :---: | :---: | :---: |
| <img src="https://i.postimg.cc/j5C9tC4B/vazio.png" width="250"> | <img src="https://i.postimg.cc/fLkFDkf8/pendente.png" width="250"> | <img src="https://i.postimg.cc/hjhwch1Z/concluído.png" width="250"> |

## ✨ Funcionalidades Implementadas

### 🎯 Obrigatórias
- [x] **Adicionar Tarefas:** Entrada de texto via `TextField` com botão e limpeza automática do campo.
- [x] **Exibir Lista:** Interface reativa baseada em lista, com ecrã alternativo simpático quando não há tarefas.
- [x] **Marcar como Concluída:** Uso de `Checkbox` com atualização visual instantânea (texto riscado e mudança de cor).
- [x] **Remover Tarefas:** Botão individual de exclusão para cada item da lista.

### ⭐ Bônus (Adicionais)
- [x] **Painel de Estatísticas:** Contador fixo no topo exibindo o Total, tarefas Pendentes e Concluídas.
- [x] **Filtros Dinâmicos:** Um Dropdown estilizado para alternar a visão entre *Todas*, *Pendentes* e *Concluídas*.
- [x] **Limpeza em Lote:** Botão inteligente na `AppBar` (`delete_sweep`) para apagar todas as tarefas concluídas de uma só vez.
- [x] **Edição de Texto:** Botão em cada tarefa que abre um *Dialog* (pop-up) para renomear itens já criados.
- [x] **Identidade Visual:** Sistema de cores distinto (elevação e opacidade) para separar claramente o que está por fazer do que já foi feito.
- [x] **Animações Fluidas:** Uso do `AnimatedList` para criar transições de expansão e encolhimento ao adicionar, remover ou filtrar tarefas.

## 🚀 Como Executar o Projeto

Siga os passos abaixo para rodar o aplicativo no seu ambiente local:

1. Certifique-se de que tem o [Flutter SDK](https://flutter.dev/docs/get-started/install) e o Dart instalados.
2. Clone este repositório no seu terminal:
   ```bash
   git clone https://github.com/seu-usuario/To-Do-List-em-Flutter.git
3. Aceda à pasta do projeto recém-clonado.
4. Baixe as dependências necessárias.
5. Inicie o emulador (ou conecte o telemóvel) e execute a aplicação.

### 🛠️ Tecnologias Utilizadas
- Framework Flutter
- Linguagem Dart
- VS Code / Android Studio
- Estado Nativo: `StatefulWidget`, `TextEditingController` e `AnimatedListState`.

### 📝 Observações
Sempre que uma lista é modificada (adição, edição ou exclusão), o `setState()` é acionado para garantir a atualização instantânea em conjunto com as transições visuais do ecrã. 🚀
