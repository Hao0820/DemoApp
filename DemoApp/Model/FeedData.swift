//
//  FeedData.swift
//  DemoApp
//
//  Created by WESLEY on 2020/2/14.
//  Copyright © 2020 Wesley. All rights reserved.
//

import Foundation

struct Media: Decodable {
    let m: URL
}
struct Item: Decodable {
    let title: String
    let media: Media
}
struct FeedData: Decodable {
    let items: [Item]
}
