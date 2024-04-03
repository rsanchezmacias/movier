//
//  MovieManagerTests.swift
//  MovierTests
//
//  Created by Ricardo Sanchez-Macias on 4/2/24.
//

import XCTest
@testable import Movier

final class MovieManagerTests: XCTestCase {
    
    private var movieService: MockMovieService!
    
    private var sut: MovieManager!
    
    override func setUp() {
        super.setUp()
        
        movieService = MockMovieService()
        
        sut = MovieManager(movieService: movieService)
    }
    
    func testFetchMovies() {
        XCTAssertEqual(sut.movies.value.count, 1)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
}
