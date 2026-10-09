# Gerenciador de Livros

Sistema de gerenciamento de livros desenvolvido em Swift utilizando conceitos de Programação Orientada a Objetos (POO), protocolos, encapsulamento e persistência em memória através do padrão DAO (Data Access Object).

## Funcionalidades

- Cadastrar livros
- Buscar livro por ID
- Listar todos os livros cadastrados
- Editar informações de um livro
- Remover livros
- Realizar empréstimo de livros
- Realizar devolução de livros
- Exibir detalhes completos de um livro

## Estrutura do Projeto

### Documento

Protocolo base que define o comportamento comum para documentos.

```swift
protocol Documento {
    var id: UUID { get set }
    func exibirDetalhes()
}
```

### Autor

Representa o autor de um livro.

```swift
struct Autor {
    var nome: String
    var anoNascimento: Int
}
```

### Livro

Classe principal da aplicação.

#### Atributos

- ID único (UUID)
- Título
- Autor
- Ano de publicação
- Status de empréstimo

#### Métodos

- `exibirDetalhes()`
- `emprestar()`
- `devolver()`

### LivroDAO

Interface responsável pelas operações de persistência.

```swift
protocol LivroDAO {
    func criar(_ livro: Livro) throws
    func buscarPorId(_ id: UUID) -> Livro?
    func buscarTodos() -> [Livro]
    func atualizar(_ livro: Livro) throws
    func remover(_ id: UUID)
}
```

### LivroDAOImpl

Implementação concreta do DAO utilizando um dicionário em memória.

```swift
private var bancoDeDados: [UUID: Livro] = [:]
```

## Menu Principal

```text
1) Cadastrar
2) Listar/Buscar
3) Editar
4) Remover
5) Emprestar Livro
6) Devolver Livro
0) Sair do programa
```

## Fluxo de Cadastro

1. Informar o título do livro.
2. Informar o nome do autor.
3. Informar o ano de nascimento do autor.
4. Informar o ano de publicação.
5. O sistema gera automaticamente um UUID.
6. O livro é armazenado na memória.

## Fluxo de Busca

### Buscar por ID

1. Informar o UUID do livro.
2. O sistema procura o livro no banco de dados.
3. Caso encontrado, os detalhes são exibidos.

### Listar Todos

1. Recupera todos os livros cadastrados.
2. Exibe as informações de cada livro.

## Fluxo de Edição

1. Informar o UUID do livro.
2. O sistema localiza o registro.
3. Informar os novos dados.
4. O livro é atualizado.

## Fluxo de Remoção

1. Informar o UUID do livro.
2. O sistema remove o livro do banco de dados.
3. Uma mensagem de confirmação é exibida.

## Fluxo de Empréstimo

1. Informar o UUID do livro.
2. O sistema verifica se o livro existe.
3. Caso esteja disponível, o status é alterado para emprestado.
4. Caso já esteja emprestado, uma mensagem de aviso é exibida.

## Fluxo de Devolução

1. Informar o UUID do livro.
2. O sistema verifica se o livro existe.
3. Caso esteja emprestado, o status é alterado para devolvido.
4. Caso já esteja devolvido, uma mensagem de aviso é exibida.

## Tecnologias Utilizadas

- Swift
- Foundation
- Programação Orientada a Objetos
- Protocolos
- Encapsulamento
- DAO Pattern

## Conceitos Aplicados

### Encapsulamento

Os atributos da classe `Livro` são privados e acessados através de propriedades.

```swift
private var _titulo: String
private var _autor: Autor
private var _anoPublicacao: Int
private var _isEmprestado: Bool
```

### Protocolos

O sistema utiliza protocolos para definir contratos de comportamento.

- `Documento`
- `LivroDAO`

### Polimorfismo

A classe `Livro` implementa o protocolo `Documento`.

```swift
class Livro: Documento
```

### DAO (Data Access Object)

A camada DAO é responsável por centralizar as operações de acesso aos dados.

```swift
final class LivroDAOImpl: LivroDAO
```

## Armazenamento

Os dados são mantidos em memória utilizando um `Dictionary`, onde a chave é o UUID do livro.

```swift
private var bancoDeDados: [UUID: Livro] = [:]
```

## Limitações

- Os dados são armazenados apenas em memória.
- Os registros são perdidos ao encerrar o programa.
- Não há persistência em banco de dados ou arquivos.
- Não há autenticação de usuários.

## Autor

**Deyvid Santos da Silva**

Versão 1.0.0