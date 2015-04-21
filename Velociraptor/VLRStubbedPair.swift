//
//  VLRStubbedPair.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/21/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

public class VLRStubbedPair {
  public var request: NSMutableURLRequest
  public var response: NSHTTPURLResponse
  
  init(request: NSMutableURLRequest, response: NSHTTPURLResponse) {
    self.request = request
    self.response = response
  }
}

extension VLRStubbedPair: Equatable {
  
}

public func ==(lhs: VLRStubbedPair, rhs: VLRStubbedPair) -> Bool {
  return (lhs.request == rhs.request) && (lhs.response == rhs.response)
}