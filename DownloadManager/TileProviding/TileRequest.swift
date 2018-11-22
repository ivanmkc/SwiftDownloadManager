//
//  TileRequest.swift
//  DownloadManager
//
//  Created by ivan_man-kit-cheung on 11/17/18.
//  Copyright © 2018 ivan_man-kit-cheung. All rights reserved.
//

import Foundation

enum TileRequestStatus {
    case notStarted
    case processing
    case success(result: String)
    case cancelled
    case failure(error: Error)
}

class TileRequest {
    let tile: Tile
    
    var status: TileRequestStatus = .notStarted
    
    init(tile: Tile) {
        self.tile = tile
    }
}
