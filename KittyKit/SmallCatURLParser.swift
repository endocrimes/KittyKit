//
//  SmallCatURLParser.swift
//  KittyKit
//
//  Created by  Danielle Lancashireon 10/11/2015.
//  Copyright © 2015 Rocket Apps Limited. All rights reserved.
//

import Foundation

internal func parseSmallCatURLFromHTML(html: String) -> String? {
    let regex = try! NSRegularExpression(pattern: "<h2>Your Small.Cat link is:</h2>\n\n  <a href=\"([^\"]*?)\" rel=\"nofollow\" class=\"smallcat\">", options: [])
    
    guard let match = regex.firstMatchInString(html, options: [], range: NSRange(location: 0, length: html.characters.count)) else {
        return nil
    }
    guard match.numberOfRanges >= 2 else { return nil }
    
    return (html as NSString).substringWithRange(match.rangeAtIndex(1))
}
