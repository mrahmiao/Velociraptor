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
      let stubbedRequest = VLRStubbedRequest(rawRequest: request)
      return self.request(stubbedRequest)
    }
    
    return nil
  }
  
  public func request(stubbedRequest: VLRStubbedRequest) -> VLRStubbedPair? {
    var stubbedResponse = VLRStubbedResponse(URL: stubbedRequest.URL)
    
    let pair = VLRStubbedPair(request: stubbedRequest, response: stubbedResponse)
    pairs.append(pair)
    return pair
  }
  
  public func clearStubs() {
    pairs.removeAll(keepCapacity: false)
    NSLog("Stubs cleared")
  }
  
  func stubbedResponseWithURLRequest(URLRequest: VLRURLRequestConvertible) -> VLRStubbedResponse? {
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

public func request(stubbedRequest: VLRStubbedRequest) -> VLRStubbedPair? {
  return VelociraptorManager.sharedManager.request(stubbedRequest)
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
  NSURLProtocol.registerClass(URLStubProtocol.self)
}

private func deactivateHTTPStubs() {
  NSURLSessionConfiguration.vlr_swizzleConfigurationMethods()
  NSURLProtocol.unregisterClass(URLStubProtocol.self)
}