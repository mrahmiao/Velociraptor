//
//  OptionExactlyTests.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/6/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation
import XCTest
import Velociraptor

class OptionExactlyTests: OptionTestCase {
  
  override func setUp() {
    super.setUp()
    matches = matchingOption(.Exactly, withStubbedHeaderFields: stubbedHeaders)
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testBothHeaderFieldsMustBeExactlyTheSame() {
    matchingResult = matches(sameHeaders)
    XCTAssertTrue(matchingResult!, "Matching result should be true, got \(matchingResult)")
  }
  
  func testMatchSameHeaderFieldValuesWithLowercaseHeaderFieldNames() {
    matchingResult = matches(lowercaseSameHeaders)
    XCTAssertTrue(matchingResult!, "Matching result should be true, got \(matchingResult)")
  }
  
  func testDoNotMatchAnyOtherHeaderFields() {
    let dismatchedHeaders = [
      sameNameDifferentValueHeaders, supersetHeaders, subsetHeaders,
      lowercaseSubsetHeaders, differentSubsetHeaders,
      matchedIntersectHeaders, lowercaseMatchedIntersectHeaders,
      dismatchedIntersectHeaders, emptySetHeaders,
      disjointHeaders, anotherDisjointHeaders
    ]
    
    for dismathed in dismatchedHeaders {
      matchingResult = matches(dismathed)
      XCTAssertFalse(matchingResult!, "Matching result should be false, got \(matchingResult)")
    }
  }

  
}
