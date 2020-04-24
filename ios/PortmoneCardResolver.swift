import Foundation

class PortmoneCardResolver {
    var onPaymentFinish: (_: FinishPaymentsData) -> Void
    
    init(resolver:@escaping (_: FinishPaymentsData) -> Void) {
        self.onPaymentFinish = resolver
    }
}
