import XCTest
@testable import When

final class WhenTests: XCTestCase {
  func testWhen_ReturnsTwo_WhenValueEqualsTwo() {
    let value = 2
    let result = when(value) {
      equals(1) => "One"
      equals(2) => "Two"
      equals(3) => "Three"
      fallback => "Who knows"
    }
    
    XCTAssertEqual(result, "Two")
  }
  
  func testWhen_ReturnsFallbackValue_WhenValueIsNotPresent() {
    let value = 5
    let result = when(value) {
      equals(1) => "One"
      equals(2) => "Two"
      equals(3) => "Three"
      fallback => "Who knows"
    }
    
    XCTAssertEqual(result, "Who knows")
  }
  
  func testWhen_ReturnsValue_WhenOrPatternMatches() {
    let value = 2
    let result = when(value) {
      equals(1) || equals(2) => "OneOrTwo"
      equals(3) => "Three"
      fallback => "Who Knows?!"
    }
    
    XCTAssertEqual(result, "OneOrTwo")
  }
  
  func testWhen_ReturnsValue_WhenValueIsInSequence() {
    let value = 5
    let result = when(value) {
      containedIn(1...10) => "Between One and Ten"
      containedIn(11...20) => "Between Eleven and Twenty"
      containedIn(21...30) => "Between Twenty-One and Thirty"
      fallback => "Who knows"
    }
    
    XCTAssertEqual(result, "Between One and Ten")
  }


  static var allTests = [
    ("testWhen_ReturnsTwo_WhenValueEqualsTwo", testWhen_ReturnsTwo_WhenValueEqualsTwo),
    ("testWhen_ReturnsFallbackValue_WhenValueIsNotPresent", testWhen_ReturnsFallbackValue_WhenValueIsNotPresent),
    ("testWhen_ReturnsValue_WhenValueIsInSequence", testWhen_ReturnsValue_WhenValueIsInSequence),
    ("testWhen_ReturnsValue_WhenValueIsInSequence", testWhen_ReturnsValue_WhenValueIsInSequence),
  ]
}
