//
//  OptionArbitrarilyTests.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/6/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation
import XCTest

class OptionArbitrarilyTests: OptionTestCase {
  
  override func setUp() {
    super.setUp()
    
    matches = matchingOption(.Arbitrarily, withStubbedHeaderFields: stubbedHeaders)
  }
  
  func testMatchArbitraryHeaderFields() {
    let headers = [
      sameHeaders, lowercaseSameHeaders, sameNameDifferentValueHeaders,
      supersetHeaders, subsetHeaders, lowercaseSubsetHeaders, differentSubsetHeaders,
      matchedIntersectHeaders, lowercaseMatchedIntersectHeaders,
      dismatchedIntersectHeaders, emptySetHeaders, disjointHeaders, anotherDisjointHeaders
    ]
    
    for header in headers {
      matchingResult = matches(header)
      XCTAssertTrue(matchingResult!, "Matching result should be true, with header fields: \(header)")
    }
  }
  
  
}
