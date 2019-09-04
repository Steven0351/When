# When

This is a light-hearted attempt at creating a DSL for when-expressions in Swift similar to those found in Kotlin.

### Examples
```swift
let value = 1

// Direct Match
let result = when(value) {
  equals(1) => "One"
  equals(2) => "Two"
  equals(3) => "Three"
  fallback => "Who Knows?!"
}
print(result) // prints "One"

// Or Match
let result = when(value) {
  equals(1) || equals(2) => "OneOrTwo"
  equals(3) => "Three"
  fallback => "Who Knows?!"
}
print(result) // prints "OneOrTwo"

// Contains match
let result = when(value) {
  containedIn(1...10) => "Between One and Ten"
  fallback => "NOT Between One and Ten"
}
print(result) // prints "Between One and Ten"
```

While this was a fun experiment, there are some significant downsides to using this in practice over using a switch statement:
* There is no help from the compiler about handling all cases. This means that the API for `when` either has to return a `Result<A, Error>` or `A?` to be safe at the call-site. Neither of these cases is very pleasant, so `when` returns the un-wrapped type by force trying the `Result.get()` throwing method. 
* Previous versions of Swift used to allow overloading keywords by using backticks and then being able to call them
without using the backticks but is no longer the case. So, instead of being able to use familiar words like `default`  and `is` for providing functionality in the DSL, different words like `fallback` have to be used
```swift
func `default`<A>(_ value: A) -> A { value }

// How it was able to be called in previous version of Swift
let one = default(1)

// How it is now
let one = `default`(1)
```
