import SwiftUI

struct EventoFormView: View {

    @Bindable var viewModel: EventoViewModel
    let salvar: () -> Void

    var body: some View {

        Form {

            Section("Dados do Evento") {

                TextField(
                    "Título",
                    text: $viewModel.titulo
                )

                TextField(
                    "Descrição",
                    text: $viewModel.descricao,
                    axis: .vertical
                )

                DatePicker(
                    "Data e Hora",
                    selection: $viewModel.dataEvento
                )

                TextField(
                    "Local",
                    text: $viewModel.local
                )
            }

            Button("Salvar Evento") {
                salvar()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
