//
//  ITunesSong.swift
//  Lite_iTunes
//
//  Created by Eduard on 25.08.2021.
//

import UIKit

public struct ITunesSong: Codable {
    
    public var trackName: String
    public var artistName: String?
    public var collectionName: String?
    public var artworkImage: String?
    public var previewUrl: String?
    public var releaseDate: String?
    public var trackTimeMillis: Int?
    public var primaryGenreName: String?
    // MARK: - Codable
    
    private enum CodingKeys: String, CodingKey {
        case trackName = "trackName"
        case artistName = "artistName"
        case collectionName = "collectionName"
        case artworkImage = "artworkUrl100"
        case previewUrl = "previewUrl"
        case releaseDate = "releaseDate"
        case trackTimeMillis = "trackTimeMillis"
        case primaryGenreName = "primaryGenreName"
    }
    
    // MARK: - Init
    
    internal init(trackName: String,
                  artistName: String?,
                  collectionName: String?,
                  artwork: String?,
                  previewUrl: String?,
                  releaseDate: String?,
                  trackTimeMillis: Int?,
                  primaryGenreName: String?
                  
    ) {
        self.trackName = trackName
        self.artistName = artistName
        self.collectionName = collectionName
        self.artworkImage = artwork
        self.previewUrl = previewUrl
        self.releaseDate = releaseDate
        self.trackTimeMillis = trackTimeMillis
        self.primaryGenreName = primaryGenreName
    }
}


