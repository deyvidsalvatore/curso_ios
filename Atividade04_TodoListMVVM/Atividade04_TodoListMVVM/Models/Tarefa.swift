import Foundation

struct Tarefa : Identifiable {
    let id: UUID
    var titulo: String
    var concluido: Bool
    
    init(
        id: UUID = UUID(),
        titulo: String,
        concluido: Bool = false
    ) {
        self.id = id
        self.titulo = titulo
        self.concluido = concluido
    }
}
