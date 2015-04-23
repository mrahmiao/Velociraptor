//
//  VLRHTTPMethod.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/23/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

public enum VLRHTTPMethod: String {
  case GET = "GET"
  case POST = "POST"
  case PUT = "PUT"
  case DELETE = "DELETE"
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