import SwiftUI

struct TarefaView : View {
    
    @State private var viewModel = TarefaViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField(
                        "Digite uma tarefa",
                        text: $viewModel.novaTarefa
                    )
                    .textFieldStyle(.roundedBorder)
                    
                    Button("Adicionar") {
                        viewModel.adicionarTarefa()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                
                List {
                    if viewModel.tarefas.isEmpty {
                        ContentUnavailableView(
                            "Nenhuma tarefa",
                            systemImage: "checklist",
                            description: Text(
                                "Adicione sua primeira tarefa"
                            )
                        )
                    } else {
                        ForEach(viewModel.tarefas) { tarefa in
                            
                            HStack {
                                Button {
                                    viewModel.alternarStatus(tarefa: tarefa)
                                } label: {
                                    Image(
                                        systemName: tarefa.concluido ? "checkmark.circle.fill" : "circle"
                                    )
                                    .foregroundColor(tarefa.concluido ? .green : .gray)
                                }
                            }
                            
                            Text(tarefa.titulo)
                                .strikethrough(
                                    tarefa.concluido
                                )
                                .foregroundColor(tarefa.concluido ?
                                    .secondary : .primary)
                            
                        }
                        .onDelete(
                            perform: viewModel.remover
                        )
                    }
                }
            }
            .navigationTitle("Lista de tarefas")
        }
    }
    
}

#Preview {
    TarefaView()
}
