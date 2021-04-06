//
//  ImageLoader.swift
//  ImageLoader
//
//  Created by József Vesza on 2021. 04. 06..
//

import UIKit

final class ImageLoader {
    private var imageDownloadTasks: [UUID : URLSessionDataTask] = [:]
    
    public func loadImageURL(_ url: URL, into imageView: UIImageView) -> UUID {
        let token = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
        
        task.resume()
        
        imageDownloadTasks[token] = task
        
        return token
    }
    
    public func cancelLoading(token: UUID) {
        imageDownloadTasks[token]?.cancel()
    }
}
