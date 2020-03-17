
#import "PortmoneCardModule.h"
#import <React/RCTRootView.h>

@implementation PortmoneCardModule

//  Define React Native Module with Name
RCT_EXPORT_MODULE();

//  Define React Native Method for initializing Portmone
RCT_EXPORT_METHOD(invokePortmoneSdk:(NSString *)lang)
{
  
//  get the main view controller for allocate our card view in main view
  self.rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
//  init portmone view controller
  self.portmoneModule = [[PortmoneModule alloc] init];
//  transfer self to the delegate object in to view controller
  self.portmoneModule.delegate = self;
//  init portmone sdk with language
  [self.portmoneModule invokePortmoneSdkWithLang: lang];
//  allocating portmone view controller in root view controller
  [self.rootViewController presentViewController:self.portmoneModule animated: YES completion:nil];
}

//  Define React Native Method for open Card
RCT_EXPORT_METHOD(initCardPayment:(NSString *)payeeId
                  phoneNumber:(NSString *)phoneNumber
                  billAmount: (nonnull NSNumber *)billAmount)
{
  
//  init portmone card payment
  [self.portmoneModule initCardPaymentWithPayeeId:payeeId
                                 phoneNumber:phoneNumber
                                  billAmount:billAmount.intValue];
}

//  method will remove view controller from parent
- (void)dismissViewWithViewController:(UIViewController * _Nonnull)viewController {
  [viewController dismissViewControllerAnimated:YES completion:^{
     [viewController removeFromParentViewController];
   }];
}

//  Allow run this module in main thread

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

@end
