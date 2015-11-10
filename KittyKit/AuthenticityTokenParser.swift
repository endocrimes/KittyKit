//
//  AuthenticityTokenParser.swift
//  KittyKit
//
//  Created by Daniel Tomlinson on 09/11/2015.
//  Copyright © 2015 Rocket Apps Limited. All rights reserved.
//

import Foundation

internal func parseAuthenticityTokenFromHTML(html: String) -> String? {
    let regex = try! NSRegularExpression(pattern: "<input name=\"authenticity_token\" type=\"hidden\" value=\"([^\"]*?)\" />", options: [])
    
    guard let match = regex.firstMatchInString(html, options: [], range: NSRange(location: 0, length: html.characters.count)) else {
        return nil
    }
    guard match.numberOfRanges >= 2 else { return nil }
    
    return (html as NSString).substringWithRange(match.rangeAtIndex(1))
}
