//
//  HomeViewModel.swift
//  MyBookshelf
//
//  Created by József Vesza on 2021. 04. 06..
//

import Foundation
import Combine
import iTunesClient

struct HomeViewData {
    struct Section {
        let title: String
        let books: [Book]
    }
    
    let sections: [Section]
}

final class HomeViewModel: ObservableObject {
    @Published var viewData: HomeViewData = HomeViewData(sections: [])
    
    let client = iTunesClient()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        $viewData
            .handleEvents(receiveSubscription: { _ in
                self.loadBooks()
            })
            .sink(receiveValue: { _ in })
            .store(in: &subscriptions)
    }
    
    func loadBooks() {
        let topFreeBooksPublisher = client.loadBooks(from: .topFreeBooks)
        let topPaidPublisher = client.loadBooks(from: .topPaidBooks)
        let topAudiobooksPublisher = client.loadBooks(from: .topAudiobooks)
        
        Publishers
            .CombineLatest3(topFreeBooksPublisher, topPaidPublisher, topAudiobooksPublisher)
            .sink(receiveValue: { [weak self] (topFree, topPaid, topAudio) in
                self?.viewData = HomeViewData(sections: [
                    HomeViewData.Section(title: "Top Free Books", books: topFree),
                    HomeViewData.Section(title: "Top Paid Books", books: topPaid),
                    HomeViewData.Section(title: "Top Audiobooks", books: topAudio)
                ])
            })
            .store(in: &subscriptions)
    }
}
