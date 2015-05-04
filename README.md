# Velociraptor

Velociraptor is a network stubbing framework written in pure Swift for iOS and OS X.

## Requirements

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

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager for Cocoa application. You can use [Homebrew](http://brew.sh) to install Carthage.

```bash
$ brew update
$ brew install carthage
```

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

### Stubbing a simple GET request

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

### Stubbing requests with VLRStubbedRequest object

With `VLRStubbedRequest` object, you can set the full condition of the requests you want to stub. And requests
with those information you set would be stubbed.

```swift
let stubbedRequest = VLRStubbedRequest(URL: URL)
stubbedRequest.HTTPMethod = .GET
stubbedRequest.HTTPBody = "Hello World".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
stubbedRequest.HTTPHeaderFields = ["Auth": "jk1234"]

Velociraptor.request(stubbedRequest)
```

### Stubbing requests with different HTTP methods

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

### Notice
Any requests that not stubbed will result in a fatal error.

## License

Velociraptor is released under the MIT license. See the `LICENSE` file for details.
