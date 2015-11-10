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

public enum URLExpiry: Int {
    case TenMins = 10
    case OneHour = 60
    case OneDay  = 1440
    case OneWeek = 10080
}

public typealias AuthenticityToken = String

public protocol APIClientProtocol {
    func fetchAuthenticityToken(completion: Either<AuthenticityToken, APIErrors> -> ())
    func submitURL(url: String, expiry: URLExpiry, token: AuthenticityToken, completion: Either<String, APIErrors> -> ())
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
    
    public func submitURL(url: String, expiry: URLExpiry, token: AuthenticityToken, completion: Either<String, APIErrors> -> ()) {
        let postBody = "utf8=%E2%9C%93&authenticity_token=\(token)&entry%5Bvalue%5D=\(url)&entry%5Bduration_in_minutes%5D=\(expiry.rawValue)".dataUsingEncoding(NSUTF8StringEncoding)
        
        let urlRequest = NSMutableURLRequest(URL: NSURL(string: "http://small.cat/entries")!)
        urlRequest.HTTPMethod = "POST"
        urlRequest.HTTPBody = postBody
        
        let urlSession = NSURLSession.sharedSession()
        
        urlSession.dataTaskWithRequest(urlRequest) { data, response, error in
            guard let response = response as? NSHTTPURLResponse,
                destination = response.URL
            else {
                completion(.Right(APIErrors.InvalidResponse))
                return
            }
            
            urlSession.dataTaskWithURL(destination) { data, response, error in
                guard let data = data,
                    text = String(data: data, encoding: NSUTF8StringEncoding),
                    urlString = parseSmallCatURLFromHTML(text)
                else {
                    completion(.Right(APIErrors.InvalidResponse))
                    return
                }
                
                completion(.Left(urlString))
            }.resume()
        }.resume()
    }
}