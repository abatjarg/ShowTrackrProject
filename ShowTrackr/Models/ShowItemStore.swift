//
//  MovieItemStore.swift
//  UICollectionViewCompositionalLayoutShowTrackr
//
//  Created by abatjarg on 12/21/19.
//  Copyright © 2019 abatjarg. All rights reserved.
//

import UIKit

class ShowItemStore: ShowService {
    
    public static let shared = ShowItemStore()
    private init() {}
    private let apiKey = "0e7bf9123871b0fe728caf5636fd7e47"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    public func fetchShows(from endpoint: Endpoint, params: [String: String]? = nil, successHandler: @escaping (_ response: ShowsItemResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void){
        
        guard var urlComponents = URLComponents(string: "\(baseAPIURL)/tv/\(endpoint.rawValue)") else {
            errorHandler(ShowError.invalidEndpoint)
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value)})
        }
        
        urlComponents.queryItems = queryItems
    
        guard let url = urlComponents.url else {
             errorHandler(ShowError.invalidEndpoint)
             return
        }
        
        urlSession.dataTask(with: url) {(data, response, error) in
            if error != nil {
                self.handleError(errorHandler: errorHandler, error: ShowError.apiError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.handleError(errorHandler: errorHandler, error: ShowError.invalidResponse)
                return
            }
            
            guard let data = data else {
                self.handleError(errorHandler: errorHandler, error: ShowError.noData)
                return
            }
            
            do {
                let showsResponse = try self.jsonDecoder.decode(ShowsItemResponse.self, from: data)
                DispatchQueue.main.async {
                    successHandler(showsResponse)
                }
            } catch {
                self.handleError(errorHandler: errorHandler, error: ShowError.serializationError)
            }
        }.resume()
    }
    
    public func fetchRelated(id: Int, successHandler: @escaping (_ response: ShowsItemResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void) {
        guard let url = URL(string: "\(baseAPIURL)/tv/\(id)/recommendations?api_key=\(apiKey)&language=en-US&page=1") else {
            handleError(errorHandler: errorHandler, error: ShowError.invalidEndpoint)
            return
        }
    
        urlSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.handleError(errorHandler: errorHandler, error: ShowError.apiError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.handleError(errorHandler: errorHandler, error: ShowError.invalidResponse)

                return
            }
            
            guard let data = data else {
                self.handleError(errorHandler: errorHandler, error: ShowError.noData)
                return
            }
            
            do {
                let shows = try self.jsonDecoder.decode(ShowsItemResponse.self, from: data)
                DispatchQueue.main.async {
                    successHandler(shows)
                }
            } catch {
                self.handleError(errorHandler: errorHandler, error: ShowError.serializationError)
            }
        }.resume()
    
    }
    
    public func fetchTrailers(id: Int, successHandler: @escaping (_ response: ShowItem.ShowVideoResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void) {
        guard let url = URL(string: "\(baseAPIURL)/tv/\(id)/videos?api_key=\(apiKey)&language=en-US&page=1") else {
            handleError(errorHandler: errorHandler, error: ShowError.invalidEndpoint)
            return
        }
    
        urlSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.handleError(errorHandler: errorHandler, error: ShowError.apiError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.handleError(errorHandler: errorHandler, error: ShowError.invalidResponse)

                return
            }
            
            guard let data = data else {
                self.handleError(errorHandler: errorHandler, error: ShowError.noData)
                return
            }
            
            do {
                let movie = try self.jsonDecoder.decode(ShowItem.ShowVideoResponse.self, from: data)
                DispatchQueue.main.async {
                    successHandler(movie)
                }
            } catch {
                self.handleError(errorHandler: errorHandler, error: ShowError.serializationError)
            }
        }.resume()
    
    }
    
    public func fetchCast(id: Int, successHandler: @escaping (_ response: ShowItem.ShowCreditResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void) {
        guard let url = URL(string: "\(baseAPIURL)/tv/\(id)/credits?api_key=\(apiKey)&language=en-US&page=1") else {
            handleError(errorHandler: errorHandler, error: ShowError.invalidEndpoint)
            return
        }
    
        urlSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.handleError(errorHandler: errorHandler, error: ShowError.apiError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.handleError(errorHandler: errorHandler, error: ShowError.invalidResponse)

                return
            }
            
            guard let data = data else {
                self.handleError(errorHandler: errorHandler, error: ShowError.noData)
                return
            }
            
            do {
                let creditResponse = try self.jsonDecoder.decode(ShowItem.ShowCreditResponse.self, from: data)
                DispatchQueue.main.async {
                    successHandler(creditResponse)
                }
            } catch {
                self.handleError(errorHandler: errorHandler, error: ShowError.serializationError)
            }
        }.resume()
    
    }
    
    public func fetchShow(id: Int, successHandler: @escaping (_ response: ShowItem) -> Void, errorHandler: @escaping(_ error: Error) -> Void) {
        guard let url = URL(string: "\(baseAPIURL)/tv/\(id)?api_key=\(apiKey)&append_to_response=videos,credits") else {
            handleError(errorHandler: errorHandler, error: ShowError.invalidEndpoint)
            return
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.handleError(errorHandler: errorHandler, error: ShowError.apiError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.handleError(errorHandler: errorHandler, error: ShowError.invalidResponse)

                return
            }
            
            guard let data = data else {
                self.handleError(errorHandler: errorHandler, error: ShowError.noData)
                return
            }
            
            do {
                let movie = try self.jsonDecoder.decode(ShowItem.self, from: data)
                DispatchQueue.main.async {
                    successHandler(movie)
                }
            } catch {
                self.handleError(errorHandler: errorHandler, error: ShowError.serializationError)
            }
        }.resume()
    
    }
    
    public func searchShows(query: String, params: [String : String]?, successHandler: @escaping (ShowsItemResponse) -> Void, errorHandler: @escaping (Error) -> Void) {
        
        guard var urlComponents = URLComponents(string: "\(baseAPIURL)/search/tv") else {
            errorHandler(ShowError.invalidEndpoint)
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                          URLQueryItem(name: "language", value: "en-US"),
                          URLQueryItem(name: "include_adult", value: "false"),
                          URLQueryItem(name: "region", value: "US"),
                          URLQueryItem(name: "query", value: query)
                          ]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            errorHandler(ShowError.invalidEndpoint)
            return
        }
        
        print("\(url)")
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.handleError(errorHandler: errorHandler, error: ShowError.apiError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.handleError(errorHandler: errorHandler, error: ShowError.invalidResponse)
                return
            }
            
            guard let data = data else {
                self.handleError(errorHandler: errorHandler, error: ShowError.noData)
                return
            }
            
            do {
                let moviesResponse = try self.jsonDecoder.decode(ShowsItemResponse.self, from: data)
                print("\(moviesResponse.results.count)")
                DispatchQueue.main.async {
                    successHandler(moviesResponse)
                }
            } catch {
                print("Erro")
                self.handleError(errorHandler: errorHandler, error: ShowError.serializationError)
            }
            }.resume()
        
    }
    
    private func handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
        DispatchQueue.main.async {
            errorHandler(error)
        }
    }
    


}
