//
//  RequestHTTPMethodTests.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/7/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation
import XCTest
import Velociraptor

class RequestHTTPMethodTests: NSURLSessionStubsTestCase {
  
  override func setUp() {
    super.setUp()
    config = NSURLSessionConfiguration.defaultSessionConfiguration()
  }
  
  func testStubPOSTRequest() {
    let method = VLRHTTPMethod.POST
    let expectation = expectationWithDescription(method.rawValue)
    
    Velociraptor.request(URLString)?.requestHTTPMethod(method)
    
    let aRequest = request.mutableCopy() as! NSMutableURLRequest
    aRequest.HTTPMethod = method.rawValue
    let task = session.dataTaskWithRequest(aRequest) { (data, res, error) in
      expectation.fulfill()
      
      XCTAssertNotNil(res, "Response should not be nil")
      XCTAssertEqual(data.length, 0, "The length of data should be 0")
      XCTAssertNil(error, "Error should be nil")
      
      let response = res as! NSHTTPURLResponse
      
      XCTAssertEqual(response.statusCode, 200, "Default status code should be 200")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func testStubPUTRequest() {
    let method = VLRHTTPMethod.PUT
    let expectation = expectationWithDescription(method.rawValue)
    
    Velociraptor.request(URLString)?.requestHTTPMethod(method)
    
    let aRequest = request.mutableCopy() as! NSMutableURLRequest
    aRequest.HTTPMethod = method.rawValue
    let task = session.dataTaskWithRequest(aRequest) { (data, res, error) in
      expectation.fulfill()
      
      XCTAssertNotNil(res, "Response should not be nil")
      XCTAssertEqual(data.length, 0, "The length of data should be 0")
      XCTAssertNil(error, "Error should be nil")
      
      let response = res as! NSHTTPURLResponse
      
      XCTAssertEqual(response.statusCode, 200, "Default status code should be 200")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func testStubDELETERequest() {
    let method = VLRHTTPMethod.DELETE
    let expectation = expectationWithDescription(method.rawValue)
    
    Velociraptor.request(URLString)?.requestHTTPMethod(method)
    
    let aRequest = request.mutableCopy() as! NSMutableURLRequest
    aRequest.HTTPMethod = method.rawValue
    let task = session.dataTaskWithRequest(aRequest) { (data, res, error) in
      expectation.fulfill()
      
      XCTAssertNotNil(res, "Response should not be nil")
      XCTAssertEqual(data.length, 0, "The length of data should be 0")
      XCTAssertNil(error, "Error should be nil")
      
      let response = res as! NSHTTPURLResponse
      
      XCTAssertEqual(response.statusCode, 200, "Default status code should be 200")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func testStubPATCHRequest() {
    let method = VLRHTTPMethod.PATCH
    let expectation = expectationWithDescription(method.rawValue)
    
    Velociraptor.request(URLString)?.requestHTTPMethod(method)
    
    let aRequest = request.mutableCopy() as! NSMutableURLRequest
    aRequest.HTTPMethod = method.rawValue
    let task = session.dataTaskWithRequest(aRequest) { (data, res, error) in
      expectation.fulfill()
      
      XCTAssertNotNil(res, "Response should not be nil")
      XCTAssertEqual(data.length, 0, "The length of data should be 0")
      XCTAssertNil(error, "Error should be nil")
      
      let response = res as! NSHTTPURLResponse
      
      XCTAssertEqual(response.statusCode, 200, "Default status code should be 200")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
}