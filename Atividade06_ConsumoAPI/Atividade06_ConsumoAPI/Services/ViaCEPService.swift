import Foundation

final class ViaCEPService {
    func buscarCEP(_ cep: String) async throws -> ViaCEPResponse {
        let url = URL(
            string: "https://viacep.com.br/ws/\(cep)/json/"
        )!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode(
            ViaCEPResponse.self,
            from: data
        )
    }
}
