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
      Velociraptor.deactivate()
    }
    
    afterEach {
      config = nil
      session = nil
      Velociraptor.clearStubs()
    }
  }
}