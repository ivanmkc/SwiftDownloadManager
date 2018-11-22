//
//  CL2Coordinate2D+extensions.swift
//  DownloadManager
//
//  Created by Ivan Cheung on 11/21/18.
//  Copyright © 2018 ivan_man-kit-cheung. All rights reserved.
//

import MapKit

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude
    }
}
