//
//  VelociraptorManager.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/21/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

public class VelociraptorManager {
  private var pairs: [NSURLRequest: VLRStubbedPair] = [:]
  
  public static let sharedManager = VelociraptorManager()
  
}

// MARK: - Public APIs
extension VelociraptorManager {
  public func request(URLRequest: VLRURLRequestConvertible) -> VLRStubbedPair? {
    if let request = URLRequest.URLRequest {
      
      let stubbedRequest = request.mutableCopy() as! NSMutableURLRequest
      let stubbedResponse = NSHTTPURLResponse(URL: request.URL!,
        statusCode: 200,
        HTTPVersion: "HTTP/1.1",
        headerFields: nil)!
      let pair = VLRStubbedPair(request: stubbedRequest,
        response: stubbedResponse)
      pairs[request] = pair
      return pair
    }
    
    return nil
  }
  
  public func clearStubs() {
    pairs.removeAll(keepCapacity: false)
  }
  
  public func stubbedPairWithURLRequest(URLRequest: VLRURLRequestConvertible) -> VLRStubbedPair? {
    if let request = URLRequest.URLRequest {
      return pairs[request]
    } else {
      return nil
    }
  }
}