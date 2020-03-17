
import UIKit
import Foundation
import PortmoneSDKEcom

@objc
protocol PortmoneModuleDelegate {
  func dismissView(viewController: UIViewController)
}

@objc
class PortmoneModule: UIViewController {
  
  @objc var delegate: PortmoneModuleDelegate?
  
  private let paymentType: PaymentType = .mobilePayment
  private let paymentFlowType: PaymentFlowType = .byCard
  
  private var paymentPresenter: PaymentPresenter?
  private var presenterDelegate: PresenterDelegate?
  private var cardStyle: PortmoneCardStyle?
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    self.cardStyle = PortmoneCardStyle.init()
    self.presenterDelegate = PresenterDelegate.init(onDismissSDK: self.dismissView)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc func invokePortmoneSdk(lang: String?) {
    paymentPresenter = PaymentPresenter(
      delegate: presenterDelegate!,
      styleSource: cardStyle,
      language: Language(rawValue: lang!) ?? Language.ukrainian)
  }
  
  @objc func initCardPayment(payeeId: String, phoneNumber: String, billAmount: Double) {
    let paymentParams = getCardPaymentParams(
      payeeId: payeeId,
      phoneNumber: phoneNumber,
      billAmount: billAmount
    )
    
    paymentPresenter?.presentPaymentByCard(on: self, params: paymentParams,showReceiptScreen: true)
   
  }
  
  private func getCardPaymentParams(
    payeeId: String,
    phoneNumber: String,
    billAmount: Double
  ) -> PaymentParams {
    return PaymentParams(
      description: phoneNumber,
      attribute1: "P",
      billNumber: "SD\(Int(Date().timeIntervalSince1970))",
      preauthFlag: false,
      billAmount: billAmount,
      payeeId: payeeId,
      type: paymentType,
      paymentFlowType: paymentFlowType
    )
    
  }
  
  private func dismissView() {
    delegate?.dismissView(viewController: self)
  }
}
