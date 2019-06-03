//
//  main.m
//  BlockExercise
//
//  Created by ChenZhen on 2019/6/3.
//  Copyright © 2019 ChenZhen. All rights reserved.
//

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
