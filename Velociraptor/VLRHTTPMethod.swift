//
//  VLRHTTPMethod.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/23/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

/**
  HTTP method definitions.

  See http://tools.ietf.org/html/rfc7231#section-4.3
*/
public enum VLRHTTPMethod: String {
  case GET = "GET"
  case POST = "POST"
  case PUT = "PUT"
  case DELETE = "DELETE"
  case OPTION = "OPTION"
  case HEAD = "HEAD"
  case TRACE = "TRACE"
  case CONNECT = "CONNECT"
  
  func matchesIncomingHTTPMethod(method: String?) -> Bool {
    let HTTPMethod = method ?? VLRHTTPMethod.GET.rawValue
    return self.rawValue == method
  }
}

// MARK: - Printable
extension VLRHTTPMethod {
  public var description: String {
    return rawValue
  }
}

// MARK: - DebugPrintable
extension VLRHTTPMethod {
  public var debugPrintable: String {
    return description
  }
}