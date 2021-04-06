//
//  HomeViewController.swift
//  MyBookshelf
//
//  Created by József Vesza on 2021. 04. 06..
//

import UIKit
import Combine

class HomeViewController: UIViewController {

    let viewModel = HomeViewModel()
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.$viewData.sink {
            print($0.sections)
        }
        .store(in: &subscriptions)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.viewData.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.viewData.sections[section].books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
}
