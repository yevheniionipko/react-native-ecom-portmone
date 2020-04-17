#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(PortmoneCardModule, NSObject)

RCT_EXTERN_METHOD(invokePortmoneSdk:(NSString *)lang)
RCT_EXTERN_METHOD(initCardPayment:(NSString *)payeeId phoneNumber:(NSString *)phoneNumber billAmount:(NSInteger *)billAmount)
RCT_EXTERN_METHOD(initCardSaving:(NSString *)payeeId)


+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

@end
