//
//  TrendingMovieResponse.swift
//  Movier
//
//  Created by Ricardo Sanchez-Macias on 4/2/24.
//

import Foundation

struct TrendingMovieResponse: Codable {
    
    let page: Int
    let movies: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
}
