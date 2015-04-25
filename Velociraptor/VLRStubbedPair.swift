//
//  VLRStubbedPair.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/21/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Foundation

public class VLRStubbedPair {
  var request: VLRStubbedRequest
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

// MARK: - Request Match Methods
extension VLRStubbedPair {
  func matchesRequest(incomingRequest: NSURLRequest) -> Bool {
    let result = MatchResult<NSURLRequest>.Success(Box(value: incomingRequest))
        .check(matchesURLWithRequest)
        .check(matchesHTTPMethodWithRequest)
        .check(matchesHeaderFieldsWithRequest)
        .check(matchesHTTPBodyDataWithRequest)

    switch result {
    case .Success(_):
      return true
    case .Failure(let errorMessage):
      NSLog("\(errorMessage)")
      return false
    }
  }

  private func matchesURLWithRequest(incomingRequest: NSURLRequest) -> MatchResult<NSURLRequest> {
    if incomingRequest.URL?.absoluteString == request.URL {
        return .Success(Box(value: incomingRequest))
    }

    return .Failure("URL not match: expected \(request.URL), got \(incomingRequest.URL?.absoluteString)")
  }

  private func matchesHTTPMethodWithRequest(incomingRequest: NSURLRequest) -> MatchResult<NSURLRequest> {
    if incomingRequest.HTTPMethod == request.HTTPMethod.rawValue {
      return .Success(Box(value: incomingRequest))
    }

    return .Failure("HTTP Method not match: expected \(request.HTTPMethod.rawValue), got \(incomingRequest.HTTPMethod!)")
  }

  // TODO: case-insensitive
  private func matchesHeaderFieldsWithRequest(incomingRequest: NSURLRequest) -> MatchResult<NSURLRequest> {
    if incomingRequest.allHTTPHeaderFields == nil && request.HTTPHeaderFields.count == 0 {
      return .Success(Box(value: incomingRequest))
    }

    let errorMessage = "HTTP header fields not match"

    if let incomingHeaderFields = incomingRequest.allHTTPHeaderFields {
      if incomingHeaderFields.count != request.HTTPHeaderFields.count {
        return .Failure(errorMessage)
      }

      for (key, headerValue) in incomingHeaderFields {
        let incomingHeaderFiledValue = headerValue as? String
        let stubbedHeaderFieldValue = request.HTTPHeaderFields[key as! String]
        
        if incomingHeaderFiledValue != stubbedHeaderFieldValue {
          return .Failure(errorMessage)
        }
      }

      return .Success(Box(value: incomingRequest))
    } else {
      return .Failure(errorMessage)
    }
  }

  private func matchesHTTPBodyDataWithRequest(incomingRequest: NSURLRequest) -> MatchResult<NSURLRequest> {
    if incomingRequest.HTTPBody == request.HTTPBody {
      return .Success(Box(value: incomingRequest))
    }

    return .Failure("HTTP body data not match")
  }
}

// MARK: - Request DSL
extension VLRStubbedPair {
  
  /**
    Specify the HTTP method of the request you want to stub.
  
    :param: method HTTP method, see http://tools.ietf.org/html/rfc7231#section-4.3
  
    :returns: The same object you used to specify stub information.
  */
  public func requestHTTPMethod(method: VLRHTTPMethod) -> Self {
    request.HTTPMethod = method
    return self
  }
  
  /**
    Adds an HTTP header to the stubbed request's HTTP header dictionary.
  
    :param: value The value of the header field.
    :param: field The name of the header field. In keeping with the HTTP RFC, HTTP header field names are case-insensitive. The value of the same header field will be replaced while the name of the header field will be remained (ignoring the new name of the header field).
  
    :returns: The same object you used to specify stub information.
  */
  public func requestHeaderValue(value: String, forHTTPHeaderField field: String) -> Self {
    
    addValue(value, forHTTPHeaderField: field, inHTTPHeaderFields: &request.HTTPHeaderFields)
    return self
  }
  
  /**
    Replace all the header fileds of the stubbed request's HTTP header fields.
  
    :param: headers The HTTP header fields.
  
    :returns: The same object you used to specify stub information.
  */
  public func requestHTTPHeaderFields(headers: [String: String]) -> Self {
    request.HTTPHeaderFields = headers
    return self
  }
  
  /**
    Stub the HTTP body data of the request.
  
    :param: data The stubbed HTTP body data.
  
    :returns: The same object you used to specify stub information.
  */
  public func requestBodyData(data: NSData) -> Self {
    request.HTTPBody = data
    return self
  }
}

// MARK: - Response DSL
extension VLRStubbedPair {
  
  /**
    Adds an HTTP header to the stubbed response's HTTP header dictionary.
  
    :param: value The value of the header field.
    :param: field The name of the header field. In keeping with the HTTP RFC, HTTP header field names are case-insensitive. The value of the same header field will be replaced while the name of the header field will be remained (ignoring the new name of the header field).
  
    :returns: The same object you used to specify stub information.
  */
  public func responseHeaderValue(value: String, forHTTPHeaderField field: String) -> Self {
    
    response = response ?? defaultResponseWithURL(request.URL)
    
    addValue(value, forHTTPHeaderField: field, inHTTPHeaderFields: &response!.HTTPHeaderFields)
    
    return self
  }
  
  /**
    Replace all the header fileds of the stubbed response's HTTP header fields.
  
    :param: headers The HTTP header fields.
  
    :returns: The same object you used to specify stub information.
  */
  public func responseHTTPHeaderFields(headers: [String: String]) -> Self {
    response = response ?? defaultResponseWithURL(request.URL)
    
    response?.HTTPHeaderFields = headers
    return self
  }
  
  /**
    Specify the status code and/or error of the stubbed response.
  
    :param: statusCode The HTTP response status code. See http://tools.ietf.org/html/rfc7231#page-47
    :param: error An optional error, default to `nil`. If provided, 
            it will be sent with the response.

    :returns: The same object you used to specify stub information.
  */
  public func responseStatusCode(statusCode: Int, failedWithError error: NSError? = nil) -> Self {
    response = response ?? defaultResponseWithURL(request.URL)
    
    response?.statusCode = statusCode
    response?.responseError = error
    return self
  }
  
  /**
    Specify the stubbed response data.
  
    :param: data The HTTP body data you want to stubbed.
  
    :returns: The same object you used to specify stub information.
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

    :returns: The same object you used to specify stub information.
  */
  public func responseJSONData(data: AnyObject) -> Self {
    response = response ?? defaultResponseWithURL(request.URL)
    
    responseHeaderValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    let data = NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions.allZeros, error: nil)
    response?.HTTPBody = data
    
    return self
  }
  
  /// Provide default stubbed response
  private func defaultResponseWithURL(URL: VLRURLStringConvertible) -> VLRStubbedResponse {
    return VLRStubbedResponse(URL: URL)
  }
  
  /**
    Add header field to header fields. If same header name exists, the value
    of the header will be replaced while ignoring the new header name (case-insensitive).
  */
  private func addValue(value: String, forHTTPHeaderField field: String, inout inHTTPHeaderFields fields: [String: String]) {
    
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