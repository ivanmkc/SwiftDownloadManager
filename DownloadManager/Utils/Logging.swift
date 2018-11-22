//
//  Logging.swift
//  WorldWiser
//
//  Created by Ivan Cheung on 2018-09-13.
//  Copyright © 2018 Ivan Cheung. All rights reserved.
//

import Foundation

enum LogLevel: String {
    case debug, info, error, fault
}

enum LogCategory: String {
    case TilePipeline, NearbyPOIs, Details, FavoritePOIs, Category, Thumbnail, PageViews, Other, Plotting
}

protocol Logging {
    func Log(_ message: StaticString, _ messageArguments: CVarArg..., type: LogLevel, category: LogCategory)
    func Log(_ message: StaticString, _ messageArguments: CVarArg..., type: LogLevel)
    func SignpostBegin(_ name: StaticString, id: AnyObject, category: LogCategory)
    func SignpostBegin(_ name: StaticString, id: AnyObject, category: LogCategory, _ message: StaticString, _ messageArguments: CVarArg...)
    func SignpostEnd(_ name: StaticString, id: AnyObject, category: LogCategory)
    func SignpostEnd(_ name: StaticString, id: AnyObject, category: LogCategory, _ message: StaticString, _ messageArguments: CVarArg...)
    func SignpostEvent(_ name: StaticString, id: AnyObject, category: LogCategory, _ message: StaticString, _ messageArguments: CVarArg...)
}
