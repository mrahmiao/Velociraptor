//
//  ResponseStubbingTests.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/7/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation
import XCTest
import Velociraptor

class ResponseStubbingTests: NSURLSessionStubsTestCase {
  
  override func setUp() {
    super.setUp()
    config = NSURLSessionConfiguration.defaultSessionConfiguration()
  }
  
  func testStubbingResponseWithVLRStubbedResponseObject() {
    let expectation = self.expectationWithDescription("Stub response")
    
    let statusCode = 201
    let bodyData = "Hello World".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
    let expectedResponse = VLRStubbedResponse(URL: URL, statusCode: statusCode)
    expectedResponse.HTTPHeaderFields = [
      "Content-Type": "text/plain",
      "Content-Length": String(bodyData.length)
    ]
    expectedResponse.HTTPBody = bodyData
    
    Velociraptor.request(URL)?.response(expectedResponse)
    
    let task = session.dataTaskWithURL(URL) { (data, res, err) in
      expectation.fulfill()
      
      XCTAssertNotNil(res, "Response should not be nil")
      
      let response = res as! NSHTTPURLResponse
      XCTAssertEqual(response.URL!, self.URL, "URL should be equal")
      XCTAssertEqual(response.statusCode, statusCode, "Status code should be equal")
      for (key, value) in response.allHeaderFields {
        let key = key as! String
        let value = value as! String
        XCTAssertTrue(value == expectedResponse.HTTPHeaderFields[key], "Header field should be equal")
      }
      XCTAssertEqual(data, bodyData, "Body data should be equal")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func testStubbingSingleHeaderField() {
    let expectation = self.expectationWithDescription("single header field")
    let headerValue = "application/x-velociraptor"
    let headerField = "Content-Type"
    Velociraptor.request(URL)?.responseHeaderValue(headerValue, forHTTPHeaderField: headerField)
    
    let task = session.dataTaskWithURL(URL) { (data, res, error) in
      expectation.fulfill()
      
      let response = res as! NSHTTPURLResponse
      
      XCTAssertEqual(response.allHeaderFields.count, 1, "The number of header field should be 1")
      XCTAssertEqual((response.allHeaderFields[headerField] as! String), headerValue, "The value of header field should be correct")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func testStubbingMultipleHeaderFields() {
    let expectation = self.expectationWithDescription("multiple header fields")
    let headerFields = [
      "Content-Type": "application/json",
      "AuthKey": "Biu",
      "Title": "Velociraptor"]
    
    Velociraptor.request(URL)?.responseHTTPHeaderFields(headerFields)
    
    let task = session.dataTaskWithURL(URL) { (data, res, error) in
      expectation.fulfill()
      
      let response = res as! NSHTTPURLResponse
      
      XCTAssertEqual(response.allHeaderFields.count, 3, "The number of header fields should be 3")
      XCTAssertEqual((response.allHeaderFields as! [String: String]), headerFields, "Header fields should be identical")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func testStubbingStatusCode() {
    let expectation = self.expectationWithDescription("stubs status code")
    let statusCode = 301
    
    Velociraptor.request(URL)?.responseStatusCode(statusCode)
    
    let task = session.dataTaskWithURL(URL) { (data, res, error) in
      expectation.fulfill()
      
      let response = res as! NSHTTPURLResponse
      
      XCTAssertEqual(response.statusCode, statusCode, "Expected \(statusCode), got \(response.statusCode)")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func testStubbingErrorResponse() {
    let expectation = self.expectationWithDescription("Stub error response")
    
    let errorCode = 1234
    let userInfo = ["Error": "StubbedError"]
    let domain = "com.code4blues.mrahmiao.velociraptor"
    let stubbedError = NSError(domain: domain, code: errorCode, userInfo: userInfo)
    
    Velociraptor.request(URL)?.failWithError(stubbedError)
    
    let task = session.dataTaskWithURL(URL) { (data ,res, receivedError) in
      expectation.fulfill()
      
      XCTAssertEqual(data.length, 0, "The length of data should equal to 0")
      XCTAssertNil(res, "Response should be nil")
      XCTAssertEqual(receivedError, stubbedError, "Error should be equal")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func testStubbingResponseHTTPBodyData() {
    let expectation = expectationWithDescription("Response HTTP Body")
    let bodyData = "Hello World".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
    
    var receivedData: NSData! = nil
    Velociraptor.request(URL)?.responseBodyData(bodyData)
    
    let task = session.dataTaskWithURL(URL) { (data, res, err) in
      expectation.fulfill()
      
      XCTAssertEqual(data, bodyData, "Body data should be equal")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
  
  func testStubbingResponseHTTPBodyJSONData() {
    let expectation = expectationWithDescription("JSON data")
    let JSONObject: AnyObject = [
      "Number": 5,
      "Bool": false,
      "Array": [5, 4, 3]
    ]
    
    let JSONData = NSJSONSerialization.dataWithJSONObject(JSONObject, options: NSJSONWritingOptions.allZeros, error: nil)
    
    Velociraptor.request(URL)?.responseJSONData(JSONObject)
    
    let task = session.dataTaskWithURL(URL) { (data, res, err) in
      expectation.fulfill()
      let receivedRes = res as! NSHTTPURLResponse
      
      XCTAssertTrue(data == JSONData, "Data should be equal")
      XCTAssertEqual(receivedRes.allHeaderFields.count, 2, "The number of header fields should be 2")
      XCTAssertEqual((receivedRes.allHeaderFields["Content-Type"] as! String), "application/json; charset=utf-8", "Content-Type header value should be correct")
      XCTAssertEqual((receivedRes.allHeaderFields["Content-Length"] as! String), String(JSONData!.length), "Content-Length header value should be correct")
    }
    
    task.resume()
    self.waitForExpectationsWithTimeout(1) { error in
      if let error = error {
        XCTFail(error.localizedDescription)
      }
    }
  }
}
