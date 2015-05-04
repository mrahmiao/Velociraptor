//
//  URLMatcher.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/4/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

class URLMatcher: RequestMatchable {
  func incomingRequest(request: NSURLRequest, matchesStubbedRequest stubbedRequest: VLRStubbedRequest) -> MatchResult<NSURLRequest> {
    if request.URL?.absoluteString == stubbedRequest.URL {
      return .Success(Box(value: request))
    }
    
    return .Failure("URL not match: expected \(stubbedRequest.URL), got \(request.URL?.absoluteString)")
  }
}
