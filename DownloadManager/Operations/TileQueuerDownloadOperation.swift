//
//  TileQueuerDownloadOperation.swift
//  DownloadManager
//
//  Created by Ivan Cheung on 11/22/18.
//  Copyright © 2018 ivan_man-kit-cheung. All rights reserved.
//

import Foundation
import Queuer

// From: https://blog.infullmobile.com/basics-of-operations-and-operation-queues-in-ios-a8e7b02950c3
class TileQueuerDownloadOperation: ConcurrentOperation {
    //1
    let request: TileRequest
    
    //2
    init(_ request: TileRequest) {
        self.request = request
    }
    
    //3
    override func execute() {
        //4
        if isCancelled {
            return
        }
        
        //5 Download the tile info
        request.status = .processing
        
        let timer = Timer(timeInterval: 3, repeats: false) { [weak self] (_) in
            guard let weakSelf = self else { return }
            guard !weakSelf.isCancelled else {
                weakSelf.request.status = .cancelled
                weakSelf.finish(false)
                return
            }
            
            let request = weakSelf.request
            
            request.status = TileRequestStatus.success(result: request.tile.description)
            weakSelf.finish(false)
        }
        
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        RunLoop.current.run()
    }
}


