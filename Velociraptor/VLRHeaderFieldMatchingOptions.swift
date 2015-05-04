//
//  VLRHeaderFieldMatchingOptions.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/27/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

/**
  Options to control the behavior of matching request header fields.
*/
public enum VLRHeaderFieldMatchingOptions {
  /**
    `Exactly` indicates that the header fields of incoming request and
    the header fields of stubbed request must be exactly the same.
  */
  case Exactly
  
  /**
    Uses the associated `UInt` value to specify the minimum number of common
    header fields of both incoming request and stubbed request.
  
    When the number of common header fields greater or equal than the specified
    minimum number, the incoming request will be matched.
  
    Note that if the number is set to `0`, and this option is
    identical to `.Arbitrarily`. And the maximum of it is the number
    of the stubbed header fields.
  */
  case Partially(UInt)
  
  /**
    Only when the header fields of incoming request are a strict subset of
    the header fields of stubbed request, the match will succeed.
  */
  case StrictSubset
  
  /**
    Match requests with arbitray header fields.
  */
  case Arbitrarily
  
  /**
    Checks whether two header fields match or not.
  
    :param: fields Header fields of incoming request.
    :param: stubbedFields Header fields of stubbed request.
  
    :returns: true if two header fields matched, otherwise returns false.
  */
  func incomingHeaderFields(fields: [NSObject: AnyObject], matchesStubbedHeaderFields stubbedFields: [String: String]) -> Bool {
    
    switch self {
    case .Exactly:
      
      // The number of header fields must be the same.
      if fields.count != stubbedFields.count {
        return false
      }
      
      var incomingHeaders = fields.vlr_canonicalHTTPHeaderFields
      var stubbedHeaders = stubbedFields.vlr_canonicalHTTPHeaderFields
      
      let incomingHeaderNames = Set(incomingHeaders.keys)
      let stubbedHeaderNames = Set(stubbedHeaders.keys)
      
      // The header field names must be identical
      if incomingHeaderNames != stubbedHeaderNames {
        return false
      }
      
      for headerName in incomingHeaderNames {
        if incomingHeaders[headerName] != stubbedHeaders[headerName] {
          return false
        }
      }
      
      return true
    case .Partially(var minimumNumber):
      
      if minimumNumber == 0 {
        return true
      }
      
      if minimumNumber > UInt(stubbedFields.count) {
        minimumNumber = UInt(stubbedFields.count)
      }
      
      var numberOfMatchedHeaderFields: UInt = 0
      
      var incomingHeaderFields = fields.vlr_canonicalHTTPHeaderFields
      var stubbedHeaderFields = stubbedFields.vlr_canonicalHTTPHeaderFields
      
      // Find the header fields with less elements
      let headerFields = fields.count > stubbedFields.count ? stubbedHeaderFields : incomingHeaderFields
      
      let headerNames = Set(headerFields.keys)
      
      // Can not match header fields with which the number of elments is 
      // less than minimumNumber
      if UInt(headerNames.count) < minimumNumber {
        return false
      }
      
      for headerName in headerNames {
        if incomingHeaderFields[headerName] == stubbedHeaderFields[headerName] {
          numberOfMatchedHeaderFields += 1
        }
      }
      
      if numberOfMatchedHeaderFields >= minimumNumber {
        return true
      } else {
        return false
      }
      
    case .StrictSubset:
      if fields.count >= stubbedFields.count {
        return false
      }
      
      var incomingHeaders = fields.vlr_canonicalHTTPHeaderFields
      var stubbedHeaders = stubbedFields.vlr_canonicalHTTPHeaderFields
      
      let incomingHeaderNames = Set(incomingHeaders.keys)
      let stubbedHeaderNames = Set(stubbedHeaders.keys)
      
      if !incomingHeaderNames.isStrictSubsetOf(stubbedHeaderNames) {
        return false
      }
      
      // Empty set
      if incomingHeaderNames.isEmpty {
        return true
      }
      
      for (key, incomingHeaderValue) in incomingHeaders {
        if incomingHeaderValue != stubbedHeaders[key] {
          return false
        }
      }
      
      return true
      
    case .Arbitrarily:
      
      // Always match
      return true
    }
  }
}

// TODO: Type casting from AnyObject to the correct target type.
private extension Dictionary {
  private var vlr_canonicalHTTPHeaderFields: [String: String] {
    var fields = [String: String]()
    
    for (key, value) in self {
      let lowercaseKey = (key as! String).lowercaseString
      let headerValue = value as! String
      fields[lowercaseKey] = headerValue
    }
    
    return fields
  }
}

// MARK: - Printable
extension VLRHeaderFieldMatchingOptions: Printable {
  public var description: String {
    switch self {
    case .Exactly:
      return ".Exactly"
    case .Partially(let minimumNumber):
      return ".Partially(\(minimumNumber))"
    case .StrictSubset:
      return ".StrictSubset"
    case .Arbitrarily:
      return ".Arbitrarily"
    }
  }
}

// MARK: - DebugPrintable
extension VLRHeaderFieldMatchingOptions: DebugPrintable {
  public var debugDescription: String {
    return description
  }
}