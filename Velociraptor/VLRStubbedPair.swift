//
//  VLRStubbedPair.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/21/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

/**
  An object contains both stubbed request and response. You can use methods
  on the object to modify stub configurations.
*/
public class VLRStubbedPair {
  
  /// Stubbed request information
  var request: VLRStubbedRequest
  
  /// Stubbed resposne information
  var response: VLRStubbedResponse?
  
  init(request: VLRStubbedRequest, response: VLRStubbedResponse? = nil) {
    self.request = request
    self.response = response
  }
}

// MARK: - Printable
extension VLRStubbedPair: Printable {
  public var description: String {
    var text = "Request: \(request)\n"
    
    if let response = response {
      text += "Response: \(response)\n"
    }
    
    return text
  }
}

// MARK: - DebugPrintable
extension VLRStubbedPair: DebugPrintable {
  public var debugDescription: String {
    return description
  }
}

// MARK: - Request DSL
extension VLRStubbedPair {
  /**
    Specify the HTTP method of the request you want to stub.
  
    :param: method HTTP method, see http://tools.ietf.org/html/rfc7231#section-4.3
  
    :returns: An object you used to specify more stubbed information.
  */
  public func requestHTTPMethod(method: VLRHTTPMethod) -> Self {
    request.HTTPMethod = method
    return self
  }
  
  /**
    Adds an HTTP header to the stubbed request's HTTP header dictionary.
  
    :param: value The value of the header field.
    :param: field The name of the header field. In keeping with the HTTP RFC, HTTP header field names are case-insensitive. The value of the same header field will be replaced while the name of the header field will be remained (ignoring the new name of the header field).
  
    :returns: An object you used to specify more stubbed information.
  */
  public func requestHeaderValue(value: String, forHTTPHeaderField field: String) -> Self {
    
    setValue(value, forHTTPHeaderField: field, inHTTPHeaderFields: &request.HTTPHeaderFields)
    return self
  }
  
  /**
    Replace all the header fileds of the stubbed request's HTTP header fields.
  
    :param: headers The HTTP header fields.
  
    :returns: An object you used to specify more stubbed information.
  */
  public func requestHTTPHeaderFields(headers: [String: String]) -> Self {
    request.HTTPHeaderFields = headers
    return self
  }
  
  /**
    Stub the HTTP body data of the request.
  
    :param: data The stubbed HTTP body data.
  
    :returns: An object you used to specify more stubbed information.
  */
  public func requestBodyData(data: NSData) -> Self {
    request.HTTPBody = data
    request.HTTPHeaderFields["Content-Length"] = String(data.length)
    return self
  }
  
  /**
    TODO: requestParameters
  
    Stub the request data. If the method of stubbed request is `GET`, `HEAD`
    or `DELETE`, parameters will be appended to the URL query.
  
    For other HTTP methods, parameters will be set as the body data of the 
    request, and the `Content-Type` header field will be set to 
    `application/x-www-form-urlencoded`.
  
    :param: parameters The parameters attched to the stubbed request.
  
    :returns: An object you used to specify more stubbed information.
  */
  private func requestParameters(parameters: [String: AnyObject]) -> Self {
    switch request.HTTPMethod {
    case .GET, .HEAD, .DELETE:
      println("TODO: encoded the parameters as a query string")
    default:
      request.HTTPHeaderFields["Content-Type"] = "x-www-form-urlencoded"
    }
    return self
  }
}

// MARK: - Response DSL
extension VLRStubbedPair {
  
  /**
    Set the stubbed response.
  
    :param: response An object contains all the stubbed response information.
  
    :returns: An object you used to specify more stubbed information.
  */
  public func response(response: VLRStubbedResponse) -> Self {
    self.response = response
    return self
  }
  
  /**
    Adds an HTTP header to the stubbed response's HTTP header dictionary.
  
    :param: value The value of the header field.
    :param: field The name of the header field. In keeping with the HTTP RFC, HTTP header field names are case-insensitive. The value of the same header field will be replaced while the name of the header field will be remained (ignoring the new name of the header field).
  
    :returns: An object you used to specify more stubbed information.
  */
  public func responseHeaderValue(value: String, forHTTPHeaderField field: String) -> Self {
    
    response = response ?? defaultResponseWithURL(request.URL)
    
    setValue(value, forHTTPHeaderField: field, inHTTPHeaderFields: &response!.HTTPHeaderFields)
    
    return self
  }
  
  /**
    Replace all the header fileds of the stubbed response's HTTP header fields.
  
    :param: headers The HTTP header fields.
  
    :returns: An object you used to specify more stubbed information.
  */
  public func responseHTTPHeaderFields(headers: [String: String]) -> Self {
    response = response ?? defaultResponseWithURL(request.URL)
    
    response?.HTTPHeaderFields = headers
    return self
  }
  
  /**
    Specify the status code and/or error of the stubbed response.
  
    :param: statusCode The HTTP response status code. See http://tools.ietf.org/html/rfc7231#page-47

    :returns: An object you used to specify more stubbed information.
  */
  public func responseStatusCode(statusCode: Int) -> Self {
    response = response ?? defaultResponseWithURL(request.URL)
    
    response?.statusCode = statusCode
    return self
  }
  
  /**
    Specify the error that completion handler received.
  
    :param: error The error that you will received in the completion handler.
  
    :returns: An object you used to specify more stubbed information.
  
  */
  public func failWithError(error: NSError) -> Self {
    response = response ?? defaultResponseWithURL(request.URL)
    
    response?.responseError = error
    return self
  }
  
  /**
    Specify the stubbed response data.
  
    :param: data The HTTP body data you want to stubbed.
  
    :returns: An object you used to specify more stubbed information.
  */
  public func responseBodyData(data: NSData) -> Self {
    response = response ?? defaultResponseWithURL(request.URL)
    
    response?.HTTPBody = data
    return self
  }
  
  /**
    Specify the JSON data as the stubbed response data. And the
    `Content-Type` of the response header will be set to
    `application/json; charset=utf-8`.
  
    :param: data The JSON object that will be stubbed as the response data.

    :returns: An object you used to specify more stubbed information.
  */
  public func responseJSONData(data: AnyObject) -> Self {
    response = response ?? defaultResponseWithURL(request.URL)
    
    responseHeaderValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    let data = NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions.allZeros, error: nil)
    response?.HTTPBody = data
    
    return self
  }
}

// MARK: - Private helpers
extension VLRStubbedPair {
  
  /// Provide default stubbed response
  private func defaultResponseWithURL(URL: VLRURLStringConvertible) -> VLRStubbedResponse {
    return VLRStubbedResponse(URL: URL)
  }
  
  /**
    Add header field to header fields. If same header name exists, the value
    of the header will be replaced while ignoring the new header
    name (case-insensitive).
  */
  private func setValue(value: String, forHTTPHeaderField field: String, inout inHTTPHeaderFields fields: [String: String]) {
    
    // Check whehter same header field exists
    for (headerKey, headerValue) in fields {
      
      // Same header field exists
      if headerKey.lowercaseString == field.lowercaseString {
        fields[headerKey] = value
        return
      }
    }
    
    // Insert new header field
    fields[field] = value
  }
}