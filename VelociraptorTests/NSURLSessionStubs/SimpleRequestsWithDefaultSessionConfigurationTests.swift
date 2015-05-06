//
//  SimpleRequestsWithDefaultSessionConfigurationTests.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/6/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation
import XCTest
import Velociraptor

class SimpleRequestsWithDefaultSessionConfigurationTests: NSURLSessionStubsTestCase {
  
  override func setUp() {
    config = NSURLSessionConfiguration.defaultSessionConfiguration()
  }
  
  
  
}
