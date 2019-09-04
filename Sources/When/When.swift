// MARK: - WhenBuilder
@_functionBuilder
public struct WhenBuilder {
  static func buildBlock<A, B>(_ results: (A) -> Result<B, PredicateError>...) -> (A) -> Result<B, PredicateError> {
    { a in
      // A for-loop was chosen so this could short-circuit and return as soon as a success is found.
      // The original implementation reduced `results`, but that method requires iterating over the entire
      // collection.
      for resultFunc in results {
        let result = resultFunc(a)
        
        switch result {
        case .success: return result
        default: continue
        }
      }
      
      return .failure(PredicateError())
    }
  }
}

// MARK: - Helper Types
public typealias Predicate<A> = (A) -> Bool
public struct PredicateError: Error { }

// MARK: - Return Operator
infix operator =>: AssignmentPrecedence

public func =><A, B>(_ lhs: @escaping Predicate<A>, _ rhs: B) -> (A) -> Result<B, PredicateError> {
  { a in
    lhs(a) ? .success(rhs) : .failure(PredicateError())
  }
}

/// This is what allows the `fallback` function to return a default value
public func =><A, B>(_ lhs: @escaping () -> (), _ rhs: B) -> (A) -> Result<B, PredicateError> {
  { _ in .success(rhs) }
}

// MARK: - || Overload
func ||<A>(_ lhs: @escaping Predicate<A>, _ rhs: @escaping Predicate<A>) -> Predicate<A> {
  { a in
    lhs(a) || rhs(a)
  }
}

// MARK: - DSL Functions
public func when<A, B>(_ value: A, @WhenBuilder _ result: () -> (A) -> Result<B, PredicateError>) -> B {
  // Force trying isn't really a great option, but the ergonomics at the callsite for dealing with a result
  // aren't great when it should be assumed that all cases are handled (even though they can't be enforced)
  try! result()(value).get()
}

public func equals<A: Equatable>(_ this: A) -> Predicate<A> {
  { that in
    this == that
  }
}

public func containedIn<A: Sequence>(_ sequence: A) -> Predicate<A.Element> where A.Element: Equatable {
  { element in
    sequence.contains(element)
  }
}

public func fallback() { }
