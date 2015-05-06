//
//  OptionPartiallyZeroTests.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/6/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation
import XCTest

class OptionPartiallyZeroTests: OptionTestCase {
  
  func testPartiallyZeroMatchesArbitraryHeaderFields() {
    matches = matchingOption(.Partially(0), withStubbedHeaderFields: stubbedHeaders)
    matches = self.matchingOption(.Partially(0), withStubbedHeaderFields: stubbedHeaders)
    let headers = [
      sameHeaders, lowercaseSameHeaders, sameNameDifferentValueHeaders,
      supersetHeaders, subsetHeaders, lowercaseSubsetHeaders, differentSubsetHeaders,
      matchedIntersectHeaders, lowercaseMatchedIntersectHeaders,
      dismatchedIntersectHeaders, emptySetHeaders, disjointHeaders,
      anotherDisjointHeaders
    ]
    
    for header in headers {
      matchingResult = matches(header)
      XCTAssertTrue(matchingResult!, "Matching result should be true, got \(matchingResult)")
    }
  }
  
}
