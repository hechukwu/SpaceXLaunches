import Foundation

public class LauncherFetcher {

    // MARK: properties

    private var offset: Identifier?

    private weak var service: SpaceService?

    // class initializer

    internal init(service: SpaceService) {
        self.offset = nil
        self.service = service
    }

    public func fetchRocketLaunches(completion: @escaping (Result<[SpaceXLaunches], Error>) -> Void) {

        let urlSuffix = "launches"

        service?.sendGetRequest(table: urlSuffix,
                                offset: offset) { [weak self] result in
//            switch result {
//            case let .failure(error):
//                completion(.failure(error))
//
//            case let .success(plist):
//                if let result = self?.parsePropertyList(plist) {
//                    completion(result)
//                }
//            }
            self?.deserialize(result: result, completion: completion)
        }
    }

    // A helper function to parse the data

    private func deserialize<T: Decodable>(result: Result<Data, Error>, completion: ((Result<T, Error>) -> Void)? = nil) {

        switch result {
        case .success(let data):
            do {
                let responseString = String(data: data, encoding: .utf8)
                guard let result = responseString else { return }
//                let jsonData = data.data(using: .utf8)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(.iso8601Full)

                let rawDict = try decoder.decode(T.self , from: data)

                completion?(.success(rawDict))

            } catch {
                let dataAsString = String(data: data, encoding: .utf8) ?? "<No data>"
                print("ApiClient handleResponse() catch: error: \(error.localizedDescription)")

                completion?(.failure(AppError.unDecodableResponse))
            }
        case .failure(let error): completion?(.failure(error))

    }
    }
}
