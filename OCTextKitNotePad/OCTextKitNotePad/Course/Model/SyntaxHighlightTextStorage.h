//
//  SyntaxHighlightTextStorage.h
//  OCTextKitNotePad
//
//  Created by ChenZhen on 2019/7/31.
//  Copyright © 2019 ChenZhen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SyntaxHighlightTextStorage : NSTextStorage
- (NSString *)string;
- (void)update;
@end

NS_ASSUME_NONNULL_END
