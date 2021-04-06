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
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.$viewData.sink {
            print($0.sections)
        }
        .store(in: &subscriptions)
    }
}
