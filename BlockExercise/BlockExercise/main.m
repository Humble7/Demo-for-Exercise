//
//  main.m
//  BlockExercise
//
//  Created by ChenZhen on 2019/6/3.
//  Copyright © 2019 ChenZhen. All rights reserved.
//

/**
 在Objective-C中如何声明Block，可以参考下面的链接：
 http://fuckingblocksyntax.com
 */


#import <Foundation/Foundation.h>
#import "Downloader.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Downloader *downloader = [[Downloader alloc] init];
        [downloader downloadWithProcessBlock:^(CGFloat percent) {
            NSLog(@"Downloading:%f", percent);
        } completionBlock:^{
            NSLog(@"Completed");
        }];
        return 0;
    }
}
