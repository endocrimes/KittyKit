//
//  APIClientTests.swift
//  KittyKit
//
//  Created by  Danielle Lancashireon 09/11/2015.
//  Copyright © 2015 Rocket Apps Limited. All rights reserved.
//

import XCTest
@testable import KittyKit

class APIClientTests: XCTestCase {
    var apiClient: APIClient?
    
    override func setUp() {
        super.setUp()
        
        apiClient = APIClient()
    }
    
    override func tearDown() {
        super.tearDown()
        
        apiClient = nil
    }
}
