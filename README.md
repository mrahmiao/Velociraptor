[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# Velociraptor

Velociraptor is a network stubbing framework written in pure Swift for iOS and OS X.

## Requirements

- iOS 8.1+ / Mac OS X 10.10+
- Xcode 6.3

## Communication

* If you **found a bug**, open an issue.
* If you **have a feature request**, open an issue.
* If you **want to contribute**, feel free to submit a pull request.

## Installation

Use **CocoaPods** or **Carthage** to integrate Velociraptor into your test target. Other approaches are not recommended.

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate Velociraptor into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
target :YourTestTarget do
  use_frameworks!
  pod 'Velociraptor'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager for Cocoa application. You can use [Homebrew](http://brew.sh) to install Carthage.

```bash
$ brew update
$ brew install carthage
```

To integrate Velociraptor into your Xcode project using Carthage, please follow the instructions:

1. Add Velociraptor to your `Cartfile.private`:

```ruby
github "mrahmiao/Velociraptor"
```

2. Run `carthage update`.

3. From your `Carthage/Build/[platform]/` directory, add *Velociraptor.framework* to your test target's "Link Binary With Libraries" build phase:
    ![](http://i.imgur.com/6bv3MpG.png)

4. For your test target, create a new build phase of type "Copy Files":
    ![](http://i.imgur.com/pFueiGY.png)

5. Set the "Destination" to "Frameworks", then add both frameworks:
    ![](http://i.imgur.com/s2Evmb3.png)

## Usage

The following examples are described using [Quick](https://github.com/Quick/Quick).

### Activate && Deactivate Velociraptor

Since method swizzling is used in Velociraptor, you should activate and deactivate Velociraptor manually in order to avoid strange behaviors.

```swift
import Quick
import Nimble
import Velociraptor

class VelociraptorSpec: QuickSpec {
  override func spec() {
    beforeSuite {
      Velociraptor.activate()
    }

    afterSuite {
      Velociraptor.deactivate()
    }

    describe(“Stubbing requests”) {
      // …
    }
  }
}
```

If you are using XCTest, use the following code:

```swift
import Foundation
import XCTest
import Velociraptor

class VelociraptorTests: XCTestCase {
  
  override class func setUp() {
    super.setUp()
    Velociraptor.activate()
  }
  
  override class func tearDown() {
    Velociraptor.deactivate()
    super.tearDown()
  }

  func testExample() {
    // ...
  }
}
```

### Stubbing requests

#### Stubbing a Simple GET Request

You can use `String`, `NSURL` and `NSURLRequest` directly to stub simple GET requests. And if you do not
specify any response you want to retrieve, you will receive a default response which has a status code of 
200 and empty body data.

```swift
let URLString = "https://github.com/mrahmiao/velociraptor"
let URL = NSURL(string: URLString)!
let request = NSURLRequest(URL: URL)

// String
Velociraptor.request(URLString)

// NSURL
Velociraptor.request(URL)

// NSURLRequest
Velociraptor.request(request)
```

#### Stubbing Requests with an VLRStubbedRequest Object

With `VLRStubbedRequest` object, you can set the full condition of requests you want to stub. And requests
with those information you set would be stubbed.

```swift
let stubbedRequest = VLRStubbedRequest(URL: URL)
stubbedRequest.HTTPMethod = .GET
stubbedRequest.HTTPBody = "Hello World".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
stubbedRequest.HTTPHeaderFields = ["Auth": "jk1234"]

Velociraptor.request(stubbedRequest)
```

#### Stubbing Requests with Different HTTP Methods

Besides *GET* requests, you can stub requests with any other HTTP methods that defined in [RFC-7231](http://tools.ietf.org/html/rfc7231#section-4.3).

```swift
Velociraptor.request(URL).requestHTTPMethod(.POST)
```

And there are 5 convenience methods for you to stub the most commonly used HTTP methods:

```swift
Velociraptor.GET(URL)
Velociraptor.POST(URL)
Velociraptor.PUT(URL)
Velociraptor.DELETE(URL)
Velociraptor.PATCH(URL)
```

#### Stubbing Requests With Specified Header Fields

You can stub either one particular header field or multiple header fields simultaneously.


```swift
// Stubs one particuluar header field
Velociraptor.GET(URL)?.requestHeaderValue("*", forHTTPHeaderField: "Accept")

// Stubs multiple header fields
let headerFields = [
  "Accept": "*",
  "Other": "HeaderFields"
]
Velociraptor.GET(URL)?.requestHTTPHeaderFields(headerFields)
```

#### Header Field Matching Options

Velociraptor.VLRHeaderFieldMatchingOptions lists the option you will use when matching header fields.

```swift
public enum VLRHeaderFieldMatchingOptions {
  case .Exactly
  case .Partially(UInt)
  case .StrictSubset
  case .Arbitrarily
}
```

The default header field matching option is `.Exactly`, which indicates that only when two header fields (both incoming request and stubbed request) are identicial, the request would be matched.

Or you can set the option to the other options.

```swift
Velociraptor.headerFieldMatchingOption = .Partially(3)
```

* `Exactly`: indicates that the header fields of incoming request and the header fields of stubbed request must be exactly the same.
* `Partially(UInt)`: Uses the associated `UInt` value to specify the minimum number of common header fields of both incoming request and stubbed request. When the number of common header fields greater or equal than the specified minimum number, the incoming request will be matched. Note that if the number is set to `0`, and this option is identical to `.Arbitrarily`. And the maximum of it is the number of the stubbed header fields.
* `StrictSubset`: Only when the header fields of incoming request are a strict subset of the header fields of stubbed request, the match will succeed.
* `Arbitrarily`: Match requests with arbitray header fields.

### Stubbing HTTP Body Data

When setting the http body, the *Content-Length* header field will be added to the header fields of stubbed request.

```swift
let data = "Hello World".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
Velociraptor.request(URL)?.requestBodyData(data)
```

### Stubbing HTTP Responses

#### Stubbing Single Header Fields of Responses

You can stub either a single header value or multiple header fields

```swift
// Single Header Field
Velociraptor.GET(URL)?.responseHeaderValue("application/json", forHTTPHeaderField: "Content-Type")

// Multiple Header Fields
let headerFields = [
  "Content-Type": "application/json",
  "ReceivedRes": "Response"
]
Velociraptor.GET(URL)?.responseHTTPHeaderFields(headerFields)
```

#### Stubbing Status Code

Use this method to specify the status code you want to receive in completion handlers:

```swift
Velociraptor.GET(URL)?.responseStatusCode(404)
```

#### Stubbing Error Response

If you want to stub an error response, use the method below:

```swift
let errorCode = 1234
let userInfo = ["Error": "StubbedError"]
let domain = "com.code4blues.mrahmiao.velociraptor"
let stubbedError = NSError(domain: domain, code: errorCode, userInfo: userInfo)
          
Velociraptor.request(URL)?.failWithError(stubbedError)
```

#### Stubbing Body Data

You can stub `NSData` as the body data:

```swift
let data = "Hello World".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
Velociraptor.request(URL)?.responseBodyData(data)
```

Or use JSON object:

```swift
let JSONObject: AnyObject = [
  "Number": 5,
  "Bool": false,
  "Array": [5, 4, 3]
]

Velociraptor.request(URL)?.responseBodyData(JSONObject)
```

When stubbing JSON data, *Content-Type* will be set to *application/json; charset=utf-8*

#### Put Them Together

Supposed that I want to stub a POST request:

```swift
let URL = "http://httpbin.org/post"
let requestHeader = [
  "Authorization": "3721"
]
let requestData = "Hello World".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)

let responseHeaders = [
  "Status": "Success"
  "uID": "3214"
]

Velociraptor.POST(URL)?
    .requestHeaderFields(requestHeader)
    .requestBodyData(requestData)
    .responseStatusCode(200)
    .responseHTTPHeaderFields(responseHeaders)

```

#### Stubbing Response Using VLRStubbedResponse Object

Instead of using a series of methods, you can use a single VLRStubbedResponse object to stub resopnse:

```swift
let statusCode = 201
let bodyData = "Hello World".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
let expectedResponse = VLRStubbedResponse(URL: URL, statusCode: statusCode)
expectedResponse.HTTPHeaderFields = [
  "Content-Type": "text/plain",
  "Content-Length": String(bodyData.length)
]
expectedResponse.HTTPBody = bodyData
          
Velociraptor.request(URL)?.response(expectedResponse)
```

### Notice
Any requests that not stubbed will result in a fatal error.

## License

Velociraptor is released under the MIT license. See the `LICENSE` file for details.
