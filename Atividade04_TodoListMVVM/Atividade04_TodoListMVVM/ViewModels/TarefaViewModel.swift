import Foundation
import Observation
import SwiftUI

@Observable
@MainActor
class TarefaViewModel {
    var tarefas: [Tarefa] = []
    var novaTarefa: String = ""
    
    init() {
        tarefas = [
//            Tarefa(titulo: "Estudar SwiftUI"),
//            Tarefa(titulo: "Praticar MVVM"),
//            Tarefa(titulo: "Enviar exercício", concluido: true)
        ]
        
    }
    
    func adicionarTarefa() {
        let tituloLimpo = novaTarefa.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !tituloLimpo.isEmpty else {
            return
        }
        
        tarefas.append(
            Tarefa(titulo: tituloLimpo)
        )
        
        novaTarefa = ""
    }
    
    func alternarStatus(tarefa: Tarefa) {

        guard let indice = tarefas.firstIndex(
            where: { $0.id == tarefa.id }
        ) else {
            return
        }

            tarefas[indice].concluido.toggle()
    }

    func remover(indice: IndexSet) {
        tarefas.remove(atOffsets: indice)
    }
}
