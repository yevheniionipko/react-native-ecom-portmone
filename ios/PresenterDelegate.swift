
import Foundation
import PortmoneSDKEcom

class PresenterDelegate: PaymentPresenterDelegate {
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
      
      print("Portmone Card Payment Success: Card mask: \n\(mask), \nToken: \n\(token)")
    }
  }
  
  func dismissedSDK() {
    self.onDismissSDK()
  }
}
