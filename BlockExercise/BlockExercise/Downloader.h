//
//  Downloader.h
//  BlockExercise
//
//  Created by ChenZhen on 2019/6/3.
//  Copyright © 2019 ChenZhen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Downloader : NSObject

- (void)downloadWithProcessBlock:(void(^)(CGFloat))processBlock
                 completionBlock:(void(^)(void))completionBlock;

@end

NS_ASSUME_NONNULL_END
