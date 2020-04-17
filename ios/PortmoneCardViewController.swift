
import UIKit
import Foundation
import PortmoneSDKEcom

protocol PortmoneCardDelegate {
  func dismissView()
}

class PortmoneCardViewController: UIViewController {

  public var delegate: PortmoneCardDelegate?

  private let paymentType: PaymentType = .mobilePayment
  private let paymentFlowType: PaymentFlowType = .byCard

  private var paymentPresenter: PaymentPresenter?
  private var presenterDelegate: PortmonePaymentPresenterDelegate?
  private var cardStyle: PortmoneCardStyle?

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    self.cardStyle = PortmoneCardStyle.init()
    self.presenterDelegate = PortmonePaymentPresenterDelegate.init(onDismissSDK: self.dismissView)
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func invokePortmoneSdk(lang: String?) {
    self.paymentPresenter = PaymentPresenter(
      delegate: presenterDelegate!,
      styleSource: cardStyle,
      language: Language(rawValue: lang!) ?? Language.ukrainian)
  }

  @objc public func initCardPayment(payeeId: String, phoneNumber: String, billAmount: Double) {
    let paymentParams = self.getCardPaymentParams(
      payeeId: payeeId,
      phoneNumber: phoneNumber,
      billAmount: billAmount
    )

    self.paymentPresenter?.presentPaymentByCard(on: self, params: paymentParams,showReceiptScreen: true)

  }

    @objc public func initCardSaving(payeeId: String) {

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

  private func dismissView() {
    self.delegate?.dismissView()
  }
}
