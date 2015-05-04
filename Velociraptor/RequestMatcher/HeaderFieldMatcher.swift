//
//  HeaderFieldMatcher.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/4/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

class HeaderFieldMatcher: RequestMatchable {
  
  private var matchingOption: VLRHeaderFieldMatchingOptions
  
  init(option: VLRHeaderFieldMatchingOptions) {
    matchingOption = option
  }
  
  func incomingRequest(request: NSURLRequest, matchesStubbedRequest stubbedRequest: VLRStubbedRequest) -> MatchResult<NSURLRequest> {
    let incomingHeaderFields = request.allHTTPHeaderFields ?? [:]
    
    let matched = matchingOption.incomingHeaderFields(incomingHeaderFields, matchesStubbedHeaderFields: stubbedRequest.HTTPHeaderFields)
    
    if matched {
      return .Success(Box(value: request))
    }
    
    let message = "Header fields not match with matching option: \(headerFieldMatchingOption)." +
      "\nExpected header fields: \(stubbedRequest.HTTPHeaderFields)" +
    "\nActual header fields: \(incomingHeaderFields)"
    return .Failure(message)
  }
}