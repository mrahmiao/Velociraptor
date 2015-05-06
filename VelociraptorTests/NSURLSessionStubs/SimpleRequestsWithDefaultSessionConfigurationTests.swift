//
//  SimpleRequestsWithDefaultSessionConfigurationTests.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/6/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation
import XCTest
import Velociraptor

class SimpleRequestsWithDefaultSessionConfigurationTests: NSURLSessionStubsTestCase {
  
  override func setUp() {
    config = NSURLSessionConfiguration.defaultSessionConfiguration()
  }
  
  func testStubURLStringAndReceiveDefaultResponse() {
    let expectation = expectationWithDescription("URLString")
    
    Velociraptor.request(URLString)
    
    let url = NSURL(string: URLString)!
    
    let task = session.dataTaskWithURL(url) { (data, res, error) in
      expectation.fulfill()
      
      XCTAssertEqual(data.length, 0, "The length of data should equal to 0, got \(data.length)")
      XCTAssertNotNil(res, "Default response should not be nil")
      XCTAssertNil(error, "Should not receive an error")
      
      let response = res as! NSHTTPURLResponse
      
      XCTAssertEqual(response.statusCode, 200, "Default status code should equal to 200, got \(response.statusCode)")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func testStubNSURLAndReceiveDefaultResponse() {
    let expectation = expectationWithDescription("NSURL")
    
    Velociraptor.request(URL)
    
    let task = session.dataTaskWithURL(URL) { (data, res, error) in
      expectation.fulfill()
      
      XCTAssertEqual(data.length, 0, "The length of data should equal to 0, got \(data.length)")
      XCTAssertNotNil(res, "Default response should not be nil")
      XCTAssertNil(error, "Should not receive an error")
      
      let response = res as! NSHTTPURLResponse
      
      XCTAssertEqual(response.statusCode, 200, "Default status code should equal to 200, got \(response.statusCode)")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func testStubNSURLRequestAndReceiveDefaultResponse() {
    let expectation = expectationWithDescription("NSURLRequest")
    
    Velociraptor.request(request)
    
    let task = session.dataTaskWithRequest(request) { (data, res, error) in
      expectation.fulfill()
      
      XCTAssertEqual(data.length, 0, "The length of data should equal to 0, got \(data.length)")
      XCTAssertNotNil(res, "Default response should not be nil")
      XCTAssertNil(error, "Should not receive an error")
      
      let response = res as! NSHTTPURLResponse
      
      XCTAssertEqual(response.statusCode, 200, "Default status code should equal to 200, got \(response.statusCode)")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
}