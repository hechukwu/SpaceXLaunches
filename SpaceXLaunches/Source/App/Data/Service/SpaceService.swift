import Foundation

public typealias Identifier = String

public class SpaceService {

    // MARK: Private properties

    private static let apiKey = ""
    private static let baseURL = "https://api.spacexdata.com/v4/"
    private var session: URLSession

    // MARK: Public properties

    public private(set) lazy var launcherFetcher: LauncherFetcher = LauncherFetcher(service: self)

    // MARK: class initializer

    public init() {
        self.session = URLSession.shared
    }

    internal func sendGetRequest(table: String,
                                 offset: Identifier?,
                                 completion: @escaping (Result<Data, Error>) -> Void) {
        guard
            var components = URLComponents(string: SpaceService.baseURL + table)
            else { return }

        if let offset = offset {
            components.queryItems = [URLQueryItem(name: "offset",
                                                  value: offset)]
        }

        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

        guard
            let url = components.url
            else { return }

        var request = URLRequest(url: url)

        request.addValue("Bearer \(SpaceService.apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = session.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }

            guard let content = data else { return }
            DispatchQueue.main.async {
                completion(.success(content))
            }
        }

        task.resume()
    }

}

    enum AppError: Error, LocalizedError {

        case badRequestData
        case badUrl
        case endpointError(message: String)
        case emptyResponseData
        case unDecodableResponse
        case unknownError
        case networkError

        public var errorDescription: String? {
            switch self {
            case .badRequestData:
                return "The correct data could not be sent"
            case .badUrl:
                return "Incorrect destination"
            case .endpointError(let message):
                return message
            case .emptyResponseData:
                return "Response is empty"
            case .unDecodableResponse:
                return "The response could not be decoded"
            case .unknownError:
                return "An error occurred"
            case .networkError:
                return "Check your internet connection"
            }
        }

    }

//extension JSONDecoder {
//
//
//     To remove the step of first converting to Data before calling JSONDecoder.decode() everywhere
//     */
//    func decode<T: Decodable>(_ type: T.Type, from dictionary: Dictionary<String, Any?>) -> T? {
//        do {
//            let data = try JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
//            return try decode(type, from: data)
//        }
//        catch {
//            print(error)
//            return nil
//        }
//    }
//}
