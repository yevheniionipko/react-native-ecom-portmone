import Foundation

class PortmoneCardResolver {
  var onPaymentFinish: (_: String) -> Void
  var onPaymentError: (_: Error?) -> Void
  
  init(resolver:@escaping (_: String) -> Void, rejecter: @escaping (_: Error?) -> Void) {
    self.onPaymentError = rejecter
    self.onPaymentFinish = resolver
  }
}
