//
//  VLRStubbedResponse.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/23/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

/**
A class contains all the stubbed response information.
*/
public class VLRStubbedResponse {
  public var URL: String
  public var statusCode: Int
  public var HTTPHeaderFields = [String: String]()
  public var HTTPBody: NSData?
  public var responseError: NSError?
  
  private var HTTPVersion = "HTTP/1.1"
  
  public init(URL: VLRURLStringConvertible, statusCode: Int = 200) {
    self.URL = URL.URLString
    self.statusCode = statusCode
  }
  
  public convenience init(rawResponse: NSHTTPURLResponse) {
    let URL = rawResponse.URL!.URLString
    self.init(URL: URL, statusCode: rawResponse.statusCode)
    
    if let HTTPHeaderFields = rawResponse.allHeaderFields as? [String: String] {
      self.HTTPHeaderFields = HTTPHeaderFields
    }
  }
}

// MARK: - Printable
extension VLRStubbedResponse: Printable {
  public var description: String {
    var text = "URL: \(URL)\n" +
        "Status code: \(statusCode)\n" +
        "HTTP header fields: \(HTTPHeaderFields)\n" +
        "HTTP version: \(HTTPVersion)\n"
    
    if let HTTPBody = HTTPBody {
      text += "Size of response data: \(HTTPBody.length)\n"
    }
    
    if let responseError = responseError {
      text += "Response error: \(responseError)\n"
    }
    
    return text
  }
}

// MARK: - DebugPrintable
extension VLRStubbedResponse: DebugPrintable {
  public var debugDescription: String {
    return description
  }
}

extension NSHTTPURLResponse {
  convenience init?(stubbedResponse: VLRStubbedResponse) {
    let URL = NSURL(string: stubbedResponse.URL)!
    let statusCode = stubbedResponse.statusCode
    let HTTPVersion = "HTTP/1.1"
    let headerFields = stubbedResponse.HTTPHeaderFields
    self.init(URL: URL, statusCode: statusCode, HTTPVersion: HTTPVersion, headerFields: headerFields)
  }
}