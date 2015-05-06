//
//  RequestMatchable.swift
//  Velociraptor
//
//  Created by mrahmiao on 5/4/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

/**
  This `RequestMatchable` protocol defines a method that objects can implement to match requests.
*/
protocol RequestMatchable {
  
  /**
    Checks whether the incoming request matches the stubbed request.
  
    :param: request The incoming request you received.
    :param: stubbedRequest The request you stubbed.
  
    :returns: A `MatchResult` enum that indicates two requests match or not.
  */
  func incomingRequest(request: NSURLRequest, matchesStubbedRequest stubbedRequest: VLRStubbedRequest) -> MatchResult<NSURLRequest>
}

