import { NativeModules } from "react-native";
const { PortmoneCardModule: RNModule } = NativeModules;

export default class PortmoneCardModule {
  static invokePortmoneSdk(lang) {
    try {
      if (typeof lang !== 'string') {
        throw new Error('lang must be string');
      }
      return RNModule.invokePortmoneSdk(lang);
    } catch (e) {
      console.info(`PortmoneCardModule => invokePortmoneSdk => ${e}`)
    }
  }
  static initCardPayment(payeeId, phoneNumber, billAmount) {
    try {
      if (typeof payeeId !== 'string') {
        throw new Error('payeeId must be string');
      }
      return RNModule.initCardPayment(payeeId, phoneNumber, billAmount);
    } catch (e) {
      console.info(`PortmoneCardModule => initCardPayment => ${e}`)
    }
  }
  static initCardSaving(payeeId) {
    try {
      if (typeof payeeId !== 'string') {
        throw new Error('payeeId must be string');
      }
      return RNModule.initCardSaving(payeeId);
    } catch (e) {
      console.info(`PortmoneCardModule => initCardSaving => ${e}`)
    }
  }
};
