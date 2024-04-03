//
//  MovieManager.swift
//  Movier
//
//  Created by Ricardo Sanchez-Macias on 4/2/24.
//

import Foundation
import Combine

protocol MovieManagerProtocol {
    
    var movies: CurrentValueSubject<[Movie], Never> { get }
    
}

class MovieManager: MovieManagerProtocol {
    
    private var movieService: MovieServiceProtocol
    
    private(set) var movies: CurrentValueSubject<[Movie], Never>
    
    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
        
        movies = CurrentValueSubject([])
        fetchTrendingMovies()
    }
    
    private func fetchTrendingMovies() {
        Task { [weak self] in
            guard let self = self else { return }
            
            do {
                let movies = try await self.movieService.fetchTrendingMovies()
                self.movies.send(movies)
                print(movies)
            } catch {
                print("Error \(error)")
            }
        }
    }
    
}
