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


  static var allTests = [
    ("testWhenReturnsTwo", testWhenReturnsTwo),
    ("testWhenReturnsFallbackValue", testWhenReturnsFallbackValue),
  ]
}
