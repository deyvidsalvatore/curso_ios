import SwiftUI
import SwiftData

struct EventoView: View {

    @Environment(\.modelContext)
    private var modelContext

    @State private var viewModel = EventoViewModel()

    var body: some View {

        NavigationStack {

            VStack {

                EventoFormView(viewModel: viewModel) {

                    viewModel.cadastrarEvento(
                        modelContext: modelContext
                    )
                }.frame(height: 320)
                
                List {

                    ForEach(viewModel.eventos, id: \.id) { evento in

                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {

                            Text(evento.titulo)
                                .font(.headline)
                                .foregroundColor(.black)

                            Text(evento.descricao)
                                .foregroundColor(.black)

                            Text(evento.local)
                                .font(.subheadline)
                                .foregroundColor(.black)

                            Text(
                                evento.dataEvento,
                                style: .date
                            ).foregroundColor(.black)

                            Text(
                                evento.dataEvento,
                                style: .time
                            ).foregroundColor(.black)
                        }
                    }
                    .onDelete { indexSet in

                        viewModel.removerEvento(
                            at: indexSet,
                            modelContext: modelContext
                        )
                    }
                }
                .scrollContentBackground(.hidden)
                .background(.white)
            }
            .background(.white)
            .navigationTitle("Gerenciador de Eventos")
            .onAppear {

                viewModel.listarEventos(
                    modelContext: modelContext
                )
            }
        }
    }
}

#Preview {
    EventoView()
}
