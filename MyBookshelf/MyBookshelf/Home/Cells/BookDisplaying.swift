//
//  BookDisplaying.swift
//  MyBookshelf
//
//  Created by József Vesza on 2021. 04. 15..
//

import UIKit
import ImageLoader

protocol BookDisplaying: UICollectionViewCell {
    var viewData: HomeItemViewData? { get set }
    var imageLoader: ImageLoader? { get set }
}
