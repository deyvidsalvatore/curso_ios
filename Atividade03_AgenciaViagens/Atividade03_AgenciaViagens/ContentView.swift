import SwiftUI

struct PacoteViagem: Identifiable {
    let id = UUID()
    let titulo: String
    let diarias: Int
    let local: String
    let dataPartida: String
    let dataChegada: String
    let informacoesHotel: String
    let imagemNome: String
    let preco: Double
}

struct ContentView: View {
    let pacotes = [
        PacoteViagem(
            titulo: "Porto de Galinhas Premium",
            diarias: 7,
            local: "Porto de Galinhas - PE",
            dataPartida: "10/01/2027",
            dataChegada: "17/01/2027",
            informacoesHotel: "Resort pé de areia com café da manhã incluso.",
            imagemNome: "sun.max.fill",
            preco: 2899
        ),
        
        PacoteViagem(
                titulo: "Maragogi Paradise",
                diarias: 5,
                local: "Maragogi - AL",
                dataPartida: "05/02/2027",
                dataChegada: "10/02/2027",
                informacoesHotel: "Hotel 4 estrelas próximo às piscinas naturais.",
                imagemNome: "water.waves",
                preco: 2599
        ),
        
        PacoteViagem(
            titulo: "Recife Histórico",
            diarias: 4,
            local: "Recife - PE",
            dataPartida: "15/03/2027",
            dataChegada: "19/03/2027",
            informacoesHotel: "Hospedagem no Recife Antigo.",
            imagemNome: "building.columns.fill",
            preco: 1899
        ),

        PacoteViagem(
            titulo: "Maceió dos Sonhos",
            diarias: 6,
            local: "Maceió - AL",
            dataPartida: "20/04/2027",
            dataChegada: "26/04/2027",
            informacoesHotel: "Hotel frente mar na Pajuçara.",
            imagemNome: "beach.umbrella.fill",
            preco: 2799
        ),
        
        PacoteViagem(
            titulo: "Fernando de Noronha",
            diarias: 5,
            local: "Fernando de Noronha - PE",
            dataPartida: "10/05/2027",
            dataChegada: "15/05/2027",
            informacoesHotel: "Pousada ecológica premium.",
            imagemNome: "tropicalstorm",
            preco: 4999
        )

    ]
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
