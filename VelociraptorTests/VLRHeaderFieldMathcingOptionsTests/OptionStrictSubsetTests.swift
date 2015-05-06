//
//  OptionStrictSubsetTests.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/6/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation
import XCTest

class OptionStrictSubsetTests: OptionTestCase {
  
  override func setUp() {
    super.setUp()
    matches = matchingOption(.StrictSubset, withStubbedHeaderFields: stubbedHeaders)
  }
  
  func testMatchSubsetOfStubbedHeaderFields() {
    matchingResult = matches(subsetHeaders)
    XCTAssertTrue(matchingResult!, "Matching result should be true, got \(matchingResult)")
  }
  
  func testMatchSubsetOfStubbedHeaderFieldsWithLowercaseNames() {
    matchingResult = matches(lowercaseSubsetHeaders)
    XCTAssertTrue(matchingResult!, "Matching result should be true, got \(matchingResult)")
  }
  
  func testMatchEmptyHeaderFields() {
    matchingResult = matches(emptySetHeaders)
    XCTAssertTrue(matchingResult!, "Matching result should be true, got \(matchingResult)")
  }
  
  func testDoNotMatchAnyOtherHeaderFields() {
    let headers = [
      sameHeaders, lowercaseSameHeaders, sameNameDifferentValueHeaders,
      supersetHeaders, differentSubsetHeaders,
      matchedIntersectHeaders, lowercaseMatchedIntersectHeaders,
      dismatchedIntersectHeaders, disjointHeaders, anotherDisjointHeaders
    ]
    
    for header in headers {
      matchingResult = matches(header)
      XCTAssertFalse(matchingResult!, "Matching result should be false, with header fields: \(header)")
    }
  }
}
