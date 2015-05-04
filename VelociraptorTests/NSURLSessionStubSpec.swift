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
    
    describe("Stubbing requests") {
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
          let expectation = self.expectationWithDescription("Exactly matching")
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
          let expectation = self.expectationWithDescription("Partially matching")
          
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
        
        it("uses .StrictSubset option and only matches empty set") {
          let expectation = self.expectationWithDescription("Strict subset matching")
          
          Velociraptor.headerFieldMatchingOption = .StrictSubset
          Velociraptor.request(URLString)?.requestHTTPHeaderFields(stubbedHeaders)
          let mutableRequest = request.mutableCopy() as! NSMutableURLRequest
          
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
        
        it("uses .Arbitrarily option and matches arbitrary requests") {
          let expectation = self.expectationWithDescription("Arbitrarily matching")
          
          Velociraptor.headerFieldMatchingOption = .Arbitrarily
          Velociraptor.request(URLString)?.requestHTTPHeaderFields(stubbedHeaders)
          let mutableRequest = request.mutableCopy() as! NSMutableURLRequest
          mutableRequest.allHTTPHeaderFields = ["Accept": "*", "Others": "Someothers"]
          
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
      
      // MARK: - Stubs HTTP body data
      describe("Stubs HTTP body data") {
        beforeEach {
          config = NSURLSessionConfiguration.defaultSessionConfiguration()
        }
        
        it("matches when HTTP body data is identical") {
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
    
    // MARK: - Stubbing responses
    describe("Stubbing responses") {
      
      beforeEach {
        config = NSURLSessionConfiguration.defaultSessionConfiguration()
      }
      
      describe("with a stubbed VLRStubbedResposne object") {
        it("stubs a normal response") {
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
            
            let response = res as! NSHTTPURLResponse
            expect(response.URL).to(equal(URL))
            expect(response.statusCode).to(equal(statusCode))
            for (key, value) in response.allHeaderFields {
              let key = key as! String
              let value = value as! String
              expect(value).to(equal(expectedResponse.HTTPHeaderFields[key]))
            }
            expect(data).to(equal(bodyData))
          }
          
          task.resume()
          self.waitForExpectationsWithTimeout(1) { error in
            if let error = error {
              XCTFail(error.localizedDescription)
            }
          }
        }
      }
      
      describe("with single stub methods") {
        it("stubs a single header field") {
          let expectation = self.expectationWithDescription("single header field")
          let headerValue = "application/x-velociraptor"
          let headerField = "Content-Type"
          Velociraptor.request(URL)?.responseHeaderValue(headerValue, forHTTPHeaderField: headerField)
          
          let task = session.dataTaskWithURL(URL) { (data, res, error) in
            expectation.fulfill()
            
            let response = res as! NSHTTPURLResponse
            
            expect(response.allHeaderFields.count).to(equal(1))
            expect((response.allHeaderFields[headerField] as! String)).to(equal(headerValue))
          }
          
          task.resume()
          self.waitForExpectationsWithTimeout(1) { error in
            if let error = error {
              XCTFail(error.localizedDescription)
            }
          }
        }
        
        it("stubs multiple header fields") {
          let expectation = self.expectationWithDescription("multiple header fields")
          let headerFields = [
            "Content-Type": "application/json",
            "AuthKey": "Biu",
            "Title": "Velociraptor"]
          
          Velociraptor.request(URL)?.responseHTTPHeaderFields(headerFields)
          
          let task = session.dataTaskWithURL(URL) { (data, res, error) in
            expectation.fulfill()
            
            let response = res as! NSHTTPURLResponse
            
            expect(response.allHeaderFields.count).to(equal(3))
            expect((response.allHeaderFields as! [String: String])).to(equal(headerFields))
          }
          
          task.resume()
          self.waitForExpectationsWithTimeout(1) { error in
            if let error = error {
              XCTFail(error.localizedDescription)
            }
          }
        }
        
        it("stubs status code") {
          let expectation = self.expectationWithDescription("stubs status code")
          let statusCode = 301
          
          Velociraptor.request(URL)?.responseStatusCode(statusCode)
          
          let task = session.dataTaskWithURL(URL) { (data, res, error) in
            expectation.fulfill()
            
            let response = res as! NSHTTPURLResponse
            
            expect(response.statusCode).to(equal(statusCode))
          }
          
          task.resume()
          self.waitForExpectationsWithTimeout(1) { error in
            if let error = error {
              XCTFail(error.localizedDescription)
            }
          }
        }
        
        it("stubs an error response") {
          let expectation = self.expectationWithDescription("Stub error response")
          
          let errorCode = 1234
          let userInfo = ["Error": "StubbedError"]
          let domain = "com.code4blues.mrahmiao.velociraptor"
          let stubbedError = NSError(domain: domain, code: errorCode, userInfo: userInfo)
          
          Velociraptor.request(URL)?.failWithError(stubbedError)
          
          let task = session.dataTaskWithURL(URL) { (data ,res, receivedError) in
            expectation.fulfill()
            
            expect(data.length).to(equal(0))
            expect(res).to(beNil())
            expect(receivedError).to(equal(stubbedError))
          }
          
          task.resume()
          self.waitForExpectationsWithTimeout(1) { error in
            if let error = error {
              XCTFail(error.localizedDescription)
            }
          }
        }
        
        it("stubs body data of response") {
          
          let bodyData = "Hello World".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
          
          var receivedData: NSData! = nil
          Velociraptor.request(URL)?.responseBodyData(bodyData)
          
          let task = session.dataTaskWithURL(URL) { (data, res, err) in
            
            receivedData = data
          }
          
          task.resume()
          expect(receivedData).toEventually(equal(bodyData))
        }
        
        it("stubs JSON body data of response") {
          let JSONObject: AnyObject = [
            "Number": 5,
            "Bool": false,
            "Array": [5, 4, 3]
          ]
          
          let JSONData = NSJSONSerialization.dataWithJSONObject(JSONObject, options: NSJSONWritingOptions.allZeros, error: nil)
          
          Velociraptor.request(URL)?.responseJSONData(JSONObject)
          
          var receivedData: NSData!
          let task = session.dataTaskWithURL(URL) { (data, res, err) in
            receivedData = data
          }
          
          task.resume()
          
          expect(receivedData).toEventually(equal(JSONData))
        }
      }
    }
    
    // MARK: - Using convenience methods
    describe("Using convenience methods") {
      
      beforeEach {
        config = NSURLSessionConfiguration.defaultSessionConfiguration()
      }
      
      it("stubs GET request and uses default response") {
        let expectation = self.expectationWithDescription("Convenience GET method")
        Velociraptor.GET(URL)
        
        let task = session.dataTaskWithURL(URL) { (data, res, err) in
          expectation.fulfill()
          let receivedRes = res as! NSHTTPURLResponse
          expect(receivedRes.URL).to(equal(URL))
          expect(receivedRes.statusCode).to(equal(200))
        }
        
        task.resume()
        self.waitForExpectationsWithTimeout(1) { error in
          if let error = error {
            XCTFail(error.localizedDescription)
          }
        }
      }
      
      it("stubs POST request and uses default response") {
        let expectation = self.expectationWithDescription("Convenience POST method")
        Velociraptor.POST(URL)
        
        let mutableRequest = request.mutableCopy() as! NSMutableURLRequest
        mutableRequest.HTTPMethod = VLRHTTPMethod.POST.rawValue
        
        let task = session.dataTaskWithRequest(mutableRequest) { (data, res, err) in
          expectation.fulfill()
          let receivedRes = res as! NSHTTPURLResponse
          expect(receivedRes.URL).to(equal(URL))
          expect(receivedRes.statusCode).to(equal(200))
        }
        
        task.resume()
        self.waitForExpectationsWithTimeout(1) { error in
          if let error = error {
            XCTFail(error.localizedDescription)
          }
        }
      }
      
      it("stubs PUT request and uses default response") {
        let expectation = self.expectationWithDescription("Convenience PUT method")
        Velociraptor.PUT(URL)
        
        let mutableRequest = request.mutableCopy() as! NSMutableURLRequest
        mutableRequest.HTTPMethod = VLRHTTPMethod.PUT.rawValue
        
        let task = session.dataTaskWithRequest(mutableRequest) { (data, res, err) in
          expectation.fulfill()
          let receivedRes = res as! NSHTTPURLResponse
          expect(receivedRes.URL).to(equal(URL))
          expect(receivedRes.statusCode).to(equal(200))
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