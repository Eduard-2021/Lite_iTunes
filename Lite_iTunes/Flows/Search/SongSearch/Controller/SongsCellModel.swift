//
//  SongsCellModel.swift
//  Lite_iTunes
//
//  Created by Eduard on 01.09.2021.
//

import UIKit

struct SongCellModel {
    let trackName: String
    let artistName: String?
}

final class SongsCellModelFactory {
    
    static func cellModel(from model: ITunesSong) -> SongCellModel {
        return SongCellModel(trackName: model.trackName,
                             artistName: model.artistName)
    }
}

