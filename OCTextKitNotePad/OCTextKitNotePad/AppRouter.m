//
//  AppRouter.m
//  OCTextKitNotePad
//
//  Created by ChenZhen on 2019/7/31.
//  Copyright © 2019 ChenZhen. All rights reserved.
//

#import "AppRouter.h"

@implementation AppRouter {
    NSArray<UINavigationController *> *_navigationStack;
}

+ (instancetype)sharedAppRouter {
    static AppRouter *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[super allocWithZone:NULL] init];
        shared->_navigationStack = @[[[UINavigationController alloc] initWithNavigationBarClass:nil toolbarClass:nil]];
    });
    
    return shared;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedAppRouter];
}

- (instancetype)copy {
    return self;
}

- (instancetype)mutableCopy {
    return self;
}

- (UIViewController *)rootViewController {
    UIViewController *firstViewController = _navigationStack.firstObject;
    if (!firstViewController) { return nil; }
    
    return firstViewController;
}

- (void)showViewController:(UIViewController *)viewController {
    UINavigationController *current = [self currentNavigationController];
    
    if ([viewController isKindOfClass: UIAlertController.class]) {
        [current presentViewController:viewController animated:YES completion:nil];
    } else {
        BOOL animated = current.childViewControllers.count > 0;
        [current pushViewController:viewController animated:animated];
    }
}

- (void)hideViewController:(UIViewController *)viewController {
    UINavigationController *current = [self currentNavigationController];
    
    NSArray<UIViewController *> *stack = current.childViewControllers;
    
    NSUInteger index = [stack indexOfObject:viewController];
    
    if (index >= 0) {
        NSArray<UIViewController *> *newStack;
        NSMutableArray<UIViewController *> *mArray = [NSMutableArray array];
        
        [stack enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx < index) {
                [mArray addObject:obj];
            } else {
                *stop = YES;
            }
        }];
        
        newStack = [mArray copy];
        current.viewControllers = newStack;
    }
}

- (UINavigationController *)currentNavigationController {
    return _navigationStack.lastObject ?: nil;
}

@end
