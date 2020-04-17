
import Foundation
import PortmoneSDKEcom

class PortmonePaymentPresenterDelegate: PaymentPresenterDelegate {
  private let onDismissSDK: () -> Void

  init(onDismissSDK: @escaping () -> Void) {
    self.onDismissSDK = onDismissSDK
  }

  func didFinishPayment(bill: Bill?, error: Error?) {
    if error != nil {
      print("Portmone Card Payment Error: \(String(describing: error?.localizedDescription))")
    }

    if bill != nil {
        let mask = bill?.cardMask ?? ""
        let token = bill?.token ?? ""
        print("Portmone Card Payment Success: Card mask: \n\(mask)")
        print("Portmone Card Saving Success: Card token: \n\(token)")
    }
  }

  func dismissedSDK() {
    self.onDismissSDK()
  }
}
