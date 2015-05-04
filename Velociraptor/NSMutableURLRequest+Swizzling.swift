//
//  NSMutableURLRequest+Swizzling.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/30/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

let HTTPBodyDataKey = "vlr_HTTPBodyData"

extension NSMutableURLRequest {
  class func vlr_swizzleSetHTTPBody() {
    let clazz = NSMutableURLRequest.self
    let originalMethod = class_getInstanceMethod(clazz, "setHTTPBody:")
    let swizzledMethod = class_getInstanceMethod(clazz, "vlr_swizzledSetHTTPBody:")
    method_exchangeImplementations(originalMethod, swizzledMethod)
    
  }
  
  private dynamic func vlr_swizzledSetHTTPBody(data: NSData?) {
    if let data = data {
      NSURLProtocol.setProperty(data, forKey: HTTPBodyDataKey, inRequest: self)
    }
    vlr_swizzledSetHTTPBody(data)
  }
}
