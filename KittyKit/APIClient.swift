//
//  APIClient.swift
//  KittyKit
//
//  Created by Daniel Tomlinson on 09/11/2015.
//  Copyright © 2015 Rocket Apps Limited. All rights reserved.
//

import Foundation

public enum APIErrors : ErrorType {
    case InvalidResponse
    case UnableToFindToken
}

public typealias AuthenticityToken = String

public protocol APIClientProtocol {
    func fetchAuthenticityToken(completion: Either<AuthenticityToken, APIErrors> -> ())
    func submitURL(url: String, token: AuthenticityToken, completion: Either<String, ErrorType> -> ())
}

public class APIClient: APIClientProtocol {
    public func fetchAuthenticityToken(completion: Either<AuthenticityToken, APIErrors> -> ()) {
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "https://small.cat")!) { data, response, error in
            guard let data = data, text = String(data: data, encoding: NSUTF8StringEncoding) else {
                completion(.Right(APIErrors.InvalidResponse))
                return
            }
            
            guard let authenticityToken = parseAuthenticityTokenFromHTML(text) else {
                completion(.Right(APIErrors.UnableToFindToken))
                return
            }
            
            completion(.Left(authenticityToken))
        }.resume()
    }
    
    public func submitURL(url: String, token: AuthenticityToken, completion: Either<String, ErrorType> -> ()) {
        
    }
}