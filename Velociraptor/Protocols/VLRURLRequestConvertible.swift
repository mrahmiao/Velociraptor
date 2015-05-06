//
//  VLRURLRequestConvertible.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/21/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

public protocol VLRURLRequestConvertible {
  var URLRequest: NSURLRequest? { get }
}

extension String: VLRURLRequestConvertible {
  public var URLRequest: NSURLRequest? {
    if let URL = NSURL(string: self) {
      if URL.scheme == nil {
        return nil
      }
      
      return NSURLRequest(URL: URL)
    }
    
    return nil
  }
}

extension NSURL: VLRURLRequestConvertible {
  public var URLRequest: NSURLRequest? {
    
    if self.scheme == nil {
      return nil
    }
    
    return NSURLRequest(URL: self)
  }
}

extension NSURLRequest: VLRURLRequestConvertible {
  public var URLRequest: NSURLRequest? {
    if let URL = self.URL {
      if URL.scheme == nil {
        return nil
      } else {
        return self
      }
    } else {
      return nil
    }
  }
}