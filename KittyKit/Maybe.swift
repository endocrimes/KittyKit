//
//  Result.swift
//  KittyKit
//
//  Created by  Danielle Lancashireon 09/11/2015.
//  Copyright © 2015 Rocket Apps Limited. All rights reserved.
//

import Foundation

public enum Maybe<T, U> {
    case Left(T)
    case Right(U)
}
