//
//  AppRouter.h
//  OCTextKitNotePad
//
//  Created by ChenZhen on 2019/7/31.
//  Copyright © 2019 ChenZhen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppRouter : NSObject

+ (AppRouter *)sharedAppRouter;

@property (nonatomic, strong) UIViewController *rootViewController;

- (void)showViewController:(UIViewController *)viewController;

- (void)hideViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
