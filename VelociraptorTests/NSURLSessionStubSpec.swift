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
    
    var config: NSURLSessionConfiguration!
    var session: NSURLSession!
    
    beforeSuite {
      Velociraptor.activate()
    }
    
    afterSuite {
      let manager = VelociraptorManager.sharedManager
      Velociraptor.deactivate()
    }
    
    afterEach {
      Velociraptor.clearStubs()
    }
    
    describe("Using global request method to stub requests without further customization") {
      
      context("using default session configuration") {
        beforeEach {
          config = NSURLSessionConfiguration.defaultSessionConfiguration()
          session = NSURLSession(configuration: config)
        }
        
        it("stubs request using a simple string") {
          let expectation = self.expectationWithDescription("Stub request using URLString")
          Velociraptor.request(URLString)
          
          let task = session.dataTaskWithURL(NSURL(string: URLString)!) { data, res, err in
            let httpResponse = res as! NSHTTPURLResponse
            expectation.fulfill()
            expect(httpResponse).notTo(beNil())
            expect(httpResponse.statusCode).to(equal(200))
            expect(httpResponse.allHeaderFields.count).to(equal(0))
          }
          
          task.resume()
          self.waitForExpectationsWithTimeout(1, handler: nil)
        }
        
        it("stubs request using NSURL") {
          let expectation = self.expectationWithDescription("stubs request using NSURL")
          Velociraptor.request(URL)
          
          let task = session.dataTaskWithURL(URL) { data, res, err in
            let httpResponse = res as! NSHTTPURLResponse
            expectation.fulfill()
            expect(httpResponse).notTo(beNil())
            expect(httpResponse.statusCode).to(equal(200))
            expect(httpResponse.allHeaderFields.count).to(equal(0))
          }
          
          task.resume()
          self.waitForExpectationsWithTimeout(1, handler: nil)
        }
        
        it("stubs request using NSURLRequest") {
          let expectation = self.expectationWithDescription("stubs request using NSURL")
          Velociraptor.request(request)
          
          let task = session.dataTaskWithRequest(request) { data, res, err in
            let httpResponse = res as! NSHTTPURLResponse
            expectation.fulfill()
            expect(httpResponse).notTo(beNil())
            expect(httpResponse.statusCode).to(equal(200))
            expect(httpResponse.allHeaderFields.count).to(equal(0))
          }
          
          task.resume()
          self.waitForExpectationsWithTimeout(1, handler: nil)
        }
        
        afterEach {
          session = nil
          config = nil
        }
      }
      
      context("using ephemeral session configuration") {
        beforeEach {
          config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
          session = NSURLSession(configuration: config)
        }
        
        it("stubs request using a simple string") {
          let expectation = self.expectationWithDescription("Stub request using URLString")
          Velociraptor.request(URLString)
          
          let task = session.dataTaskWithURL(NSURL(string: URLString)!) { data, res, err in
            let httpResponse = res as! NSHTTPURLResponse
            expectation.fulfill()
            expect(httpResponse).notTo(beNil())
            expect(httpResponse.statusCode).to(equal(200))
            expect(httpResponse.allHeaderFields.count).to(equal(0))
          }
          
          task.resume()
          self.waitForExpectationsWithTimeout(1, handler: nil)
        }
        
        it("stubs request using NSURL") {
          let expectation = self.expectationWithDescription("stubs request using NSURL")
          Velociraptor.request(URL)
          
          let task = session.dataTaskWithURL(URL) { data, res, err in
            let httpResponse = res as! NSHTTPURLResponse
            expectation.fulfill()
            expect(httpResponse).notTo(beNil())
            expect(httpResponse.statusCode).to(equal(200))
            expect(httpResponse.allHeaderFields.count).to(equal(0))
          }
          
          task.resume()
          self.waitForExpectationsWithTimeout(1, handler: nil)
        }
        
        it("stubs request using NSURLRequest") {
          let expectation = self.expectationWithDescription("stubs request using NSURLRequest")
          Velociraptor.request(request)
          
          let task = session.dataTaskWithRequest(request) { data, res, err in
            let httpResponse = res as! NSHTTPURLResponse
            expectation.fulfill()
            expect(httpResponse).notTo(beNil())
            expect(httpResponse.statusCode).to(equal(200))
            expect(httpResponse.allHeaderFields.count).to(equal(0))
          }
          
          task.resume()
          self.waitForExpectationsWithTimeout(1, handler: nil)
        }
        
        afterEach {
          session = nil
          config = nil
        }
      }
    }
    
    describe("Customizing stubbed requests") {
      beforeEach {
        config = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: config)
      }
      
      afterEach {
        config = nil
        session = nil
      }
    }
  }
}