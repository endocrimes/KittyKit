//
//  APIClient.swift
//  KittyKit
//
//  Created by  Danielle Lancashireon 09/11/2015.
//  Copyright © 2015 Rocket Apps Limited. All rights reserved.
//

import Foundation

public typealias AuthenticityToken = String

public protocol APIClientProtocol {
    func fetchAuthenticityToken(completion: Maybe<AuthenticityToken, ErrorType> -> ())
    func submitURL(url: String, token: AuthenticityToken, completion: Maybe<String, ErrorType> -> ())
}

public class APIClient: APIClientProtocol {
    public func fetchAuthenticityToken(completion: Maybe<AuthenticityToken, ErrorType> -> ()) {
        
    }
    
    public func submitURL(url: String, token: AuthenticityToken, completion: Maybe<String, ErrorType> -> ()) {
        
    }
}