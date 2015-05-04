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
  
    :param: URLRequest The convertible request object you use to stub the request.
  
    :returns: An object you used to specify more stubbed information.
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
  
    :returns: An object you used to specify more stubbed information.
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

  :param: URLRequest The convertible request object you use to stub the request.

  :returns: An object you used to specify more stubbed information.
*/
public func request(URLRequest: VLRURLRequestConvertible) -> VLRStubbedPair? {
  return VelociraptorManager.sharedManager.request(URLRequest)
}

/**
  Top-level function to stub a request using a fully-fledged stubbed
  request object.

  :param: stubbedRequest The stubbed request you want to stub

  :returns: An object you used to specify more stubbed information.
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

// MARK: - Convenience methods

/**
  Convenience method to stub `GET` requests.

  :param: URLRequest The convertible request object you use to stub the request.

  :returns: An object you used to specify more stubbed information.
*/
public func GET(URLRequest: VLRURLRequestConvertible) -> VLRStubbedPair? {
  let pair = request(URLRequest)
  pair?.request.HTTPMethod = .GET
  
  return pair
}

/**
  Convenience method to stub `POST` requests.

  :param: URLRequest The convertible request object you use to stub the request.

  :returns: An object you used to specify more stubbed information.
*/
public func POST(URLRequest: VLRURLRequestConvertible) -> VLRStubbedPair? {
  let pair = request(URLRequest)
  pair?.request.HTTPMethod = .POST
  
  return pair
}

/**
  Convenience method to stub `PUT` requests.

  :param: URLRequest The convertible request object you use to stub the request.

  :returns: An object you used to specify more stubbed information.
*/
public func PUT(URLRequest: VLRURLRequestConvertible) -> VLRStubbedPair? {
  let pair = request(URLRequest)
  pair?.request.HTTPMethod = .PUT
  
  return pair
}

/**
  Convenience method to stub `DELETE` requests.

  :param: URLRequest The convertible request object you use to stub the request.

  :returns: An object you used to specify more stubbed information.
*/
public func DELETE(URLRequest: VLRURLRequestConvertible) -> VLRStubbedPair? {
  let pair = request(URLRequest)
  pair?.request.HTTPMethod = .DELETE
  
  return pair
}

/**
  Convenience method to stub `PATCH` requests.

  :param: URLRequest The convertible request object you use to stub the request.

  :returns: An object you used to specify more stubbed information.
*/
public func PATCH(URLRequest: VLRURLRequestConvertible) -> VLRStubbedPair? {
  let pair = request(URLRequest)
  pair?.request.HTTPMethod = .PATCH
  
  return pair
}