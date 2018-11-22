//
//  TileDownloading.swift
//  DownloadManager
//
//  Created by Ivan Cheung on 11/21/18.
//  Copyright © 2018 ivan_man-kit-cheung. All rights reserved.
//

import Foundation
import Queuer

protocol TileProvidingDelegate: class {
//    func didComplete
}

protocol TileProviding {
    func add(tile: Tile) -> TileRequest
}

class TileProvider: TileProviding {
    
    var delegate: TileProvidingDelegate?
    
    private let queuer: Queuer = Queuer.shared
//    private let pendingOperations = SimpleQueue()
    
    func add(tile: Tile) -> TileRequest {
        let request = TileRequest(tile: tile)
        let operation = TileDownloadOperation(request)
        
        queuer.addOperation(operation)
//        pendingOperations.downloadQueue.addOperation(operation)
        
        return request
    }
}
