//
//  OptionTestCase.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/6/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation
import XCTest

class OptionTestCase: XCTestCase {
  typealias Matcher = [NSObject: AnyObject] -> Bool
  
  func matchingOption(option: VLRHeaderFieldMatchingOptions, withStubbedHeaderFields stubbedFields: [String: String]) -> Matcher {
    return { (fields) -> Bool in
      return option.incomingHeaderFields(fields, matchesStubbedHeaderFields: stubbedFields)
    }
  }
  
  let minimumNumberOfMatchedHeaders: UInt = 3
  
  let stubbedHeaders = [
    "Authroization": "13145253",
    "Accept": "text/plain",
    "Cookie": "hello=world",
    "Custom": "customHeader"
  ]
  
  let sameHeaders = [
    "Authroization": "13145253",
    "Accept": "text/plain",
    "Cookie": "hello=world",
    "Custom": "customHeader"
  ]
  
  let lowercaseSameHeaders = [
    "Authroization": "13145253",
    "accept": "text/plain",
    "cookie": "hello=world",
    "Custom": "customHeader"
  ]
  
  let sameNameDifferentValueHeaders = [
    "Authroization": "DifferentHeader",
    "Accept": "text/plain",
    "Cookie": "hello=world",
    "Custom": "customHeader"
  ]
  
  let supersetHeaders = [
    "Authroization": "13145253",
    "accept": "text/plain",
    "cookie": "hello=world",
    "Custom": "customHeader",
    "Super": "Man",
    "Icon": "Man"
  ]
  
  let subsetHeaders = [
    "Authroization": "13145253",
    "Accept": "text/plain"
  ]
  
  let lowercaseSubsetHeaders = [
    "Authroization": "13145253",
    "accept": "text/plain"
  ]
  
  let differentSubsetHeaders = [
    "Authroization": "13145253",
    "accept": "application/json"
  ]
  
  let emptySetHeaders = [String: String]()
  
  let matchedIntersectHeaders = [
    "Authroization": "13145253",
    "Accept": "text/plain",
    "Cookie": "hello=world",
    "Different": "DifferentHeaderField"
  ]
  
  let lowercaseMatchedIntersectHeaders = [
    "Authroization": "13145253",
    "accept": "text/plain",
    "cookie": "hello=world",
    "Different": "DifferentHeaderField"
  ]
  
  /// With 2 common header fields, which is less than the minimum: 3.
  let dismatchedIntersectHeaders = [
    "Authroization": "13145253",
    "Accept": "text/plain",
    "Different": "DifferentHeaderField"
  ]
  
  let disjointHeaders = [
    "Totally": "Different",
    "Completely": "Also Different",
    "Disjoint": "With out any identical"
  ]
  
  let anotherDisjointHeaders = [
    "Totally": "Different",
    "Completely": "Also Different",
    "Disjoint": "With out any identical",
    "Different": "Different"
  ]
  
  var matchingResult: Bool!
  var matches: Matcher!
  
  override func tearDown() {
    matchingResult = nil
    matches = nil
    super.tearDown()
  }
}
