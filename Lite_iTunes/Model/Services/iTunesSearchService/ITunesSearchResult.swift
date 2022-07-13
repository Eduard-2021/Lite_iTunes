//
//  ITunesSearchResult.swift
//  Lite_iTunes
//
//  Created by Eduard on 25.08.2021.
//

import Foundation

struct ITunesSearchResult<Element: Codable>: Codable {
    let resultCount: Int
    let results: [Element]
}
