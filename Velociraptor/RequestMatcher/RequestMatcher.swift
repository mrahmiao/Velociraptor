//
//  RequestMatcher.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/4/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

/**
  A container struct used to check whether requests matched.
*/
struct RequestMatcher {
  private var matchers: [RequestMatchable]
  private var incomingRequest: NSURLRequest
  private var stubbedRequest: VLRStubbedRequest
  
  init(incomingRequest: NSURLRequest, stubbedRequest: VLRStubbedRequest, matchers: [RequestMatchable]) {
    self.incomingRequest = incomingRequest
    self.stubbedRequest = stubbedRequest
    self.matchers = matchers
  }
  
  func matches() -> Bool {
    let initial = MatchResult<NSURLRequest>.Success(Box(value: incomingRequest))
    let matchingResult = matchers.reduce(initial) { (result, matcher) -> MatchResult<NSURLRequest> in
      
      let closure = { (request) -> MatchResult<NSURLRequest> in
        return matcher.incomingRequest(request, matchesStubbedRequest: self.stubbedRequest)
      }
      
      return result.check(closure)
    }
    
    switch matchingResult {
    case .Success(_):
      return true
    case .Failure(let errorMessage):
      NSLog("\(errorMessage)")
      return false
    }
  }
}
