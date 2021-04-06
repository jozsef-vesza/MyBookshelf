//
//  API.swift
//  iTunesClient
//
//  Created by József Vesza on 2021. 04. 06..
//

import Foundation

import Foundation
import Combine

// MARK: - Endpoints

public enum Endpoint {
    case topFreeBooks
    case topPaidBooks
    case topAudiobooks
}

extension Endpoint {
    var url: URL {
        switch self {
        case .topFreeBooks:
            return URL(string: "https://rss.itunes.apple.com/api/v1/us/books/top-free/all/10/explicit.json")!
        case .topPaidBooks:
            return URL(string: "https://rss.itunes.apple.com/api/v1/us/books/top-paid/all/10/explicit.json")!
        case .topAudiobooks:
            return URL(string: "https://rss.itunes.apple.com/api/v1/us/audiobooks/top-audiobooks/all/10/explicit.json")!
        }
    }
}

public class iTunesClient {
    let urlSession: URLSession = .shared
    
    public init() {}
    
    public func loadBooks(from endpoint: Endpoint) -> AnyPublisher<[Book], Never> {
        return urlSession
            .dataTaskPublisher(for: endpoint.url)
            .map(\.data)
            .tryMap { data -> [Book] in
                let response = try JSONDecoder().decode(Response.self, from: data)
                return response.feed?.results ?? []
            }
            .catch { _ in
                return Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
