//
//  SearchResult.swift
//  AppStoreClone
//
//  Created by Eugene Berezin on 10/27/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
    var avarageUserrating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String // app icon
}

