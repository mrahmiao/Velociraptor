//
//  VelociraptorManager.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/21/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

public class VelociraptorManager {
  private var pairs: [VLRStubbedPair] = []
  
  public static let sharedManager = VelociraptorManager()
  
  public var enableDefaultResponse = true
  
}

// MARK: - Public APIs
extension VelociraptorManager {
  public func request(URLRequest: VLRURLRequestConvertible) -> VLRStubbedPair? {
    if let request = URLRequest.URLRequest {
      
      let stubbedRequest = request.mutableCopy() as! NSMutableURLRequest
      stubbedRequest.allHTTPHeaderFields = [:]

      var stubbedResponse: NSHTTPURLResponse? = nil

      if enableDefaultResponse {
        stubbedResponse = NSHTTPURLResponse(URL: request.URL!,
            statusCode: 200,
            HTTPVersion: "HTTP/1.1",
            headerFields: [:])!
      }

      let pair = VLRStubbedPair(request: stubbedRequest, response: stubbedResponse)
      pairs.append(pair)
      return pair
    }
    
    return nil
  }
  
  public func clearStubs() {
    pairs.removeAll(keepCapacity: false)
    NSLog("Stubs cleared")
  }
  
  func stubbedResponseWithURLRequest(URLRequest: VLRURLRequestConvertible) -> NSHTTPURLResponse? {
    if let request = URLRequest.URLRequest {
      for pair in pairs {
        if pair.matchesRequest(request) {
          return pair.response
        }
      }
    }

    return nil
  }
}


// MARK: - Framework APIs
public func request(URL: VLRURLRequestConvertible) -> VLRStubbedPair? {
  return VelociraptorManager.sharedManager.request(URL)
}

public func clearStubs() {
  VelociraptorManager.sharedManager.clearStubs()
}

public func activate() {
  if !started {
    activateHTTPStubs()
    started = !started
  }
}

public func deactivate() {
  if started {
    deactivateHTTPStubs()
    started = !started
  }
}

private var started = false

private func activateHTTPStubs() {
  NSURLSessionConfiguration.vlr_swizzleConfigurationMethods()
  NSURLProtocol.registerClass(URLStubProtocol)
}

private func deactivateHTTPStubs() {
  NSURLSessionConfiguration.vlr_swizzleConfigurationMethods()
  NSURLProtocol.unregisterClass(URLStubProtocol.self)
}