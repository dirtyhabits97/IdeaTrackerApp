//
//  UUID+Extensions.swift
//  IdeaTrackerAppLib
//
//  Created by DIGITAL008 on 10/9/20.
//

import Foundation

public extension UUID {
    
    var shortString: String {
        let start = uuidString.startIndex
        let end = uuidString.index(start, offsetBy: 8)
        return String(uuidString[start..<end])
    }
    
}
