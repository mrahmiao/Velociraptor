//
//  VelociraptorManager.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/21/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

/**
  Responsible for creating stubbing objects. Creating your own manager is
  not recommended. Simply using `VelociraptorManager.sharedManager` or the
  global functions to stub requests.
*/
public class VelociraptorManager {
  private var pairs: [VLRStubbedPair] = []
  
  /// Whether to provied default stubbed response. `true` by default.
  public var enableDefaultResponse = true
  
  /**
    Use the option to control the behavior when matching HTTP header fields.
    Default to `.Exactly`.
  */
  public var headerFieldMatchingOption: VLRHeaderFieldMatchingOptions = .Exactly
  
  /**
    A shared instance of `VelociraptorManager`, used by top-level
    Velociraptor stubbing functions. You can use it directly to stub requests.
  */
  public static let sharedManager = VelociraptorManager()
}

// MARK: - Public APIs
extension VelociraptorManager {
  /**
    Stub a request using system provided network-related classes, such as 
    String, NSURL and NSURLRequest.
  
    :param: URLRequest The request you want to stub
  
    :returns: A stub object for you to add more detailed information.
  */
  public func request(URLRequest: VLRURLRequestConvertible) -> VLRStubbedPair? {
    if let request = URLRequest.URLRequest {
      let stubbedRequest = VLRStubbedRequest(rawRequest: request)
      return self.request(stubbedRequest)
    }
    
    return nil
  }
  
  /**
    Stub a request using a fully-fledged stubbed request object.
  
    :param: stubbedRequest The stubbed request you want to stub
  
    :returns: A stub object for you to add more detailed information.
  */
  public func request(stubbedRequest: VLRStubbedRequest) -> VLRStubbedPair? {
    var stubbedResponse: VLRStubbedResponse? = nil
    
    if enableDefaultResponse {
      stubbedResponse = VLRStubbedResponse(URL: stubbedRequest.URL)
    }
    
    let pair = VLRStubbedPair(request: stubbedRequest, response: stubbedResponse, matchingOption: headerFieldMatchingOption)
    pairs.append(pair)
    return pair
  }
  
  /**
    Clear stubbed requests. The method should be invoked after each
    test case.
  */
  public func clearStubs() {
    pairs.removeAll(keepCapacity: false)
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

/**
  Top-level function to stub a request using system provided network-related
  classes, such as String, NSURL and NSURLRequest.

  :param: URLRequest The request you want to stub

  :returns: A stub object for you to add more detailed information.
*/
public func request(URL: VLRURLRequestConvertible) -> VLRStubbedPair? {
  return VelociraptorManager.sharedManager.request(URL)
}

/**
  Top-level function to stub a request using a fully-fledged stubbed
  request object.

  :param: stubbedRequest The stubbed request you want to stub

  :returns: A stub object for you to add more detailed information.
*/
public func request(stubbedRequest: VLRStubbedRequest) -> VLRStubbedPair? {
  return VelociraptorManager.sharedManager.request(stubbedRequest)
}

/**
  Clear stubbed requests. The method should be invoked after each
  test case.
*/
public func clearStubs() {
  VelociraptorManager.sharedManager.clearStubs()
}


/// Activate Velociraptor to stub requests.
public func activate() {
  if !started {
    activateHTTPStubs()
    started = !started
  }
}


/// Deactivate Velociraptor.
public func deactivate() {
  if started {
    deactivateHTTPStubs()
    started = !started
  }
}

/** 
  Set the behavior when matching HTTP header fields.

  Default to `.Exactly`.
*/
public var headerFieldMatchingOption: VLRHeaderFieldMatchingOptions {
  set {
    VelociraptorManager.sharedManager.headerFieldMatchingOption = newValue
  }
  get {
    return VelociraptorManager.sharedManager.headerFieldMatchingOption
  }
}

private var started = false

private func activateHTTPStubs() {
  NSURLSessionConfiguration.vlr_swizzleConfigurationMethods()
  NSMutableURLRequest.vlr_swizzleSetHTTPBody()
  NSURLProtocol.registerClass(URLStubProtocol.self)
}

private func deactivateHTTPStubs() {
  NSURLSessionConfiguration.vlr_swizzleConfigurationMethods()
  NSMutableURLRequest.vlr_swizzleSetHTTPBody()
  NSURLProtocol.unregisterClass(URLStubProtocol.self)
}