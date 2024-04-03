//
//  MockMovieService.swift
//  MovierTests
//
//  Created by Ricardo Sanchez-Macias on 4/2/24.
//

import Foundation
@testable import Movier

class MockMovieService: MovieServiceProtocol {
    
    func fetchTrendingMovies() async throws -> [Movier.Movie] {
        return [Movie(
            id: 0,
            title: "hello",
            adult: false,
            backdropPath: "path",
            originalLanguage: .en,
            originalTitle: "title",
            overview: "none",
            posterPath: "some_paht",
            mediaType: .movie,
            genreIDS: [0, 1],
            popularity: 10,
            releaseDate: "2021",
            video: false,
            voteAverage: 10,
            voteCount: 1000
        )]
    }
    
}
