//
//  ImageDownloader.swift
//  DownloadManager
//
//  Created by ivan_man-kit-cheung on 11/17/18.
//  Copyright © 2018 ivan_man-kit-cheung. All rights reserved.
//

import Foundation

class TileDownloadOperationSync: Operation {
  //1
  let request: TileRequest

  private var timer: Timer?

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

    sleep(2)
    
    request.status = TileRequestStatus.success(result: request.tile.description)
  }
}
