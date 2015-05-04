//
//  BodyDataMatcher.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/4/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

class BodyDataMatcher: RequestMatcher {
  func incomingRequest(request: NSURLRequest, matchesStubbedRequest stubbedRequest: VLRStubbedRequest) -> MatchResult<NSURLRequest> {
    let bodyData = NSURLProtocol.propertyForKey(HTTPBodyDataKey, inRequest: request) as? NSData
    if bodyData == stubbedRequest.HTTPBody {
      return .Success(Box(value: request))
    }
    
    let message = "HTTP body data not match" +
      "\nExpected body data length: \(stubbedRequest.HTTPBody?.length ?? 0)" +
    "\nActual body data length: \(bodyData?.length ?? 0)"
    return .Failure(message)
  }
}
