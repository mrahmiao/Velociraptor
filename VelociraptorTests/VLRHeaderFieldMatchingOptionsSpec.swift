//
//  VLRHeaderFieldMatchingOptionsSpec.swift
//  Velociraptor
//
//  Created by mrahmiao on 4/28/15.
//  Copyright (c) 2015 Code4Blues. All rights reserved.
//

import Quick
import Nimble

class VLRHeaderFieldMatchingOptionsSpec: QuickSpec {
  
  typealias Matcher = [NSObject: AnyObject] -> Bool
  
  func matchingOption(option: VLRHeaderFieldMatchingOptions, withStubbedHeaderFields stubbedFields: [String: String]) -> Matcher {
    return { (fields) -> Bool in
      return option.incomingHeaderFields(fields, matchesStubbedHeaderFields: stubbedFields)
    }
  }
  
  override func spec() {
    
    let minimumNumberOfMatchedHeaders = 3
    
    let stubbedHeaders = [
      "Authroization": "13145253",
      "Accept": "text/plain",
      "Cookie": "hello=world",
      "Custom": "customHeader"
    ]
    
    let sameHeaders = [
      "Authroization": "13145253",
      "Accept": "text/plain",
      "Cookie": "hello=world",
      "Custom": "customHeader"
    ]
    
    let lowercaseSameHeaders = [
      "Authroization": "13145253",
      "accept": "text/plain",
      "cookie": "hello=world",
      "Custom": "customHeader"
    ]
    
    let sameNameDifferentValueHeaders = [
      "Authroization": "DifferentHeader",
      "Accept": "text/plain",
      "Cookie": "hello=world",
      "Custom": "customHeader"
    ]
    
    let supersetHeaders = [
      "Authroization": "13145253",
      "accept": "text/plain",
      "cookie": "hello=world",
      "Custom": "customHeader",
      "Super": "Man",
      "Icon": "Man"
    ]
    
    let subsetHeaders = [
      "Authroization": "13145253",
      "Accept": "text/plain"
    ]
    
    let lowercaseSubsetHeaders = [
      "Authroization": "13145253",
      "accept": "text/plain"
    ]
    
    let differentSubsetHeaders = [
      "Authroization": "13145253",
      "accept": "application/json"
    ]
    
    let emptySetHeaders = [String: String]()
    
    let matchedIntersectHeaders = [
      "Authroization": "13145253",
      "Accept": "text/plain",
      "Cookie": "hello=world",
      "Different": "DifferentHeaderField"
    ]
    
    let lowercaseMatchedIntersectHeaders = [
      "Authroization": "13145253",
      "accept": "text/plain",
      "cookie": "hello=world",
      "Different": "DifferentHeaderField"
    ]
    
    /// With 2 common header fields, which is less than the minimum: 3.
    let dismatchedIntersectHeaders = [
      "Authroization": "13145253",
      "Accept": "text/plain",
      "Different": "DifferentHeaderField"
    ]
    
    let disjointHeaders = [
      "Totally": "Different",
      "Completely": "Also Different",
      "Disjoint": "With out any identical"
    ]
    
    let anotherDisjointHeaders = [
      "Totally": "Different",
      "Completely": "Also Different",
      "Disjoint": "With out any identical",
      "Different": "Different"
    ]
    
    var matchingResult: Bool!
    var matches: Matcher!
    
    afterEach {
      matchingResult = nil
      matches = nil
    }
    
    describe("When matching requests with exactly the same header fields") {
      beforeEach {
        matches = self.matchingOption(.Exactly, withStubbedHeaderFields: stubbedHeaders)
      }
      
      it("matches when the both header fields are exactly the same") {
        matchingResult = matches(sameHeaders)
        expect(matchingResult).to(beTrue())
      }
      
      it("matches when incoming requests have lowecase haeder field names but with same values") {
        matchingResult = matches(lowercaseSameHeaders)
        expect(matchingResult).to(beTrue())
      }
      
      it("does not any other header fields") {
        let dismatchedHeaders = [
          sameNameDifferentValueHeaders, supersetHeaders, subsetHeaders,
          lowercaseSubsetHeaders, differentSubsetHeaders,
          matchedIntersectHeaders, lowercaseMatchedIntersectHeaders,
          dismatchedIntersectHeaders, emptySetHeaders,
          disjointHeaders, anotherDisjointHeaders
        ]
        
        for dismathed in dismatchedHeaders {
          matchingResult = matches(dismathed)
          expect(matchingResult).to(beFalse())
        }
      }
    }
    
    describe("When matching requests with partially common header fields") {
      context("With minimum number set to 3") {
        beforeEach {
          matches = self.matchingOption(.Partially(3), withStubbedHeaderFields: stubbedHeaders)
        }
        
        it("matches the identical header fields") {
          matchingResult = matches(sameHeaders)
          expect(matchingResult).to(beTrue())
        }
        
        it("matches the identical header fields with lowercase names") {
          matchingResult = matches(lowercaseSameHeaders)
          expect(matchingResult).to(beTrue())
        }
        
        it("matches the super set header fields") {
          matchingResult = matches(supersetHeaders)
          expect(matchingResult).to(beTrue())
        }
        
        it("matches the header fields with satisfied number of common elements") {
          matchingResult = matches(matchedIntersectHeaders)
          expect(matchingResult).to(beTrue())
          
          matchingResult = nil
          matchingResult = matches(sameNameDifferentValueHeaders)
          expect(matchingResult).to(beTrue())
        }
        
        it("matches the header fields with satisfied number of common elements and lowercase names") {
          matchingResult = matches(lowercaseMatchedIntersectHeaders)
          expect(matchingResult).to(beTrue())
        }

        it("does not match any other header fields") {
          let headers = [
            subsetHeaders, lowercaseSubsetHeaders, differentSubsetHeaders,
            dismatchedIntersectHeaders, emptySetHeaders, disjointHeaders, anotherDisjointHeaders
          ]
          
          for header in headers {
            matchingResult = matches(header)
            expect(matchingResult).to(beFalse())
          }
        }
      }
      
      context("With minimum number set to 10") {
        beforeEach {
          matches = self.matchingOption(.Partially(10), withStubbedHeaderFields: stubbedHeaders)
        }
        
        it("mathes the identical header fields") {
          matchingResult = matches(sameHeaders)
          expect(matchingResult).to(beTrue())
        }
        
        it("mathes the identical header fields with lowercase names") {
          matchingResult = matches(lowercaseSameHeaders)
          expect(matchingResult).to(beTrue())
        }
        
        it("matches the super set header fields") {
          matchingResult = matches(supersetHeaders)
          expect(matchingResult).to(beTrue())
        }
        
        it("does not match any other header fields") {
          let headers = [
            sameNameDifferentValueHeaders, subsetHeaders,
            lowercaseSubsetHeaders, differentSubsetHeaders,
            matchedIntersectHeaders, lowercaseMatchedIntersectHeaders,
            dismatchedIntersectHeaders, emptySetHeaders, disjointHeaders,
            anotherDisjointHeaders
          ]
          
          for header in headers {
            matchingResult = matches(header)
            expect(matchingResult).to(beFalse())
          }
        }
      }
      
      context("With minimum number set to 0") {
        it("matches arbitrary header fields") {
          matches = self.matchingOption(.Partially(0), withStubbedHeaderFields: stubbedHeaders)
          let headers = [
            sameHeaders, lowercaseSameHeaders, sameNameDifferentValueHeaders,
            supersetHeaders, subsetHeaders, lowercaseSubsetHeaders, differentSubsetHeaders,
            matchedIntersectHeaders, lowercaseMatchedIntersectHeaders,
            dismatchedIntersectHeaders, emptySetHeaders, disjointHeaders,
            anotherDisjointHeaders
          ]
          
          for header in headers {
            matchingResult = matches(header)
            expect(matchingResult).to(beTrue())
          }
        }
      }
    }
    
    describe("When matching requests with strict subset header fields") {
      beforeEach {
        matches = self.matchingOption(.StrictSubset, withStubbedHeaderFields: stubbedHeaders)
      }
      
      it("matches subset of stubbed header fields") {
        matchingResult = matches(subsetHeaders)
        expect(matchingResult).to(beTrue())
      }
      
      it("matches subset of stubbed header fields with lowercase names") {
        matchingResult = matches(lowercaseSubsetHeaders)
        expect(matchingResult).to(beTrue())
      }
      
      it("matches empty header fields") {
        matchingResult = matches(emptySetHeaders)
        expect(matchingResult).to(beTrue())
      }
      
      it("does not match any other header fields") {
        let headers = [
          sameHeaders, lowercaseSameHeaders, sameNameDifferentValueHeaders,
          supersetHeaders, differentSubsetHeaders,
          matchedIntersectHeaders, lowercaseMatchedIntersectHeaders,
          dismatchedIntersectHeaders, disjointHeaders, anotherDisjointHeaders
        ]
        
        for header in headers {
          matchingResult = matches(header)
          expect(matchingResult).to(beFalse())
        }
      }
    }
    
    describe("When matching request with arbitrary header fields") {
      beforeEach {
        matches = self.matchingOption(.Arbitrarily, withStubbedHeaderFields: stubbedHeaders)
      }
      
      it("matches arbitrary header fields") {
        let headers = [
          sameHeaders, lowercaseSameHeaders, sameNameDifferentValueHeaders,
          supersetHeaders, subsetHeaders, lowercaseSubsetHeaders, differentSubsetHeaders,
          matchedIntersectHeaders, lowercaseMatchedIntersectHeaders,
          dismatchedIntersectHeaders, emptySetHeaders, disjointHeaders, anotherDisjointHeaders
        ]
        
        for header in headers {
          matchingResult = matches(header)
          expect(matchingResult).to(beTrue())
        }
      }
    }
  }
}