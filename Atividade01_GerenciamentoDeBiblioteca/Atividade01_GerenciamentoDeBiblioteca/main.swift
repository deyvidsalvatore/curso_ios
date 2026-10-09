import Foundation

protocol Documento {
    var id: UUID { get set }
    
    func exibirDetalhes();
}

struct Autor {
    var nome: String;
    var anoNascimento: Int
}


class Livro: Documento {
    
    private var _id: UUID = UUID()
    private var _titulo: String = ""
    private var _autor: Autor = Autor(nome: "", anoNascimento: 0)
    private var _anoPublicacao: Int = 0
    private var _isEmprestado = false
    
    var id: UUID {
        get { _id }
        set { _id = newValue }
    }
    
    var titulo: String {
        get { _titulo }
        set { _titulo = newValue }
    }
    
    var autor: Autor {
        get { _autor }
        set { _autor = newValue }
    }
    
    var anoPublicacao: Int {
        get { _anoPublicacao }
        set { _anoPublicacao = newValue }
    }
    
    func exibirDetalhes() {
        print("==================")
        print("ID: \(self._id)")
        print("Título: \(self._titulo)")
        print("Autor: \(self._autor.nome)")
        print("Ano: \(self._anoPublicacao)")
        print("Está emprestado: \(self._isEmprestado)")
        print("==================")
    }
    
    func emprestar() {
        if (_isEmprestado) {
            print("O livro já está emprestado!")
        } else {
            self._isEmprestado = true
        }
    }
    
    func devolver() {
        if (!_isEmprestado) {
            print("O livro já foi devolvido!")
        } else {
            self._isEmprestado = false
        }
    }
}

protocol LivroDAO {
    func criar(_ livro: Livro) throws
    func buscarPorId(_ id: UUID) -> Livro?
    func buscarTodos() -> [Livro]
    func atualizar(_ livro: Livro) throws
    func remover(_ id: UUID)
}

final class LivroDAOImpl : LivroDAO {
    private var bancoDeDados: [UUID: Livro] = [:]
    
    func criar(_ livro: Livro) throws {
        bancoDeDados[livro.id] = livro
        print("Livro '\(livro.titulo)' criado com sucesso!")
    }
    
    func buscarPorId(_ id: UUID) -> Livro? {
        return bancoDeDados[id]
    }
    
    func buscarTodos() -> [Livro] {
        return Array(bancoDeDados.values)
    }
    
    func atualizar(_ livro: Livro) throws {
        if bancoDeDados[livro.id] != nil {
            bancoDeDados[livro.id] = livro
            print("Livro '\(livro.titulo)' atualizado!")
        } else {
            print("Erro: Livro não encontrado para atualização.")
        }
    }
    
    func remover(_ id: UUID) {
        if bancoDeDados.removeValue(forKey: id) != nil {
            print("Livro deletado com sucesso!")
        } else {
            print("Erro: Livro não encontrado para remoção com o ID: \(id).")
        }
    }
}

func menuPrincipal() {
    
    var executando = true
    
    let livroDAO = LivroDAOImpl()
    
    while executando {
        limparConsole()
        
        exibicacaoLogoMenu()
        exibicaoOpcoesMenu()
        
        if let entrada = readLine(), let opcao = Int(entrada) {
            switch opcao {
            case 0:
                print("Saindo do programa... Até mais!")
                executando = false
            case 1:
                print("Digite o título do livro: ")
                let titulo = readLine() ?? ""
    
                print("Digite o nome do autor do livro: ")
                let nomeAutor = readLine() ?? ""
                
                print("Digite o ano de nascimento do autor: ")
                let anoNascimentoAutor = Int(readLine() ?? "") ?? 0
                
                print("Digite o ano de publicação do livro: ")
                let anoPublicacao = Int(readLine() ?? "") ?? 0
                
                let novoLivro = Livro()
                novoLivro.titulo = titulo
                novoLivro.anoPublicacao = anoPublicacao
                novoLivro.autor = Autor(nome: nomeAutor, anoNascimento: anoNascimentoAutor)
                try? livroDAO.criar(novoLivro)
                
                
                
            case 2:
                print("TODO: Listando")
            case 3:
                print("TODO: Editar")
            case 4:
                print("TODO: Removendo")
            default:
                print("Opção inválida")
            }
        } else {
            print("Digite apenas números!")
        }
        
        print("\nPressione ENTER para continuar...")
        
        _ = readLine()
    }
    
    
}

func limparConsole() {
    for _ in 1...50 {
        print()
    }
}


func exibicacaoLogoMenu() {
    print("==========================")
    print()
    print("= GERENCIADOR DE LIVROS  =")
    print("=      Versão 1.0        =")
    print("= Powered By deyvid.silva =")
    print()
    print("==========================")
}


func exibicaoOpcoesMenu() {
    print()
    print("Escolha uma opcao")
    print()
    print("1) Cadastrar")
    print("2) Listar/Buscar")
    print("3) Editar")
    print("4) Remover")
    print("0) Sair do programa")
    print()
}

menuPrincipal()
