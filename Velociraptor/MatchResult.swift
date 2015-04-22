//
//  MatchResult.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/22/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

final class Box<T> {
  let value: T
  init(value: T) {
    self.value = value
  }
}

enum MatchResult<T> {
  case Success(Box<T>)
  case Failure(String)
  
  func check<U>(f: T -> MatchResult<U>) -> MatchResult<U> {
    switch self {
    case Success(let value):
      return f(value.value)
    case Failure(let error):
      return MatchResult<U>.Failure(error)
    }
  }
}