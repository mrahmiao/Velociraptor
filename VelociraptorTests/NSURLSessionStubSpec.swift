//
//  NSURLSessionStubSpec.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/23/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Quick
import Nimble
import Velociraptor

class NSURLSessionStubsSpec: QuickSpec {
  override func spec() {
    
    var URLString = "https://github.com/mrahmiao/Velociraptor"
    var URL = NSURL(string: URLString)!
    var request = NSURLRequest(URL: URL)
    
    var session: NSURLSession!
    var config: NSURLSessionConfiguration! {
      didSet {
        if let config = config {
          session = NSURLSession(configuration: config)
        }
      }
    }
    
    beforeSuite {
      Velociraptor.activate()
    }
    
    afterSuite {
      Velociraptor.deactivate()
    }
    
    afterEach {
      config = nil
      session = nil
      Velociraptor.clearStubs()
    }
    
    // MARK: - Stubs requests without any further stubs
    describe("Stubs requests without any further stubs") {
      
      // MARK: under the default session configuration
      context("under the default session configuration") {
        beforeEach {
          config = NSURLSessionConfiguration.defaultSessionConfiguration()
        }
        
        it("using an URL string and receives default response") {
          let expectation = self.expectationWithDescription("Stubs request using URL string")
          
          // Stub the request
          Velociraptor.request(URLString)
          let url = NSURL(string: URLString)!
          let task = session.dataTaskWithURL(url) { (data, res, error) in
            expectation.fulfill()
            
            let response = res as! NSHTTPURLResponse
            
            expect(data.length).to(equal(0))
            expect(response).notTo(beNil())
            expect(response.statusCode).to(equal(200))
            expect(error).to(beNil())
          }
          
          task.resume()
          self.waitForExpectationsWithTimeout(1) { error in
            if let error = error {
              XCTFail(error.localizedDescription)
            }
          }
        }
        
        it("using a NSURL and receives default response") {
          let expectation = self.expectationWithDescription("Stubs request using NSURL")
          
          // Stub the request
          Velociraptor.request(URL)
          let task = session.dataTaskWithURL(URL) { (data, res, error) in
            expectation.fulfill()
            
            let response = res as! NSHTTPURLResponse
            
            expect(data.length).to(equal(0))
            expect(response).notTo(beNil())
            expect(response.statusCode).to(equal(200))
            expect(error).to(beNil())
          }
          
          task.resume()
          self.waitForExpectationsWithTimeout(1) { error in
            if let error = error {
              XCTFail(error.localizedDescription)
            }
          }
        }
        
        it("using a NSURLRequest and receives default response") {
          let expectation = self.expectationWithDescription("Stubs request using NSURLRequest")
          
          // Stub the request
          Velociraptor.request(request)
          let task = session.dataTaskWithRequest(request) { (data, res, error) in
            expectation.fulfill()
            
            let response = res as! NSHTTPURLResponse
            
            expect(data.length).to(equal(0))
            expect(response).notTo(beNil())
            expect(response.statusCode).to(equal(200))
            expect(error).to(beNil())
          }
          
          task.resume()
          self.waitForExpectationsWithTimeout(1) { error in
            if let error = error {
              XCTFail(error.localizedDescription)
            }
          }
        }
        
        it("using a stubbed request and receives default resposne") {
          let expectation = self.expectationWithDescription("Stubs request using VLRStubbedRequest object")
          
          // Stub the request
          let stubbedRequest = VLRStubbedRequest(URL: URL)
          Velociraptor.request(stubbedRequest)
          let task = session.dataTaskWithURL(URL) { (data, res, error) in
            expectation.fulfill()
            
            let response = res as! NSHTTPURLResponse
            
            expect(data.length).to(equal(0))
            expect(response).notTo(beNil())
            expect(response.statusCode).to(equal(200))
            expect(error).to(beNil())
          }
          
          task.resume()
          self.waitForExpectationsWithTimeout(1) { error in
            if let error = error {
              XCTFail(error.localizedDescription)
            }
          }
        }
      }
      
      // MARK: under the ephemeral session configuration
      context("under the ephemeral session configuration") {
        beforeEach {
          config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        }
        
        it("using an URL string and receives default response") {
          let expectation = self.expectationWithDescription("Stubs request using URL string")
          
          // Stub the request
          Velociraptor.request(URLString)
          let url = NSURL(string: URLString)!
          let task = session.dataTaskWithURL(url) { (data, res, error) in
            expectation.fulfill()
            
            let response = res as! NSHTTPURLResponse
            
            expect(data.length).to(equal(0))
            expect(response).notTo(beNil())
            expect(response.statusCode).to(equal(200))
            expect(error).to(beNil())
          }
          
          task.resume()
          self.waitForExpectationsWithTimeout(1) { error in
            if let error = error {
              XCTFail(error.localizedDescription)
            }
          }
        }
        
        it("using a NSURL and receives default response") {
          let expectation = self.expectationWithDescription("Stubs request using NSURL")
          
          // Stub the request
          Velociraptor.request(URL)
          let task = session.dataTaskWithURL(URL) { (data, res, error) in
            expectation.fulfill()
            
            let response = res as! NSHTTPURLResponse
            
            expect(data.length).to(equal(0))
            expect(response).notTo(beNil())
            expect(response.statusCode).to(equal(200))
            expect(error).to(beNil())
          }
          
          task.resume()
          self.waitForExpectationsWithTimeout(1) { error in
            if let error = error {
              XCTFail(error.localizedDescription)
            }
          }
        }
        
        it("using a NSURLRequest and receives default response") {
          let expectation = self.expectationWithDescription("Stubs request using NSURLRequest")
          
          // Stub the request
          Velociraptor.request(request)
          let task = session.dataTaskWithRequest(request) { (data, res, error) in
            expectation.fulfill()
            
            let response = res as! NSHTTPURLResponse
            
            expect(data.length).to(equal(0))
            expect(response).notTo(beNil())
            expect(response.statusCode).to(equal(200))
            expect(error).to(beNil())
          }
          
          task.resume()
          self.waitForExpectationsWithTimeout(1) { error in
            if let error = error {
              XCTFail(error.localizedDescription)
            }
          }
        }
        
        it("using a stubbed request and receives default resposne") {
          let expectation = self.expectationWithDescription("Stubs request using VLRStubbedRequest object")
          
          // Stub the request
          let stubbedRequest = VLRStubbedRequest(URL: URL)
          Velociraptor.request(stubbedRequest)
          let task = session.dataTaskWithURL(URL) { (data, res, error) in
            expectation.fulfill()
            
            let response = res as! NSHTTPURLResponse
            
            expect(data.length).to(equal(0))
            expect(response).notTo(beNil())
            expect(response.statusCode).to(equal(200))
            expect(error).to(beNil())
          }
          
          task.resume()
          self.waitForExpectationsWithTimeout(1) { error in
            if let error = error {
              XCTFail(error.localizedDescription)
            }
          }
        }
        
        
      }
    }
    
    
    
    // MARK: - Stubs HTTP method
    describe("Stubs HTTP method") {
      
      beforeEach {
        config = NSURLSessionConfiguration.defaultSessionConfiguration()
      }
        
      it("stubs POST request and receives default response") {
        let expectation = self.expectationWithDescription("Stubs POST requests")
        Velociraptor.request(URLString)?.requestHTTPMethod(.POST)
        
        let postRequest = request.mutableCopy() as! NSMutableURLRequest
        postRequest.HTTPMethod = "POST"
        let task = session.dataTaskWithRequest(postRequest) { (data, res, error) in
          expectation.fulfill()
          
          let response = res as! NSHTTPURLResponse
          
          expect(data.length).to(equal(0))
          expect(response).notTo(beNil())
          expect(response.statusCode).to(equal(200))
          expect(error).to(beNil())
        }
        
        task.resume()
        self.waitForExpectationsWithTimeout(1) { error in
          if let error = error {
            XCTFail(error.localizedDescription)
          }
        }
      }
      
      it("stubs PUT request and receives default response") {
        let expectation = self.expectationWithDescription("Stubs PUT requests")
        Velociraptor.request(URLString)?.requestHTTPMethod(.PUT)
        
        let putRequest = request.mutableCopy() as! NSMutableURLRequest
        putRequest.HTTPMethod = "PUT"
        let task = session.dataTaskWithRequest(putRequest) { (data, res, error) in
          expectation.fulfill()
          
          let response = res as! NSHTTPURLResponse
          
          expect(data.length).to(equal(0))
          expect(response).notTo(beNil())
          expect(response.statusCode).to(equal(200))
          expect(error).to(beNil())
        }
        
        task.resume()
        self.waitForExpectationsWithTimeout(1) { error in
          if let error = error {
            XCTFail(error.localizedDescription)
          }
        }
      }
      
      it("stubs DELETE request and receives default response") {
        let expectation = self.expectationWithDescription("Stubs DELETE requests")
        Velociraptor.request(URLString)?.requestHTTPMethod(.DELETE)
        
        let delRequest = request.mutableCopy() as! NSMutableURLRequest
        delRequest.HTTPMethod = "DELETE"
        let task = session.dataTaskWithRequest(delRequest) { (data, res, error) in
          expectation.fulfill()
          
          let response = res as! NSHTTPURLResponse
          
          expect(data.length).to(equal(0))
          expect(response).notTo(beNil())
          expect(response.statusCode).to(equal(200))
          expect(error).to(beNil())
        }
        
        task.resume()
        self.waitForExpectationsWithTimeout(1) { error in
          if let error = error {
            XCTFail(error.localizedDescription)
          }
        }
      }
    
      it("stubs PATCH request and receives default response") {
        let expectation = self.expectationWithDescription("Stubs PATCH requests")
        Velociraptor.request(URLString)?.requestHTTPMethod(.PATCH)
        
        let patchRequest = request.mutableCopy() as! NSMutableURLRequest
        patchRequest.HTTPMethod = "PATCH"
        let task = session.dataTaskWithRequest(patchRequest) { (data, res, error) in
          expectation.fulfill()
          
          let response = res as! NSHTTPURLResponse
          
          expect(data.length).to(equal(0))
          expect(response).notTo(beNil())
          expect(response.statusCode).to(equal(200))
          expect(error).to(beNil())
        }
        
        task.resume()
        self.waitForExpectationsWithTimeout(1) { error in
          if let error = error {
            XCTFail(error.localizedDescription)
          }
        }
      }
    }
    
    // MARK: - Stubs HTTP header fields
    describe("Stubs HTTP header fields") {
      
      let stubbedHeaders = ["Accept": "*", "Stubbued": "Headers"]
      
      beforeEach {
        config = NSURLSessionConfiguration.defaultSessionConfiguration()
      }
      
      it("uses .Exactly option and only matches when two header fields are exactly the same ") {
        let expectation = self.expectationWithDescription("HTTP header fields matched exactly")
        let stubbedHeaders = ["Accept": "*", "Stubbued": "Headers"]
        
        // Default option
        Velociraptor.headerFieldMatchingOption = .Exactly
        Velociraptor.request(URLString)?.requestHTTPHeaderFields(stubbedHeaders)
        let mutableRequest = request.mutableCopy() as! NSMutableURLRequest
        
        // Comment the following line to see the error.
        mutableRequest.allHTTPHeaderFields = stubbedHeaders
        
        let task = session.dataTaskWithRequest(mutableRequest) { (data, res, error) in
          expectation.fulfill()
          
          let response = res as! NSHTTPURLResponse
          
          expect(data.length).to(equal(0))
          expect(response).notTo(beNil())
          expect(response.statusCode).to(equal(200))
          expect(error).to(beNil())
        }
        
        task.resume()
        self.waitForExpectationsWithTimeout(1) { error in
          if let error = error {
            XCTFail(error.localizedDescription)
          }
        }
      }
      
      it("uses .Partially(1) option and matches when there is at least 1 common header field") {
        let expectation = self.expectationWithDescription("HTTP header fields matched exactly")
        
        Velociraptor.headerFieldMatchingOption = .Partially(1)
        Velociraptor.request(URLString)?.requestHTTPHeaderFields(stubbedHeaders)
        let mutableRequest = request.mutableCopy() as! NSMutableURLRequest
        
        // Comment the following line to see the error.
        mutableRequest.allHTTPHeaderFields = ["Accept": "*"]
        
        let task = session.dataTaskWithRequest(mutableRequest) { (data, res, error) in
          expectation.fulfill()
          
          let response = res as! NSHTTPURLResponse
          
          expect(data.length).to(equal(0))
          expect(response).notTo(beNil())
          expect(response.statusCode).to(equal(200))
          expect(error).to(beNil())
        }
        
        task.resume()
        self.waitForExpectationsWithTimeout(1) { error in
          if let error = error {
            XCTFail(error.localizedDescription)
          }
        }
      }
    }
    
  }
}