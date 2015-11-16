//
//  Either.swift
//  KittyKit
//
//  Created by Danielle Lancashire on 09/11/2015.
//  Copyright © 2015 Rocket Apps Limited. All rights reserved.
//

import Foundation

public enum Either<T, U> {
    case Left(T)
    case Right(U)
    
    /// Returns the result of applying `f` to the value of `Left`, or `g` to the value of `Right`.
    public func either<Result>(@noescape ifLeft ifLeft: T throws -> Result, @noescape ifRight: U throws -> Result) rethrows -> Result {
        switch self {
        case let .Left(x):
            return try ifLeft(x)
        case let .Right(x):
            return try ifRight(x)
        }
    }
    
    /// Returns the value of `Left` instances, or `nil` for `Right` instances.
    public var left: T? {
        return either(
            ifLeft: unit,
            ifRight: const(nil))
    }
    
    /// Returns the value of `Right` instances, or `nil` for `Left` instances.
    public var right: U? {
        return either(
            ifLeft: const(nil),
            ifRight: unit)
    }
}

/// Returns its argument as an `Optional<T>`.
private func unit<T>(x: T) -> T? {
    return x
}

/// Returns a function which ignores its argument and returns `x` instead.
private func const<T, U>(x: T) -> U -> T {
    return { _ in x }
}
