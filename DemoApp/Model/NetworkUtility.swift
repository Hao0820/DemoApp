//
//  NetworkUtility.swift
//  PhotoDemo
//
//  Created by SHIH-YING PAN on 2019/1/11.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import UIKit

struct NetworkUtility {
    static func downloadImage(url: URL, handler: @escaping (UIImage?) -> ()) {
        
        if let image = CacheManager.shared.getFromCache(key: url.path) as? UIImage {
            handler(image)
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                CacheManager.shared.cache(object: image, key: url.path)
                handler(image)
            } else {
                handler(nil)
            }
        }
        task.resume()
    }
}
