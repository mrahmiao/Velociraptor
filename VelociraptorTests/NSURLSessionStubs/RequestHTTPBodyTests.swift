//
//  RequestHTTPBodyTests.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/7/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation
import XCTest
import Velociraptor

class RequestHTTPBodyTests: NSURLSessionStubsTestCase {
  
  override func setUp() {
    super.setUp()
    config = NSURLSessionConfiguration.defaultSessionConfiguration()
  }
  
  func testMatchRequestsWithIdenticalHTTPBody() {
    let expectation = self.expectationWithDescription("HTTP body data stub")
    let bodyData = "Hello world".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    let aRequest = request.mutableCopy() as! NSMutableURLRequest
    Velociraptor.request(aRequest)?
      .requestHTTPMethod(.POST)
      .requestBodyData(bodyData)
    
    aRequest.HTTPBody = bodyData
    aRequest.HTTPMethod = "POST"
    let task = session.dataTaskWithRequest(aRequest) { (data, res, error) in
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
