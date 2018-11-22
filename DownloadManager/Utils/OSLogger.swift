//
//  OSLogger.swift
//  WorldWiser
//
//  Created by Ivan Cheung on 2018-09-17.
//  Copyright © 2018 Ivan Cheung. All rights reserved.
//

import Foundation
import os.signpost

@available(iOS 12.0, *)
class OSLogger: Logging {
    private var logMap = [String: OSLog]()
    private let pointOfInterestLog = OSLog.init(subsystem: GlobalConstants.Subsystem, category: OSLog.Category.pointsOfInterest)
    private let accessQueue = DispatchQueue(label: "SynchronizedAccess", attributes: .concurrent)
    
    func GetCachedLog(_ category: LogCategory) -> OSLog {
        var log = OSLog(subsystem: GlobalConstants.Subsystem, category: category.rawValue)
        
        //TODO: Fix occassion deadlock here
        self.accessQueue.sync {
            if let existingLog = logMap[category.rawValue] {
                log = existingLog
            }
            else {
                self.accessQueue.async(flags:.barrier) { [weak self] in
                    self?.logMap[category.rawValue] = log
                }
            }
        }
        
        return log
    }
    
    func Log(_ message: StaticString, _ messageArguments: CVarArg..., type: LogLevel) {
        let logType: OSLogType
        switch type {
        case .debug:
            logType = .debug
        case .info:
            logType = .info
        case .error:
            logType = .error
        case .fault:
            logType = .fault
        }
        
        os_log(logType, message, messageArguments)
    }
    
    func Log(_ message: StaticString, _ messageArguments: CVarArg..., type: LogLevel, category: LogCategory) {
        let logType: OSLogType
        switch type {
        case .debug:
            logType = .debug
        case .info:
            logType = .info
        case .error:
            logType = .error
        case .fault:
            logType = .fault
        }
        
        let log = GetCachedLog(category)
        
        os_log(logType, log: log, message, messageArguments)
    }
    
    func SignpostBegin(_ name: StaticString, id: AnyObject, category: LogCategory) {
        let log = GetCachedLog(category)
        let signpostId = OSSignpostID(log: log, object: id)
        os_signpost(.begin, log: log, name: name, signpostID: signpostId)
    }
    
    func SignpostBegin(_ name: StaticString, id: AnyObject, category: LogCategory, _ message: StaticString, _ messageArguments: CVarArg...) {
        let log = GetCachedLog(category)
        let signpostId = OSSignpostID(log: log, object: id)
        os_signpost(.begin, log: log, name: name, signpostID: signpostId, message, messageArguments)
    }
    
    func SignpostEnd(_ name: StaticString, id: AnyObject, category: LogCategory) {
        let log = GetCachedLog(category)
        let signpostId = OSSignpostID(log: log, object: id)
        os_signpost(.end, log: log, name: name, signpostID: signpostId)
    }
    
    func SignpostEnd(_ name: StaticString, id: AnyObject, category: LogCategory, _ message: StaticString, _ messageArguments: CVarArg...) {
        let log = GetCachedLog(category)
        let signpostId = OSSignpostID(log: log, object: id)
        os_signpost(.end, log: log, name: name, signpostID: signpostId, message, messageArguments)
    }
    
    func SignpostEvent(_ name: StaticString, id: AnyObject, category: LogCategory, _ message: StaticString, _ messageArguments: CVarArg...) {
        //        let log = GetCachedLog(category)
        //        let signpostId = OSSignpostID(log: log, object: id)
        os_signpost(.event, log: pointOfInterestLog, name: name, message, messageArguments)
    }
}
