declare module 'react-native-ecom-portmone' {
    class PortmoneCardModule {
        static invokePortmoneSdk(lang: string): void;

        static initCardPayment(payeeId: string, phoneNumber: string, billAmount: number): void;

        static initCardSaving(payeeId: string): void;
    }
    export default PortmoneCardModule;
}
