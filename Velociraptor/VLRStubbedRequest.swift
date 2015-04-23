//
//  VLRStubbedRequest.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/23/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

public class VLRStubbedRequest {
  var HTTPMethod: VLRHTTPMethod = .GET
  var URL: String
  var HTTPBody: NSData?
  var HTTPHeaderFields: [String: String] = [:]
  
  init(URL: VLRURLStringConvertible, HTTPMethod method: VLRHTTPMethod = .GET) {
    self.URL = URL.URLString
    self.HTTPMethod = method
  }
  
  convenience init(rawRequest: NSURLRequest) {
    let method = VLRHTTPMethod(rawValue: rawRequest.HTTPMethod!) ?? VLRHTTPMethod.GET
    self.init(URL: rawRequest, HTTPMethod: method)
    
    if let headerFields = rawRequest.allHTTPHeaderFields as? [String: String] {
      HTTPHeaderFields = headerFields
    }
  }
}

// MARK: - Printable
extension VLRStubbedRequest: Printable {
  public var description: String {
    var text = "HTTP method: \(HTTPMethod)\n" +
        "URL: \(URL)\n" +
        "HTTP header fields: \(HTTPHeaderFields)\n"
    
    if let HTTPBody = HTTPBody {
      text += "Size of request data: \(HTTPBody.length)\n"
    }
    
    return text
  }
}

// MARK: - DebugPrintable
extension VLRStubbedRequest: DebugPrintable {
  public var debugDescription: String {
    return description
  }
}