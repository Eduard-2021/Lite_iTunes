//
//  Monads.swift
//  Lite_iTunes
//
//  Created by Eduard on 25.08.2021.
//

import Foundation

precedencegroup MonadicPrecedence {
    associativity: left
    higherThan: BitwiseShiftPrecedence
}

infix operator >>- : MonadicPrecedence

/// В случае если значение "a" типа T существует, то будет выполнен метод f, возвращающий тип U
/// Иначе получим nil
@inline(__always)
@discardableResult
public func >>-<T, U>(a: T?, f: (T) throws -> U?) rethrows -> U? {
    switch a {
    case .some(let x):
        return try f(x)
    case .none:
        return nil
    }
}

