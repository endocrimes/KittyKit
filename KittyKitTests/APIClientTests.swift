//
//  APIClientTests.swift
//  KittyKit
//
//  Created by Daniel Tomlinson on 09/11/2015.
//  Copyright © 2015 Rocket Apps Limited. All rights reserved.
//

import XCTest
@testable import KittyKit
import OHHTTPStubs

class APIClientTests: XCTestCase {
    var apiClient: APIClient?
    
    override func setUp() {
        super.setUp()
        
        apiClient = APIClient()
        
        stub
    }
    
    override func tearDown() {
        super.tearDown()
        
        apiClient = nil
    }
}
