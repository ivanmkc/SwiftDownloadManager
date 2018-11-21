//
//  ImageDownloader.swift
//  DownloadManager
//
//  Created by ivan_man-kit-cheung on 11/17/18.
//  Copyright © 2018 ivan_man-kit-cheung. All rights reserved.
//

import Foundation

// From: https://blog.infullmobile.com/basics-of-operations-and-operation-queues-in-ios-a8e7b02950c3
class TileDownloadOperation: AsyncOperation {
    //1
    let request: TileRequest
    
    //2
    init(_ request: TileRequest) {
        self.request = request
    }

    //3
    override func main() {
        //4
        if isCancelled {
            return
        }

        //5 Download the tile info
        request.status = .processing

        let timer = Timer(timeInterval: 3, repeats: false) { [weak self] (_) in
            guard let weakSelf = self,
                !weakSelf.isCancelled
                else {
                    self?.state = .finished
                    return
                }

            let request = weakSelf.request

            request.status = TileRequestStatus.success(result: request.tile.description)
            self?.state = .finished
        }

        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        RunLoop.current.run()
    }
}
