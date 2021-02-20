//
//  SwiftPackageTests.swift
//  SwiftPackage
//
//  Created by Mr. Ming on 2021-01-09.
//  Copyright (c) 2021 Mr. Ming <minglq.9@gmail.com>. Released under the MIT license.
//

import XCTest

@testable
import SwiftPackage

final class SwiftPackageTests: XCTestCase {
    
    func testSwiftPackage() {
        XCTAssertEqual(SwiftPackage().text, "Hello, SwiftPackage!")
    }
    
    static var allTests = [
        ("testSwiftPackage", testSwiftPackage),
    ]
    
}
