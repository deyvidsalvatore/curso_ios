import SwiftUI


struct Aluno : Identifiable {
    let id = UUID()
    let nome: String
    let nota1: Double
    let nota2: Double
    
    var media: Double {
        (nota1 + nota2) / 2
    }
    
    var situacao: String {
        media >= 7.0 ? "Aprovado" : "Reprovado"
    }
}

struct ContentView: View {
    
    @State private var nome = ""
    @State private var nota1 = ""
    @State private var nota2 = ""
    
    @State private var alunos: [Aluno] = []
    
    @State private var mensagemErro = ""
    @State private var mostrarErro = false
    
    var totalAlunos: Int { alunos.count }
    
    var aprovados: Int {
        alunos.filter { $0.media >= 7.0 }.count
    }
    
    var reprovados: Int {
        alunos.filter { $0.media < 7.0 }.count
    }
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    
                    // Header
                    VStack(spacing: 10) {
                        Image(systemName: "graduationcap.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(.orange)
                        
                        Text("Minha turma")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("Cadastre alunos e acompanhe os resultados.")
                            .foregroundStyle(.gray)
                            .font(.headline)
                    }.frame(maxWidth: .infinity)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
