import SwiftUI
import SwiftData

@main
struct Atividade05_GerenciadorDeEventosApp: App {
    var body: some Scene {
        WindowGroup {
            EventoView()
        }
        .modelContainer(for: Evento.self)
    }
}
