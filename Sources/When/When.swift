@_functionBuilder
public struct WhenBuilder {
  static func buildBlock<A, B>(_ results: (A) -> Result<B, PredicateError>...) -> (A) -> Result<B, PredicateError> {
    { a in
      for resultFunc in results {
        let result = resultFunc(a)
        switch result {
        case .success: return result
        default: continue
        }
      }
      fatalError()
    }
  }
}

public typealias Predicate<A> = (A) -> Bool
public struct PredicateError: Error { }

infix operator =>: AssignmentPrecedence

public func =><A, B>(_ lhs: @escaping Predicate<A>, _ rhs: B) -> (A) -> Result<B, PredicateError> {
  { a in
    lhs(a) ? .success(rhs) : .failure(PredicateError())
  }
}

public func =><A, B>(_ lhs: @escaping (B) -> B, _ rhs: B) -> (A) -> Result<B, PredicateError> {
  { _ in .success(lhs(rhs)) }
}

public func when<A, B>(_ value: A, @WhenBuilder _ result: () -> (A) -> Result<B, PredicateError>) -> B {
  try! result()(value).get()
}

public func equals<A: Equatable>(_ this: A) -> (A) -> Bool {
  { that in
    this == that
  }
}

public func fallback<A>(_ a: A) -> A { a }
