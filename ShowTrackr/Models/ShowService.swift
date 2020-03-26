//
//  ShowService.swift
//  ShowTrackr
//
//  Created by abatjarg on 2/5/20.
//  Copyright © 2020 abatjarg. All rights reserved.
//

import Foundation

protocol ShowService {
    func fetchShows(from endpoint: Endpoint, params: [String: String]?, successHandler: @escaping (_ response: ShowsItemResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
    func fetchShow(id: Int, successHandler: @escaping (_ response: ShowItem) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
    func fetchRelated(id: Int, successHandler: @escaping (_ response: ShowsItemResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
    func fetchTrailers(id: Int, successHandler: @escaping (_ response: ShowItem.ShowVideoResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
    func fetchCast(id: Int, successHandler: @escaping (_ response: ShowItem.ShowCreditResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void) 
    func searchShows(query: String, params: [String: String]?, successHandler: @escaping (_ response: ShowsItemResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
}

public enum Endpoint: String, CustomStringConvertible, CaseIterable {
    case airingToday = "airing_today"
    case latest
    case popular
    case topRated = "top_rated"
    
    public var description: String {
        switch self {
        case .airingToday: return "Airing Today"
        case .latest: return "Latest"
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        }
    }
    

    public init?(index: Int) {
        switch index {
        case 0: self = .airingToday
        case 1: self = .popular
        case 2: self = .latest
        case 3: self = .topRated
        default: return nil
        }
    }
    
    public init?(description: String) {
        guard let first = Endpoint.allCases.first(where: { $0.description == description }) else {
            return nil
        }
        self = first
    }
    
}

public enum ShowError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}
