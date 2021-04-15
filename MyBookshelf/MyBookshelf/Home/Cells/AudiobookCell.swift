//
//  AudiobookCell.swift
//  MyBookshelf
//
//  Created by József Vesza on 2021. 04. 06..
//

import UIKit
import ImageLoader

class AudiobookCell: UICollectionViewCell, BookDisplaying {
    static let reuseIdentifier = "AudiobookCell"
    
    var viewData: HomeItemViewData? {
        didSet {
            titleLabel.text = viewData?.title
            authorLabel.text = viewData?.author
            if let url = viewData?.thumbnailURL {
                _ = imageLoader?.loadImageURL(url, into: imageView)
            }
        }
    }
    
    var imageLoader: ImageLoader?
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
}
