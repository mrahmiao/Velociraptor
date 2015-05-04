//
//  HTTPMethodMatcher.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/4/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

class HTTPMethodMatcher: RequestMatchable {
  
  func incomingRequest(request: NSURLRequest, matchesStubbedRequest stubbedRequest: VLRStubbedRequest) -> MatchResult<NSURLRequest> {
    
    if stubbedRequest.HTTPMethod.matchesIncomingHTTPMethod(request.HTTPMethod) {
      return .Success(Box(value: request))
    }
    
    return .Failure("HTTP Method not match: expected \(stubbedRequest.HTTPMethod.rawValue), got \(request.HTTPMethod!)")
  }
  
}