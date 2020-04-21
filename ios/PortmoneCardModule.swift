
import UIKit
import Foundation

@objc(PortmoneCardModule)
class PortmoneCardModule: NSObject, RCTBridgeModule {
  private var portmoneCardViewController: PortmoneCardViewController?
  private var rootViewController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
  
  static func moduleName() -> String! {
    return "PortmoneCardModule"
  }
  
  @objc(invokePortmoneSdk:)
  public func invokePortmoneSdk(lang: String) -> Void {
    self.portmoneCardViewController = PortmoneCardViewController()
    
    self.portmoneCardViewController?.invokePortmoneSdk(lang: lang)
    self.rootViewController.present(self.portmoneCardViewController!, animated: true)
  }
  
  @objc(initCardPayment:phoneNumber:billAmount:resolve:rejecter:)
  public func initCardPayment(payeeId: String,
                              phoneNumber: String,
                              billAmount: Int,
                              _ resolve: @escaping RCTPromiseResolveBlock,
                              rejecter reject: @escaping RCTPromiseRejectBlock
  ) {
    self.portmoneCardViewController?.initCardPayment(
      payeeId: payeeId,
      phoneNumber: phoneNumber,
      billAmount: Double(billAmount),
      resolve: { token in
        resolve(token)
    })
  }
  
  @objc(initCardSaving:resolve:rejecter:)
  public func initCardSaving(payeeId: String, _ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    self.portmoneCardViewController?.initCardSaving(
      payeeId: payeeId,
      resolve: { token in
        resolve(token)
    })
  }
}
