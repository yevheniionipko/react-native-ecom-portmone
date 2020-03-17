
#import <React/RCTBridgeModule.h>
#import <Foundation/Foundation.h>
#import "EcomPortmone-Swift.h"

NS_ASSUME_NONNULL_BEGIN

//  define that our react native module extending from RCTBridge Class
@interface PortmoneCardModule : NSObject <RCTBridgeModule, PortmoneModuleDelegate>

@property (strong, nonatomic) PortmoneModule *portmoneModule;
@property (strong, nonatomic) UIViewController *rootViewController;

@end

NS_ASSUME_NONNULL_END
