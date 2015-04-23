//
//  VLRStubbedPair.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/21/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

public class VLRStubbedPair {
  var request: VLRStubbedRequest
  var response: VLRStubbedResponse?
  
  init(request: VLRStubbedRequest, response: VLRStubbedResponse? = nil) {
    self.request = request
    self.response = response
  }
}

// MARK: - Printable
extension VLRStubbedPair: Printable {
  public var description: String {
    var text = "Request: \(request)\n"
    
    if let response = response {
      text += "Response: \(response)\n"
    }
    
    return text
  }
}

// MARK: - DebugPrintable
extension VLRStubbedPair: DebugPrintable {
  public var debugDescription: String {
    return description
  }
}

// MARK: - Request Match Methods
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

  private func matchesURLWithRequest(incomingRequest: NSURLRequest) -> MatchResult<NSURLRequest> {
    if incomingRequest.URL?.absoluteString == request.URL {
        return .Success(Box(value: incomingRequest))
    }

    return .Failure("URL not match: expected \(request.URL), got \(incomingRequest.URL?.absoluteString)")
  }

  private func matchesHTTPMethodWithRequest(incomingRequest: NSURLRequest) -> MatchResult<NSURLRequest> {
    let stubbedRequestHTTPMethod = request.HTTPMethod.rawValue
    if incomingRequest.HTTPMethod == stubbedRequestHTTPMethod {
      return .Success(Box(value: incomingRequest))
    }

    return .Failure("HTTP Method not match: expected \(request.HTTPMethod.rawValue), got \(incomingRequest.HTTPMethod!)")
  }

  private func matchesHeaderFieldsWithRequest(incomingRequest: NSURLRequest) -> MatchResult<NSURLRequest> {
    if incomingRequest.allHTTPHeaderFields == nil && request.HTTPHeaderFields.count == 0 {
      return .Success(Box(value: incomingRequest))
    }

    let errorMessage = "HTTP header fields not match"

    if let incomingHeaderFields = incomingRequest.allHTTPHeaderFields {
      if incomingHeaderFields.count != request.HTTPHeaderFields.count {
        return .Failure(errorMessage)
      }

      for (key, headerValue) in incomingHeaderFields {
        let incomingHeaderFiledValue = headerValue as? String
        let stubbedHeaderFieldValue = request.HTTPHeaderFields[key as! String]
        
        if incomingHeaderFiledValue != stubbedHeaderFieldValue {
          return .Failure(errorMessage)
        }
      }

      return .Success(Box(value: incomingRequest))
    } else {
      return .Failure(errorMessage)
    }
  }

  private func matchesHTTPBodyDataWithRequest(incomingRequest: NSURLRequest) -> MatchResult<NSURLRequest> {
    if incomingRequest.HTTPBody == request.HTTPBody {
      return .Success(Box(value: incomingRequest))
    }

    return .Failure("HTTP body data not match")
  }
}

// MARK: - Request DSL
extension VLRStubbedPair {
  public func requestHTTPMethod(method: VLRHTTPMethod) -> Self {
    request.HTTPMethod = method
    return self
  }
  
  public func requestHeaderValue(value: String, forHTTPHeaderField field: String) -> Self {
    return self
  }
  
  public func requestHTTPHeaderFields(headers: [String: String]) -> Self {
    return self
  }
  
  public func requestBodyData(data: NSData) -> Self {
    return self
  }
}

// MARK: - Response DSL
extension VLRStubbedPair {
  
  public func responseHeaderValue(value: String, forHTTPHeaderField field: String) -> Self {
    return self
  }
  
  public func responseHTTPHeaderFields(headers: [NSObject: AnyObject]) -> Self {
    return self
  }
  
  public func responseStatusCode(statusCode: Int, failedWithError error: NSError? = nil) -> Self {
    return self
  }
  
  public func responseBodyData(data: NSData) -> Self {
    return self
  }
}