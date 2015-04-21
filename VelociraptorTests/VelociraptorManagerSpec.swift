//
//  VelociraptorManagerSpec.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/21/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation
import Quick
import Nimble

class VelociraptorManagerSpec: QuickSpec {
  
  var manager: VelociraptorManager = VelociraptorManager.sharedManager
  
  let URLString = "http://www.google.com"
  let anotherURLString = "http://www.leetcode.com"
  let invalidURLString = "www.google.com"
  
  override func spec() {
    describe("Using default `request` method") {
      context("accepts String as parameter") {
        it("a valid URL string and returns an instance of VLRStubbedPair") {
          let pair = self.manager.request(self.URLString)
          expect(pair).toNot(beNil())
        }
        
        it("an invalid URL string and returns nil") {
          let pair = self.manager.request(self.invalidURLString)
          expect(pair).to(beNil())
        }
      }
      
      context("accepts NSURL as parameter") {
        it("a valid URL an returns an instance of VLRStubbedPair") {
          let URL = NSURL(string: self.URLString)
          let pair = self.manager.request(URL!)
          expect(pair).toNot(beNil())
        }
        
        it("an invalid URL and returns nil") {
          let URL = NSURL(string: self.invalidURLString)
          let pair = self.manager.request(URL!)
          expect(pair).to(beNil())
        }
      }
      
      context("accepts NSURLRequest as parameter") {
        it("a valid request an returns an instance of VLRStubbedPair") {
          let URL = NSURL(string: self.URLString)
          let request = NSURLRequest(URL: URL!)
          let pair = self.manager.request(request)
          expect(pair).toNot(beNil())
        }
        
        it("an invalid request and returns nil") {
          let URL = NSURL(string: self.invalidURLString)
          let request = NSURLRequest(URL: URL!)
          let pair = self.manager.request(request)
          expect(pair).to(beNil())
        }
      }
    }
    
    describe("When retrieving stubbed pairs") {
      context("accepts String as parameter") {
        it("retrieves a requested string and returns the same stubbed pair") {
          let pair = self.manager.request(self.URLString)
          
          let retrievedPair = self.manager.stubbedPairWithURLRequest(self.URLString)
          expect(pair).to(equal(retrievedPair))
          
        }
        
        it("retrieves a new URL string and returns nil") {
          self.manager.request(self.URLString)
          let retrievedPair = self.manager.stubbedPairWithURLRequest(self.anotherURLString)
          
          expect(retrievedPair).to(beNil())
        }
      }
      
      context("accepts NSURL as parameter") {
        it("retrieves a requested URL and returns the same stubbed pair") {
          let URL = NSURL(string: self.URLString)!
          let pair = self.manager.request(URL)
          let retrievedPair = self.manager.stubbedPairWithURLRequest(URL)
          expect(pair).to(equal(retrievedPair))
        }
        
        it("retrieves a new URL and returns nil") {
          let URL = NSURL(string: self.URLString)!
          let anotherURL = NSURL(string: self.anotherURLString)!
          self.manager.request(URL)
          let retrievedPair = self.manager.stubbedPairWithURLRequest(anotherURL)
          expect(retrievedPair).to(beNil())
        }
      }

      context("accepts NSURLRequest as parameter") {
        it("retrieves a requested request an returns the same stubbed pair") {
          let URL = NSURL(string: self.URLString)!
          let request = NSURLRequest(URL: URL)
          let pair = self.manager.request(request)
          let retrievedPair = self.manager.stubbedPairWithURLRequest(request)
          expect(pair).to(equal(retrievedPair))
        }
        
        it("retrieves a new request and returns nil") {
          let URL = NSURL(string: self.URLString)!
          let request = NSURLRequest(URL: URL)
          
          let anotherURL = NSURL(string: self.anotherURLString)!
          let anotherRequest = NSURLRequest(URL: anotherURL)
          
          self.manager.request(request)
          
          let retrievedPair = self.manager.stubbedPairWithURLRequest(anotherRequest)
          expect(retrievedPair).to(beNil())
        }
      }
    }
    
    afterEach {
      self.manager.clearStubs()
    }
  }
}