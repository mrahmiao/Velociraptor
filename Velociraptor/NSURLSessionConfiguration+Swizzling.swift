//
//  NSURLSessionConfiguration+Swizzling.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/22/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

extension NSURLSessionConfiguration {

  class func vlr_swizzleConfigurationMethods() {
    func exchangeMethodImplementations(clazz: AnyClass, orignalSelector: Selector, swizzledSelector: Selector) {
      let originalMethod = class_getClassMethod(clazz, orignalSelector)
      let swizzledMethod = class_getClassMethod(clazz, swizzledSelector)
      method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    
    let clazz: AnyClass = object_getClass(NSURLSessionConfiguration)
    exchangeMethodImplementations(clazz, "defaultSessionConfiguration", "vlr_swizzledDefaultSessionConfiguration")
    exchangeMethodImplementations(clazz, "ephemeralSessionConfiguration", "vlr_swizzledEphemeralSessionConfiguration")
  }
  
  dynamic private class func vlr_swizzledDefaultSessionConfiguration() -> NSURLSessionConfiguration {
    let configuration = vlr_swizzledDefaultSessionConfiguration()
    return injectStubProtocolToConfiguration(configuration)
  }

  dynamic private class func vlr_swizzledEphemeralSessionConfiguration() -> NSURLSessionConfiguration {
    let configuration = vlr_swizzledEphemeralSessionConfiguration()
    return injectStubProtocolToConfiguration(configuration)
  }

  dynamic private class func injectStubProtocolToConfiguration(configuration: NSURLSessionConfiguration) -> NSURLSessionConfiguration {
    var protocolClasses = configuration.protocolClasses ?? [AnyObject]()
    protocolClasses.insert(URLStubProtocol.self, atIndex: 0)
    configuration.protocolClasses = protocolClasses
    return configuration
  }
}
