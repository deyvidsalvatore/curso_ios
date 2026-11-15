import Foundation
import SwiftData

@Model
class Evento {
    @Attribute(.unique)
    var id: UUID
    
    var titulo: String
    var descricao: String
    var dataEvento: Date
    var local: String
    
    init (
        id: UUID = UUID(),
        titulo: String,
        descricao: String,
        dataEvento: Date,
        local: String
    ) {
        self.id = id
        self.titulo = titulo
        self.descricao = descricao
        self.dataEvento = dataEvento
        self.local = local
    }
}
