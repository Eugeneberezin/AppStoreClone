//
//  AppGroup.swift
//  AppStoreClone
//
//  Created by Eugene Berezin on 11/9/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let name, artistName, artworkUrl100: String
}
