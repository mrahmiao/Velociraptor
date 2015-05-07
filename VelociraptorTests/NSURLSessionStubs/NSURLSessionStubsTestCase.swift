//
//  NSURLSessionStubsTestCase.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/6/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation
import XCTest
import Velociraptor

class NSURLSessionStubsTestCase: XCTestCase {
  
  var URLString = "https://github.com/mrahmiao/Velociraptor"
  
  lazy var URL: NSURL = {
    return NSURL(string: self.URLString)!
  }()
  
  lazy var request: NSURLRequest = {
    return NSURLRequest(URL: self.URL)
  }()
  
  var session: NSURLSession!
  var config: NSURLSessionConfiguration! {
    didSet {
      if let config = config {
        session = NSURLSession(configuration: config)
      }
    }
  }
  
  override class func setUp() {
    super.setUp()
    Velociraptor.activate()
  }
  
  override class func tearDown() {
    Velociraptor.deactivate()
    super.tearDown()
  }
  
  override func tearDown() {
    config = nil
    super.tearDown()
  }
}
