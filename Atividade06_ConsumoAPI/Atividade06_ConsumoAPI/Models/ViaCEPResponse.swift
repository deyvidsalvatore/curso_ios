import Foundation

struct ViaCEPResponse : Codable {
    let cep: String
    let logradouro: String
    let complemento: String
    let bairro: String
    let localidade: String
    let uf: String
}
