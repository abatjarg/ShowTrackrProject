//
//  ShowItem.swift
//  ShowTrackr
//
//  Created by abatjarg on 12/15/19.
//  Copyright © 2019 abatjarg. All rights reserved.
//

import Foundation

public struct ShowsItemResponse: Codable {
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [ShowItem]
}

public struct ShowItem: Hashable, Codable {
    public let id: Int
    public let name: String
    public let backdropPath: String?
    public let posterPath: String?
    public let overview: String
    public let genres: [ShowGenre]?
    public let seasons: [ShowSeason]?
    public let casts: [ShowCast]?
    
    public func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }

    public static func == (lhs: ShowItem, rhs: ShowItem) -> Bool {
      return lhs.identifier == rhs.identifier
    }

    private let identifier = UUID()
    
    public var posterURL: URL? {
        if let _ = posterPath {
            return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
        } else {
            return nil
        }
    }
    
    public var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath ?? "")")!
    }
    
    public struct ShowGenre: Codable {
        let name: String
    }
    
    public struct ShowSeason: Codable {
//        public let id: Int
        public let name: String
        public let overview: String?
        public let posterPath: String?
        
        public var posterURL: URL? {
            if let _ = posterPath {
                return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
            } else {
                return nil
            }
        }
    }
    
    public struct ShowCast: Codable {
        public let character: String
        public let name: String

        public let profilePath: String?
        
        public var profileURL: URL? {
            guard let profilePath = profilePath else {
                return nil
            }
            
            return URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)")!
        }
        
    }
    
    public struct ShowVideoResponse: Codable {
        public let results: [ShowVideo]
    }
    
    public struct ShowCreditResponse: Codable {
        public let cast: [ShowCast]
    }

    public struct ShowVideo: Codable {
        public let id: String
        public let key: String
        public let name: String
        public let site: String
        public let size: Int
        public let type: String
        
        public var youtubeURL: URL? {
            guard site == "YouTube" else {
                return nil
            }
            return URL(string: "https://www.youtube.com/watch?v=\(key)")
        }
        
        public var thumbnailUrl: URL? {
            return URL(string: "http://img.youtube.com/vi/\(key)/0.jpg")
        }
    }
    
}
