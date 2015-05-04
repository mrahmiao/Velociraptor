//
//  VLRURLStringConvertible.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/23/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

public protocol VLRURLStringConvertible {
  var URLString: String { get }
}

extension String: VLRURLStringConvertible {
  public var URLString: String {
    return self
  }
}

extension NSURL: VLRURLStringConvertible {
  public var URLString: String {
    return absoluteString!
  }
}

extension NSURLRequest: VLRURLStringConvertible {
  public var URLString: String {
    return URL!.absoluteString!
  }
}