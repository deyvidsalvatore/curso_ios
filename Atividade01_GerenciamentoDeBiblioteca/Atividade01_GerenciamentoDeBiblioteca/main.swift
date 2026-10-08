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

/* TESTE
let l1 = Livro()
l1.anoPublicacao = 1999
l1.autor = Autor(nome: "J.K Rowling", anoNascimento: 1960)
l1.titulo = "Harry Potter e a Pedra Filosofal"
l1.exibirDetalhes()

l1.emprestar()
l1.emprestar()

l1.devolver()
l1.devolver() */

func menuPrincipal() {
    
    var executando = true
    
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
                print("TODO: Cadastrando")
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
