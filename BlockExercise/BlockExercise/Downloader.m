//
//  Downloader.m
//  BlockExercise
//
//  Created by ChenZhen on 2019/6/3.
//  Copyright © 2019 ChenZhen. All rights reserved.
//

#import "Downloader.h"

@implementation Downloader

- (void)downloadWithProcessBlock:(void(^)(CGFloat))processBlock
                 completionBlock:(void(^)(void))completionBlock {
    for (CGFloat i = 0; i < 1.0; i += 0.25) {
        processBlock(i);
        sleep(1);
    }
    completionBlock();
}

@end
