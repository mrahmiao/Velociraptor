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
  public var response: NSHTTPURLResponse?
  
  init(request: NSMutableURLRequest, response: NSHTTPURLResponse? = nil) {
    self.request = request
    self.response = response
  }
}

extension VLRStubbedPair {
  func matchesRequest(incomingRequest: NSURLRequest) -> Bool {
    let result = MatchResult<NSURLRequest>.Success(Box(value: incomingRequest))
        .check(matchesURLWithRequest)
        .check(matchesHTTPMethodWithRequest)
        .check(matchesHeaderFieldsWithRequest)
        .check(matchesHTTPBodyDataWithRequest)

    switch result {
    case .Success(_):
      return true
    case .Failure(let errorMessage):
      NSLog("\(errorMessage)")
      return false
    }
  }

  func matchesURLWithRequest(incomingRequest: NSURLRequest) -> MatchResult<NSURLRequest> {
    if incomingRequest.URL == request.URL {
      return .Success(Box(value: incomingRequest))
    }

    return .Failure("URL not match")
  }

  func matchesHTTPMethodWithRequest(incomingRequest: NSURLRequest) -> MatchResult<NSURLRequest> {
    if incomingRequest.HTTPMethod == request.HTTPMethod {
      return .Success(Box(value: incomingRequest))
    }

    return .Failure("HTTP Method not match")
  }

  func matchesHeaderFieldsWithRequest(incomingRequest: NSURLRequest) -> MatchResult<NSURLRequest> {
    if incomingRequest.allHTTPHeaderFields == nil && request.allHTTPHeaderFields == nil {
      return .Success(Box(value: incomingRequest))
    }

    let errorMessage = "HTTP header fields not match"

    if let incomingHeaderFields = incomingRequest.allHTTPHeaderFields, stubbedHeaderFields = request.allHTTPHeaderFields {
      if incomingHeaderFields.count != stubbedHeaderFields.count {
        return .Failure(errorMessage)
      }

      for (key, headerValue) in incomingHeaderFields {
        let incomingHeaderFiledValue = headerValue as? String
        let stubbedHeaderFieldValue = stubbedHeaderFields[key] as? String
        
        if incomingHeaderFiledValue != stubbedHeaderFieldValue {
          return .Failure(errorMessage)
        }
      }

      return .Success(Box(value: incomingRequest))
    } else {
      return .Failure(errorMessage)
    }
  }

  func matchesHTTPBodyDataWithRequest(incomingRequest: NSURLRequest) -> MatchResult<NSURLRequest> {
    if incomingRequest.HTTPBody == request.HTTPBody {
      return .Success(Box(value: incomingRequest))
    }

    return .Failure("HTTP body data not match")
  }

}

// MARK: - Equatable
extension VLRStubbedPair: Equatable {
  
}

public func ==(lhs: VLRStubbedPair, rhs: VLRStubbedPair) -> Bool {
  return (lhs.request == rhs.request) && (lhs.response == rhs.response)
}