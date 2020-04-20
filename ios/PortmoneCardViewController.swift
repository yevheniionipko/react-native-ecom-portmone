import Foundation
import UIKit
import PortmoneSDKEcom

class PortmoneCardViewController: UIViewController {
  private let paymentType: PaymentType = .mobilePayment
  private let paymentFlowType: PaymentFlowType = .byCard
  
  private var lang: String?
  private var paymentPresenter: PaymentPresenter?
  private var cardStyle: PortmoneCardStyle?
  private var resolver: PortmoneCardResolver?
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    self.cardStyle = PortmoneCardStyle.init()
  }
  
  public func invokePortmoneSdk(lang: String?) {
    self.paymentPresenter = PaymentPresenter(
      delegate: self,
      styleSource: cardStyle,
      language: Language(rawValue: lang!) ?? Language.ukrainian)
  }
  
  public func initCardPayment(payeeId: String,
                              phoneNumber: String,
                              billAmount: Double,
                              resolve: @escaping (_ token: String) -> Void,
                              reject: @escaping (_ error: Error? ) -> Void
  ) {
    self.resolver = PortmoneCardResolver(resolver: resolve, rejecter: reject)
    let paymentParams = self.getCardPaymentParams(
      payeeId: payeeId,
      phoneNumber: phoneNumber,
      billAmount: billAmount
    )
    
    self.paymentPresenter?.presentPaymentByCard(
      on: self,
      params: paymentParams,
      showReceiptScreen: true
    )
  }
  
  public func initCardSaving(payeeId: String, resolve: @escaping (_ token: String) -> Void, reject: @escaping (_ error: Error? ) -> Void) {
    self.resolver = PortmoneCardResolver(resolver: resolve, rejecter: reject)
    let savingParams = self.getCardSavingParams(payeeId: payeeId)
    
    self.paymentPresenter?.presentPreauthCard(on: self, params: savingParams)
  }
  
  private func getCardPaymentParams(
    payeeId: String,
    phoneNumber: String,
    billAmount: Double
  ) -> PaymentParams {
    return PaymentParams(
      description: phoneNumber,
      attribute1: "P",
      preauthFlag: false,
      billAmount: billAmount,
      payeeId: payeeId,
      type: paymentType,
      paymentFlowType: paymentFlowType
    )
  }
  
  private func getCardSavingParams(
    payeeId: String
  ) -> PreauthParams {
    return PreauthParams(
      payeeId: payeeId
    )
  }
  
  private func dismissView() -> Void {
    self.dismiss(
      animated: true,
      completion: self.removeFromParent
    )
  }
}

extension PortmoneCardViewController: PortmonePaymentPresenterDelegate {
  func didFinishPayment(bill: Bill?, error: Error?) {
    if error != nil {
      self.resolver?.onPaymentError(error)
      self.resolver = nil
      
    }
    
    if bill != nil {
      let token = bill?.token ?? ""
      self.resolver?.onPaymentFinish(token)
      self.resolver = nil
    }
  }
  
  func dismissedSDK() {
    self.resolver?.onPaymentFinish("")
    self.resolver = nil
    self.dismissView()
  }
}
