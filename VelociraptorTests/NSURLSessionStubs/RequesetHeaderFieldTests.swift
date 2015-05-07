//
//  RequesetHeaderFieldTests.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/7/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation
import XCTest
import Velociraptor

class RequesetHeaderFieldTests: NSURLSessionStubsTestCase {
  
  let stubbedHeaders = ["Accept": "*", "Stubbed": "Headers"]
  
  override func setUp() {
    super.setUp()
    config = NSURLSessionConfiguration.defaultSessionConfiguration()
  }
  
  override func tearDown() {
    Velociraptor.headerFieldMatchingOption = .Exactly
    super.setUp()
  }
  
  func testMatchingOptionExactly() {
    let expectation = self.expectationWithDescription("Exactly matching")
    
    // Default option
    Velociraptor.headerFieldMatchingOption = .Exactly
    Velociraptor.request(URLString)?.requestHTTPHeaderFields(stubbedHeaders)
    let mutableRequest = request.mutableCopy() as! NSMutableURLRequest
    
    // Comment the following line to see the error.
    mutableRequest.allHTTPHeaderFields = stubbedHeaders
    
    let task = session.dataTaskWithRequest(mutableRequest) { (data, res, error) in
      expectation.fulfill()
      
      XCTAssertNil(error, "Error should be nil")
      XCTAssertEqual(data.length, 0, "The length of data should be 0")
      XCTAssertNotNil(res, "Response should not be nil")
      
      let response = res as! NSHTTPURLResponse
      
      XCTAssertEqual(response.statusCode, 200, "Default status code should equal to 200")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func testOptionPartiallyOneMatchAtLeastOneCommonHeaderField() {
    let expectation = self.expectationWithDescription("Partially matching")
    
    Velociraptor.headerFieldMatchingOption = .Partially(1)
    Velociraptor.request(URLString)?.requestHTTPHeaderFields(stubbedHeaders)
    let mutableRequest = request.mutableCopy() as! NSMutableURLRequest
    
    // Comment the following line to see the error.
    mutableRequest.allHTTPHeaderFields = ["Accept": "*"]
    
    let task = session.dataTaskWithRequest(mutableRequest) { (data, res, error) in
      expectation.fulfill()
      
      XCTAssertNil(error, "Error should be nil")
      XCTAssertEqual(data.length, 0, "The length of data should be 0")
      XCTAssertNotNil(res, "Response should not be nil")
      
      let response = res as! NSHTTPURLResponse
      
      XCTAssertEqual(response.statusCode, 200, "Default status code should equal to 200")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func testOptionStrictSetMatchEmptySet() {
    let expectation = self.expectationWithDescription("Strict subset matching")
    
    Velociraptor.headerFieldMatchingOption = .StrictSubset
    Velociraptor.request(URLString)?.requestHTTPHeaderFields(stubbedHeaders)
    let mutableRequest = request.mutableCopy() as! NSMutableURLRequest
    
    let task = session.dataTaskWithRequest(mutableRequest) { (data, res, error) in
      expectation.fulfill()
      
      XCTAssertNil(error, "Error should be nil")
      XCTAssertEqual(data.length, 0, "The length of data should be 0")
      XCTAssertNotNil(res, "Response should not be nil")
      
      let response = res as! NSHTTPURLResponse
      
      XCTAssertEqual(response.statusCode, 200, "Default status code should equal to 200")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func testOptionStrictSubsetMatchSubset() {
    let expectation = self.expectationWithDescription("Strict subset matching")
    
    Velociraptor.headerFieldMatchingOption = .StrictSubset
    Velociraptor.request(URLString)?.requestHTTPHeaderFields(stubbedHeaders)
    let mutableRequest = request.mutableCopy() as! NSMutableURLRequest
    mutableRequest.allHTTPHeaderFields = [
      "Accept": "*"
    ]
    
    let task = session.dataTaskWithRequest(mutableRequest) { (data, res, error) in
      expectation.fulfill()
      
      XCTAssertNil(error, "Error should be nil")
      XCTAssertEqual(data.length, 0, "The length of data should be 0")
      XCTAssertNotNil(res, "Response should not be nil")
      
      let response = res as! NSHTTPURLResponse
      
      XCTAssertEqual(response.statusCode, 200, "Default status code should equal to 200")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func testOptionArbitrarilyMatchArbitraryRequestHeaderFields() {
    let expectation = self.expectationWithDescription("Arbitrarily matching")
    
    Velociraptor.headerFieldMatchingOption = .Arbitrarily
    Velociraptor.request(URLString)?.requestHTTPHeaderFields(stubbedHeaders)
    let mutableRequest = request.mutableCopy() as! NSMutableURLRequest
    mutableRequest.allHTTPHeaderFields = ["Accept": "*", "Others": "Someothers"]
    
    let task = session.dataTaskWithRequest(mutableRequest) { (data, res, error) in
      expectation.fulfill()
      
      XCTAssertNil(error, "Error should be nil")
      XCTAssertEqual(data.length, 0, "The length of data should be 0")
      XCTAssertNotNil(res, "Response should not be nil")
      
      let response = res as! NSHTTPURLResponse
      
      XCTAssertEqual(response.statusCode, 200, "Default status code should equal to 200")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  
}
