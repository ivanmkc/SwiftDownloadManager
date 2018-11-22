//
//  PrintLogger.swift
//  WorldWiser
//
//  Created by Ivan Cheung on 2018-09-17.
//  Copyright © 2018 Ivan Cheung. All rights reserved.
//

import Foundation
import os.log

class PrintLogger: Logging {
    func Log(_ message: StaticString, _ messageArguments: CVarArg..., type: LogLevel) {
        print(message, messageArguments)
    }
    
    @available(iOS 9.0, *)
    func Log(_ message: StaticString, _ messageArguments: CVarArg..., type: LogLevel, category: LogCategory) {
        print(message, messageArguments)
    }
    
    func SignpostBegin(_ name: StaticString, id: AnyObject, category: LogCategory) {
        print(name)
    }
    
    func SignpostBegin(_ name: StaticString, id: AnyObject, category: LogCategory, _ message: StaticString, _ messageArguments: CVarArg...) {
        print(name)
    }
    
    
    func SignpostEnd(_ name: StaticString, id: AnyObject, category: LogCategory) {
    }
    
    func SignpostEnd(_ name: StaticString, id: AnyObject, category: LogCategory, _ message: StaticString, _ messageArguments: CVarArg...) {
    }
    
    func SignpostEvent(_ name: StaticString, id: AnyObject, category: LogCategory, _ message: StaticString, _ messageArguments: CVarArg...) {
        
    }
}
