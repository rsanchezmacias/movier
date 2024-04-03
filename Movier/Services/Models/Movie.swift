//
//  Movie.swift
//  Movier
//
//  Created by Ricardo Sanchez-Macias on 4/2/24.
//

import Foundation

enum MediaType: String, Codable {
    case movie = "movie"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case hi = "hi"
    case unknown
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        self = OriginalLanguage(rawValue: string) ?? .unknown
    }
    
}

struct Movie: Codable {
    
    let id: Int
    let title: String
    
    let adult: Bool
    let backdropPath: String
    let originalLanguage: OriginalLanguage
    let originalTitle: String
    let overview: String
    let posterPath: String
    let mediaType: MediaType
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

