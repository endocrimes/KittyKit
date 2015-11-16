//
//  APIClientTests.swift
//  KittyKit
//
//  Created by Danielle Lancashire on 09/11/2015.
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
    
    func test_can_retreive_authenticity_token() {
        let testBundle = NSBundle(forClass: self.dynamicType)
        let filePath = testBundle.pathForResource("homepage", ofType: "html")!
        stub(isScheme("https") && isHost("small.cat")) { _ in
            return fixture(filePath, headers: nil)
        }
        
        let expectation = expectationWithDescription("Completion should be called")
        apiClient?.fetchAuthenticityToken { (result: Either<AuthenticityToken, APIErrors>) in
            XCTAssertNotNil(result.left)
            XCTAssertEqual(result.left, "hw9PNaQf7qh9yFsD2lMK1V7GPJfW6VLjLm4ftlLj9mw=")
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(1.0, handler: nil)
    }
    
    func test_handles_a_bad_response_when_fetching_a_authenticity_token() {
        stub(isScheme("https") && isHost("small.cat")) { _ in
            return OHHTTPStubsResponse(fileAtPath: "", statusCode: 500, headers: nil)
        }
        
        let expectation = expectationWithDescription("Completion should be called")
        apiClient?.fetchAuthenticityToken { (result: Either<AuthenticityToken, APIErrors>) in
            XCTAssertNotNil(result.right)
            XCTAssertEqual(result.right!, APIErrors.UnableToFindToken)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(1.0, handler: nil)
    }
    
    // TODO: Stub the requests for this test
    func test_url_submission() {
        let inputURL = "http://danie.lt"
        let token = "hw9PNaQf7qh9yFsD2lMK1V7GPJfW6VLjLm4ftlLj9mw="
        let timeout = URLExpiry.TenMins
        
        let expectation = expectationWithDescription("Completion should be called")
        apiClient?.submitURL(inputURL, expiry: timeout, token: token) { result in
            print(result)
            
            XCTAssertNotNil(result.left)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(10.0, handler: nil)
    }
}
