//
//  TimeIndicatorView.h
//  OCTextKitNotePad
//
//  Created by ChenZhen on 2019/7/31.
//  Copyright © 2019 ChenZhen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeIndicatorView : UIView
- (instancetype)initWithDate:(NSDate *)date;
- (void)updateSize;
- (UIBezierPath *)curvePathWithOrigin:(CGPoint)origin;
@end

NS_ASSUME_NONNULL_END
