import Foundation

class PortmoneCardResolver {
  var onPaymentFinish: (_: String) -> Void
  
  init(resolver:@escaping (_: String) -> Void) {
    self.onPaymentFinish = resolver
  }
}
