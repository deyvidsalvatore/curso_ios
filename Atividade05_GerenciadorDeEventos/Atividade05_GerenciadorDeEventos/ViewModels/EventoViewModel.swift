import Foundation
import SwiftData
import Observation

@Observable
class EventoViewModel {
    var eventos: [Evento] = []
    
    var titulo = ""
    var descricao = ""
    var dataEvento = Date()
    var local = ""
    
    func listarEventos(modelContext: ModelContext) {
        let descriptor = FetchDescriptor<Evento>(
            sortBy: [
                SortDescriptor(\Evento.dataEvento, order: .forward)
            ]
        )
        
        eventos = (try? modelContext.fetch(descriptor)) ?? []
    }
    
    func cadastrarEvento(modelContext: ModelContext) {

        guard !titulo.trimmingCharacters(in: .whitespaces).isEmpty,
              !local.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }

        let novoEvento = Evento(
            titulo: titulo,
            descricao: descricao,
            dataEvento: dataEvento,
            local: local
        )

        modelContext.insert(novoEvento)

        limparCampos()

        listarEventos(modelContext: modelContext)
    }
    
    func removerEvento(
            at offsets: IndexSet,
            modelContext: ModelContext
    ) {
        guard let indice = offsets.first else { return }

        modelContext.delete(eventos[indice])

        listarEventos(modelContext: modelContext)
    }
    
    private func limparCampos() {
        titulo = ""
        descricao = ""
        dataEvento = Date()
        local = ""
    }
}
