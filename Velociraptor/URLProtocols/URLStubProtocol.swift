//
//  URLSessionProtocol.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/21/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

public class URLStubProtocol: NSURLProtocol {
  public override class func canInitWithRequest(request: NSURLRequest) -> Bool {
    
    // Stubs http and https requests
    if let scheme = request.URL!.scheme {
      if !contains(["http", "https"], scheme.lowercaseString) {
        return false
      }
    } else {
      return false
    }
    
    return true
  }
  
  public override class func canonicalRequestForRequest(request: NSURLRequest) -> NSURLRequest {
    return request
  }
  
  public override class func requestIsCacheEquivalent(aRequest: NSURLRequest, toRequest bRequest: NSURLRequest) -> Bool {
    return false
  }

  public override func startLoading() {
    if let stubbedResponse = VelociraptorManager.sharedManager.stubbedResponseWithURLRequest(request) {
      client!.URLProtocol(self, didReceiveResponse: stubbedResponse, cacheStoragePolicy: .NotAllowed)
      client!.URLProtocolDidFinishLoading(self)
    } else {
      fatalError("Request not stubbed with URL: \(request.URL!)")
    }
  }
  
  public override func stopLoading() {
    
  }
  
}
