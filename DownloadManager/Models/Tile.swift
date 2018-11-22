//
//  File.swift
//  DownloadManager
//
//  Created by ivan_man-kit-cheung on 11/17/18.
//  Copyright © 2018 ivan_man-kit-cheung. All rights reserved.
//

import Foundation
import MapKit

struct Tile: Equatable, CustomStringConvertible {
    
    var description: String {
        return "ne:(\(neCoordinate.longitude), \(neCoordinate.latitude)), sw:(\(swCoordinate.longitude), \(swCoordinate.latitude))"
    }
    
    var neCoordinate: CLLocationCoordinate2D
    var swCoordinate: CLLocationCoordinate2D
    
    static func == (lhs: Tile, rhs: Tile) -> Bool {
        return lhs.neCoordinate == rhs.swCoordinate
    }
}
