//
//  HomeViewController.swift
//  MyBookshelf
//
//  Created by József Vesza on 2021. 04. 06..
//

import UIKit
import Combine
import ImageLoader

class HomeViewController: UIViewController {

    let viewModel = HomeViewModel()
    let imageLoader = ImageLoader()
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        viewModel.$viewData
            .receive(on: DispatchQueue.main)
            .sink { [weak collectionView] _ in
                collectionView?.reloadData()
        }
        .store(in: &subscriptions)
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: BookCell.reuseIdentifier, bundle: nil),
                                forCellWithReuseIdentifier: BookCell.reuseIdentifier)
        collectionView.register(UINib(nibName: AudiobookCell.reuseIdentifier, bundle: nil),
                                forCellWithReuseIdentifier: AudiobookCell.reuseIdentifier)
        
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
        let cell: BookDisplaying
        
        switch indexPath.section {
        case 2:
            guard let audioBookCell = collectionView.dequeueReusableCell(withReuseIdentifier: AudiobookCell.reuseIdentifier, for: indexPath) as? AudiobookCell else {
                fatalError("Failed to dequeue `AudiobookCell`")
            }
            cell = audioBookCell
        default:
            guard let bookCell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCell.reuseIdentifier, for: indexPath) as? BookCell else {
                fatalError("Failed to dequeue `BookCell`")
            }
            cell = bookCell
        }
        
        cell.imageLoader = imageLoader
        cell.viewData = viewModel.viewData(for: indexPath)
        
        return cell
    }
}
