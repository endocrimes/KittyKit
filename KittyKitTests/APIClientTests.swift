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
    }
    
    override func tearDown() {
        super.tearDown()
        
        apiClient = nil
        OHHTTPStubs.removeAllStubs()
    }
    
    func test_can_retreive_verification_token() {
        let testBundle = NSBundle(forClass: self.dynamicType)
        let filePath = testBundle.pathForResource("homepage", ofType: "html")!
        stub(isScheme("https") && isHost("small.cat")) { _ in
            return fixture(filePath, headers: nil)
        }
        
        let expectation = expectationWithDescription("Completion should be called")
        apiClient?.fetchAuthenticityToken { result in
           expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(1.0, handler: nil)
    }
}
