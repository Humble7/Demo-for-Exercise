//
//  Note.h
//  OCTextKitNotePad
//
//  Created by ChenZhen on 2019/7/31.
//  Copyright © 2019 ChenZhen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Note : NSObject
@property (nonatomic, copy) NSString *contents;
@property (nonatomic, strong) NSDate *timestamp;

- (instancetype)initWithText:(NSString *)text;

/**
 Generate title based on the first line of contents.
 
 @return title
 */
- (NSString *)title;
@end

NS_ASSUME_NONNULL_END
