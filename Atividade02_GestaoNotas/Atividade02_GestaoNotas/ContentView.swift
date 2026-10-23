import SwiftUI

struct Aluno: Identifiable {
    let id = UUID()
    let nome: String
    let nota1: Double
    let nota2: Double
    var media: Double { (nota1 + nota2) / 2 }
    var situacao: String { media >= 7.0 ? "Aprovado" : "Reprovado" }
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
    var aprovados: Int { alunos.filter { $0.media >= 7.0 }.count }
    var reprovados: Int { alunos.filter { $0.media < 7.0 }.count }
    
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
                        resumoCard(titulo: "Alunos", valor: totalAlunos, cor: .blue, icone: "person.3.fill")
                        resumoCard(titulo: "Aprovados", valor: aprovados, cor: .green, icone: "checkmark.circle.fill")
                        resumoCard(titulo: "Reprovados", valor: reprovados, cor: .red, icone: "xmark.circle.fill")
                    }
                    
                    Divider()
                    
                    // Lista (Corrigido o posicionamento dentro da VStack principal)
                    HStack {
                        Text("Alunos cadastrados")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(alunos.count) registros")
                            .foregroundColor(.gray)
                    }
                    
                    if alunos.isEmpty {
                        VStack(spacing: 10) {
                            Image(systemName: "person.crop.rectangle")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            Text("Nenhum aluno cadastrado")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                    } else {
                        ForEach(alunos) { aluno in
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text(aluno.nome)
                                        .font(.headline)
                                    Spacer()
                                    Button(role: .destructive) {
                                        removerAluno(aluno)
                                    } label: {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                }
                                
                                Text("Nota 1: \(aluno.nota1, specifier: "%.1f")")
                                Text("Nota 2: \(aluno.nota2, specifier: "%.1f")")
                                Text("Média: \(aluno.media, specifier: "%.1f")")
                                    .fontWeight(.bold)
                                
                                Text(aluno.situacao)
                                    .foregroundColor(aluno.media >= 7 ? .green : .red)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
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
    
    func cadastrarAluno() {
        guard !nome.trimmingCharacters(in: .whitespaces).isEmpty else {
            exibirAlerta(titulo: "Erro", mensagem: "Informe o nome do aluno.")
            return
        }
        guard let n1 = nota1, let n2 = nota2 else {
            exibirAlerta(titulo: "Erro", status: true, mensagem: "Digite notas válidas.")
            return
        }
        guard (0...10).contains(n1), (0...10).contains(n2) else {
            exibirAlerta(titulo: "Erro", status: true, mensagem: "As notas devem estar entre 0 e 10.")
            return
        }
        
        let novoAluno = Aluno(nome: nome, nota1: n1, nota2: n2)
        alunos.append(novoAluno)
        
        // Limpar campos
        nome = ""
        nota1 = nil
        nota2 = nil
    }
    
    func removerAluno(_ aluno: Aluno) {
        if let index = alunos.firstIndex(where: { $0.id == aluno.id }) {
            alunos.remove(at: index)
        }
    }
    
    func exibirAlerta(titulo: String, status: Bool = false, mensagem: String) {
        tituloAlerta = titulo
        mensagemAlerta = mensagem
        mostrarAlerta = true
    }
    
    @ViewBuilder
    func resumoCard(titulo: String, valor: Int, cor: Color, icone: String) -> some View {
        VStack(spacing: 10) {
            Image(systemName: icone)
                .font(.title)
                .foregroundColor(cor)
            Text("\(valor)")
                .font(.title)
                .fontWeight(.bold)
            Text(titulo)
                .foregroundColor(.gray)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

#Preview {
    ContentView()
}
