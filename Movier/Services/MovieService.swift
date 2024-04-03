//
//  MovieService.swift
//  Movier
//
//  Created by Ricardo Sanchez-Macias on 4/2/24.
//

import Combine
import Foundation

protocol MovieServiceProtocol {
    
    func fetchTrendingMovies() async throws -> [Movie]
    
}

class MovieService: MovieServiceProtocol {
    
    private var dataTaskFactory: DataTaskFactoryProtocol!
    private var requestFactory: RequestFactoryProtocol!
    
    private var authorization: String?
    
    init(
        dataTaskFactory: DataTaskFactoryProtocol,
        requestFactory: RequestFactoryProtocol
    ) {
        self.dataTaskFactory = dataTaskFactory
        self.requestFactory = requestFactory
        
        loadAuthorization()
    }
    
    func fetchTrendingMovies() async throws -> [Movie] {
        let urlPath = "\(Constants.Network.serverURL)\(self.trendingServicePath())"
        
        guard let url = URL(string: urlPath) else {
            throw MovierError.urlFormatError
        }
        
        guard let authorization = authorization else {
            throw MovierError.missingAccessToken
        }
        
        let languageQueryItem = [URLQueryItem(name: "language", value: "en-US")]
        let request = requestFactory.request(
            method: .get,
            serviceURL: url,
            queryItems: languageQueryItem,
            body: nil,
            authentication: authorization
        )
        
        return try await withCheckedThrowingContinuation { [weak self] continuation in
            guard let self = self else { return }
            self.dataTaskFactory.dataTask(forSession: .shared, request: request, resultType: TrendingMovieResponse.self) { response, _, _ in
                continuation.resume(returning: response.movies)
            } onFail: { _, _, _ in
                continuation.resume(throwing: MovierError.httpError)
            }.resume()
        }
        
    }
    
    private func loadAuthorization() {
        guard let resourcePListPath = Bundle.main.url(forResource: Constants.Files.tmdbPlist, withExtension: "plist") else {
            return
        }
        
        if let resourceDict = try? NSDictionary(contentsOf: resourcePListPath, error: ()) {
            authorization = resourceDict["accessToken"] as? String
        }
    }
    
}

extension MovieService {
    
    fileprivate func trendingServicePath() -> String {
        return "trending/movie/day"
    }
    
}
