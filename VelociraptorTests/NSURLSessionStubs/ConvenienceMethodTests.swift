//
//  ConvenienceMethodTests.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/7/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation
import XCTest
import Velociraptor

class ConvenienceMethodTests: NSURLSessionStubsTestCase {
  
  override func setUp() {
    super.setUp()
    
    config = NSURLSessionConfiguration.defaultSessionConfiguration()
  }
  
  func testStubGETRequestAndReceivedDefaultResponse() {
    let expectation = self.expectationWithDescription("Convenience GET method")
    Velociraptor.GET(URL)
    
    let task = session.dataTaskWithURL(URL) { (data, res, err) in
      expectation.fulfill()
      let receivedRes = res as! NSHTTPURLResponse
      XCTAssertTrue(receivedRes.URL == self.URL, "URL should be the same")
      XCTAssertEqual(receivedRes.statusCode, 200, "Default status code should equal to 200")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func testStubPOSTRequestAndReceivedDefaultResponse() {
    let expectation = self.expectationWithDescription("Convenience POST method")
    Velociraptor.POST(URL)
    
    let mutableRequest = request.mutableCopy() as! NSMutableURLRequest
    mutableRequest.HTTPMethod = VLRHTTPMethod.POST.rawValue
    
    let task = session.dataTaskWithRequest(mutableRequest) { (data, res, err) in
      expectation.fulfill()
      let receivedRes = res as! NSHTTPURLResponse
      XCTAssertTrue(receivedRes.URL == self.URL, "URL should be the same")
      XCTAssertEqual(receivedRes.statusCode, 200, "Default status code should equal to 200")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func testStubPUTRequestAndReceivedDefaultResponse() {
    let expectation = self.expectationWithDescription("Convenience PUT method")
    Velociraptor.PUT(URL)
    
    let mutableRequest = request.mutableCopy() as! NSMutableURLRequest
    mutableRequest.HTTPMethod = VLRHTTPMethod.PUT.rawValue
    
    let task = session.dataTaskWithRequest(mutableRequest) { (data, res, err) in
      expectation.fulfill()
      let receivedRes = res as! NSHTTPURLResponse
      XCTAssertTrue(receivedRes.URL == self.URL, "URL should be the same")
      XCTAssertEqual(receivedRes.statusCode, 200, "Default status code should equal to 200")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func testStubDELETERequestAndReceivedDefaultResponse() {
    let expectation = self.expectationWithDescription("Convenience DELETE method")
    Velociraptor.DELETE(URL)
    
    let mutableRequest = request.mutableCopy() as! NSMutableURLRequest
    mutableRequest.HTTPMethod = VLRHTTPMethod.DELETE.rawValue
    
    let task = session.dataTaskWithRequest(mutableRequest) { (data, res, err) in
      expectation.fulfill()
      let receivedRes = res as! NSHTTPURLResponse
      XCTAssertTrue(receivedRes.URL == self.URL, "URL should be the same")
      XCTAssertEqual(receivedRes.statusCode, 200, "Default status code should equal to 200")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func testStubPATCHRequestAndReceivedDefaultResponse() {
    let expectation = self.expectationWithDescription("Convenience PATCH method")
    Velociraptor.PATCH(URL)
    
    let mutableRequest = request.mutableCopy() as! NSMutableURLRequest
    mutableRequest.HTTPMethod = VLRHTTPMethod.PATCH.rawValue
    
    let task = session.dataTaskWithRequest(mutableRequest) { (data, res, err) in
      expectation.fulfill()
      let receivedRes = res as! NSHTTPURLResponse
      XCTAssertTrue(receivedRes.URL == self.URL, "URL should be the same")
      XCTAssertEqual(receivedRes.statusCode, 200, "Default status code should equal to 200")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
}