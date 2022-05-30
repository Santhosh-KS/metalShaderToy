//
//  Utility.swift
//  metalShaderToy
//
//  Created by Santhosh K S on 30/05/22.
//

public func honestValue<A>(_ a:A?) -> A {
  guard let a = a else { fatalError("\(String(describing: a))")}
  return a
}

