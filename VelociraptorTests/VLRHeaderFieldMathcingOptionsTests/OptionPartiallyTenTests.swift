//
//  OptionPartiallyTenTests.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/6/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation
import XCTest

class OptionPartiallyTenTests: OptionTestCase {
  
  override func setUp() {
    super.setUp()
    matches = matchingOption(.Partially(10), withStubbedHeaderFields: stubbedHeaders)
  }
  
  func testMatchesIdenticalHeaderFields() {
    matchingResult = matches(sameHeaders)
    XCTAssertTrue(matchingResult!, "Matching result should be true, got \(matchingResult)")
  }
  
  func testMatchesIdenticalHeaderFieldsWithLowercaseNames() {
    matchingResult = matches(lowercaseSameHeaders)
    XCTAssertTrue(matchingResult!, "Matching result should be true, got \(matchingResult)")
  }
  
  func testMatchesSuperSetHeaderFields() {
    matchingResult = matches(supersetHeaders)
    XCTAssertTrue(matchingResult!, "Matching result should be true, got \(matchingResult)")
  }
  
  func testDoNotMatchAnyOtherHeaderFields() {
    let headers = [
      sameNameDifferentValueHeaders, subsetHeaders,
      lowercaseSubsetHeaders, differentSubsetHeaders,
      matchedIntersectHeaders, lowercaseMatchedIntersectHeaders,
      dismatchedIntersectHeaders, emptySetHeaders, disjointHeaders,
      anotherDisjointHeaders
    ]
    
    for header in headers {
      matchingResult = matches(header)
      XCTAssertFalse(matchingResult!, "Matching result should be false, got \(matchingResult)")
    }
  }
  
}
