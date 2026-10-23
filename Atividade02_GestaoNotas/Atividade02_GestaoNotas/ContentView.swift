import SwiftUI

struct Aluno: Identifiable {
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
    @State private var nota1: Double? = nil
    @State private var nota2: Double? = nil
    
    @State private var alunos: [Aluno] = []

    @State private var tituloAlerta = ""
    @State private var mensagemAlerta = ""
    @State private var mostrarAlerta = false
    
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
                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider()

                    // Cadastro
                    Text("Cadastro Aluno")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                    
                    TextField("Digite o nome do aluno", text: $nome)
                        .textFieldStyle(.roundedBorder)
                        .font(.system(size: 18))
                    
                    TextField("Nota 1", value: $nota1, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .font(.system(size: 18))
                    
                    TextField("Nota 2", value: $nota2, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .font(.system(size: 18))
                    
                    Button(action: cadastrarAluno) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Cadastrar aluno")
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    
                    Divider()
                    
                    // Resumo
                    Text("Resumo da turma")
                        .font(.title2)
                        .fontWeight(.bold)

                    HStack {
                        resumoCard(
                            titulo: "Alunos",
                            valor: totalAlunos,
                            cor: .blue,
                            icone: "person.3.fill"
                        )

                        resumoCard(
                            titulo: "Aprovados",
                            valor: aprovados,
                            cor: .green,
                            icone: "checkmark.circle.fill"
                        )

                        resumoCard(
                            titulo: "Reprovados",
                            valor: reprovados,
                            cor: .red,
                            icone: "xmark.circle.fill"
                        )
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }

        .alert(tituloAlerta, isPresented: $mostrarAlerta) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(mensagemAlerta)
        }
    }
    
    func cadastrarAluno() -> Void {
        guard !nome.trimmingCharacters(in: .whitespaces).isEmpty else {
            exibirAlerta(titulo: "Erro", mensagem: "Informe o nome do aluno.")
            return
        }

        guard let n1 = nota1, let n2 = nota2 else {
            exibirAlerta(titulo: "Erro", mensagem: "Digite notas válidas.")
            return
        }

        guard (0...10).contains(n1), (0...10).contains(n2) else {
            exibirAlerta(titulo: "Erro", mensagem: "As notas devem estar entre 0 e 10.")
            return
        }

        let novoAluno = Aluno(
            nome: nome,
            nota1: n1,
            nota2: n2
        )

        alunos.append(novoAluno)
        
        exibirAlerta(titulo: "Sucesso!", mensagem: "O aluno \(nome) foi adicionado com sucesso.")

        nome = ""
        nota1 = nil
        nota2 = nil
    }
    
    func exibirAlerta(titulo: String, mensagem: String) -> Void {
        tituloAlerta = titulo
        mensagemAlerta = mensagem
        mostrarAlerta = true
    }
    
    @ViewBuilder
    func resumoCard(
            titulo: String,
            valor: Int,
            cor: Color,
            icone: String
    ) -> some View {

            VStack(spacing: 10) {

                Image(systemName: icone)
                    .font(.title)
                    .foregroundColor(cor)

                Text("\(valor)")
                    .font(.title)
                    .fontWeight(.bold)

                Text(titulo)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
    }
    
}

#Preview {
    ContentView()
}
