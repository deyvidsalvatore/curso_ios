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

struct DetalheView: View {
    let pacote: PacoteViagem
    
    @Binding var favoritos: [UUID]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                Image(systemName: pacote.imagemNome)
                    .font(.system(size: 120))
                    .foregroundColor(.blue)
                
                Text(pacote.local)
                    .foregroundStyle(.blue)
                
                Text(pacote.titulo)
                    .font(.largeTitle)
                    .bold()
                
                HStack {
                    VStack {
                        Text("Partida")
                        Text(pacote.dataPartida)
                            .bold()
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("Duração")
                        Text("\(pacote.diarias) dias")
                            .bold()
                    }
                    
                    Spacer()
                    
                    
                    VStack {
                        Text("Retorno")
                        Text(pacote.dataChegada)
                            .bold()
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Hospedagem")
                        .font(.title2)
                        .bold()
                    
                    Text(
                        pacote.informacoesHotel
                    )
                }
                
                Button {
                    if favoritos.contains(pacote.id) {
                        favoritos.removeAll {
                            $0 == pacote.id
                        }
                    } else {
                        favoritos.append(pacote.id)
                    }
                } label: {
                    Label(
                        favoritos.contains(pacote.id)
                        ? "Remover Favorito"
                        : "Adicionar Favorito",
                        systemImage:
                            favoritos.contains(pacote.id)
                        ? "heart.fill"
                        : "heart"
                    )
                }
                
                Button {
                    
                } label: {
                    Text(
                        "Reservar por \(pacote.preco.formatted(.currency(code: "BRL")))"
                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                }
            }
            .padding()
        }
        .navigationTitle("Detalhes")
    }
}

struct FavoritosView: View {
    let pacotes: [PacoteViagem]
    @Binding var favoritos: [UUID]

    var pacotesFavoritos: [PacoteViagem] {
        pacotes.filter { favoritos.contains($0.id) }
    }

    var body: some View {

        if pacotesFavoritos.isEmpty {

            VStack {

                Spacer()

                Image(systemName: "heart.slash")
                    .font(.system(size: 60))

                Text("Nenhum pacote favoritado")
                    .font(.title3)

                Spacer()
            }
            .navigationTitle("Meus Favoritos")

        } else {

            List(pacotesFavoritos) { pacote in

                NavigationLink {

                    DetalheView(
                        pacote: pacote,
                        favoritos: .constant(favoritos)
                    )

                } label: {

                    HStack(spacing: 15) {

                        Image(systemName: pacote.imagemNome)
                            .font(.system(size: 40))
                            .frame(width: 80)

                        VStack(alignment: .leading, spacing: 5) {

                            Text(pacote.titulo)
                                .font(.headline)

                            Text(pacote.local)
                                .foregroundColor(.gray)

                            Text("\(pacote.diarias) diárias")
                                .foregroundColor(.blue)

                            Text(
                                pacote.preco,
                                format: .currency(code: "BRL")
                            )
                            .foregroundColor(.green)
                        }

                        Spacer()

                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Meus Favoritos")
        }
    }
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
    
    @State private var favoritos: [UUID] = []
    
    var body: some View {

        NavigationStack {

            List(pacotes) { pacote in

                NavigationLink {

                    DetalheView(
                        pacote: pacote,
                        favoritos: $favoritos
                    )

                } label: {

                    HStack {

                        Image(pacote.imagemNome)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 15))

                        VStack(alignment: .leading) {

                            Text(pacote.titulo)
                                .font(.headline)

                            Text(pacote.local)
                                .foregroundColor(.gray)

                            Text("\(pacote.diarias) diárias")
                                .foregroundColor(.blue)

                            Text(
                                pacote.preco,
                                format: .currency(code: "BRL")
                            )
                            .foregroundColor(.green)
                        }

                        Spacer()

                        Button {

                            if favoritos.contains(pacote.id) {
                                favoritos.removeAll {
                                    $0 == pacote.id
                                }
                            } else {
                                favoritos.append(pacote.id)
                            }

                        } label: {

                            Image(
                                systemName:
                                    favoritos.contains(pacote.id)
                                ? "heart.fill"
                                : "heart"
                            )
                            .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Explorar Viagens")
            .toolbar {

                NavigationLink {
                    FavoritosView(
                        pacotes: pacotes,
                        favoritos: $favoritos
                    )
                

                } label: {

                    Label(
                        "\(favoritos.count)",
                        systemImage: "heart.fill"
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

