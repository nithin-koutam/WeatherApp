import Foundation

protocol APIEndpoint {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension APIEndpoint {

    var url: URL? {

        var components = URLComponents(string: baseURL)

        components?.path = path
        components?.queryItems = queryItems

        return components?.url
    }
}

// Networking Protocol

protocol Networking {

    func request<T: Decodable>(
        endpoint: APIEndpoint,
        responseType: T.Type
    ) async throws -> T
}

// HTTP Client

final class HttpNetworking: Networking {

    func request<T: Decodable>(
        endpoint: APIEndpoint,
        responseType: T.Type
    ) async throws -> T {

        guard let url = endpoint.url else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
